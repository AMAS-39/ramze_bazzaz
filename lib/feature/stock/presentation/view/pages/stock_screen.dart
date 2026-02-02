import 'package:app/core/error/failure_message_model.dart';
import 'package:app/core/shared/imports.dart';
import 'package:app/feature/stock/data/models/stock_item_model.dart';
import 'package:app/feature/stock/domain/repositories/stock_repository.dart';
import 'package:app/feature/stock/presentation/bloc/stock_bloc.dart';
import 'package:app/feature/stock/presentation/view/widgets/stock_card.dart';
import 'package:app/widgets/form_widgets/form_widgets.dart';
import 'package:app/widgets/status_widgets/export_status_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StockScreen extends StatelessWidget {
  const StockScreen({super.key});

  static const routeName = '/stock';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StockBloc(repository: sl<StockRepositoryAbs>())
        ..add(const StockLoadEvent(silent: false)),
      child: const _StockScreenBody(),
    );
  }
}

class _StockScreenBody extends StatefulWidget {
  const _StockScreenBody();

  @override
  State<_StockScreenBody> createState() => _StockScreenBodyState();
}

class _StockScreenBodyState extends State<_StockScreenBody> {
  late final TextEditingController _searchController;
  final _debouncer = Debouncer(delay: 400);

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debouncer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Trans.stockTitle.trans()),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune),
            onPressed: () async {
              final range = await showDateRangePicker(
                context: context,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                initialDateRange: DateTimeRange(
                  start: context.read<StockBloc>().state.startDate ?? DateTime.now().subtract(const Duration(days: 30)),
                  end: context.read<StockBloc>().state.endDate ?? DateTime.now(),
                ),
              );
              if (range != null) {
                context.read<StockBloc>().add(StockSetDateRangeEvent(start: range.start, end: range.end));
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(kIndent),
            child: GeneralTextFiled(
              controller: _searchController,
              hintText: Trans.stockSearchHint.trans(),
              onChange: (value) {
                _debouncer.run(() {
                  context.read<StockBloc>().add(StockSearchEvent(value ?? ''));
                });
              },
            ),
          ),
          Expanded(
            child: BlocConsumer<StockBloc, StockState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state.status == StockStatus.initial ||
                    state.status == StockStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.status == StockStatus.error) {
                  return FailureScreen(
                    name: Trans.stock.trans(),
                    failure: ServerFailure(
                      error: FailureMessage(
                        message: '',
                        reason: state.errorMessage ?? '',
                        statusCode: 0,
                      ),
                    ),
                    onRefresh: () async => context.read<StockBloc>().add(const StockLoadEvent(silent: false)),
                  );
                }
                if (state.status == StockStatus.loaded && state.stock.isEmpty) {
                  return NoDataFound(
                    onRefresh: () async => context.read<StockBloc>().add(const StockClearSearchEvent()),
                    text: Trans.stockNoStockFound.trans(context: context),
                  );
                }
                if (state.status == StockStatus.loaded) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<StockBloc>().add(const StockLoadEvent(silent: false));
                      await context.read<StockBloc>().stream.first;
                    },
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: kIndent, vertical: 8),
                      itemCount: state.stock.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final item = state.stock[index];
                        return StockCard(item: item);
                      },
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:app/feature/payments/data/models/payment_details_model.dart';
import 'package:app/feature/payments/presentation/blocs/view_one/payment_bloc.dart';
import 'package:app/feature/payments/presentation/view/widgets/payment_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentDetailsScreen extends StatefulWidget {
  const PaymentDetailsScreen(
      {super.key, required this.id, required this.name, required this.payment});
  final int id;
  final String name;
  final PaymentDetailsModel payment;

  @override
  State<PaymentDetailsScreen> createState() => _PaymentDetailsScreenState();
}

class _PaymentDetailsScreenState extends State<PaymentDetailsScreen> {
  // @override
  // void initState() {
  //   SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
  //     onePaymentBloc.add(OnePaymentGetEvent(id: widget.id));
  //   });
  //   super.initState();
  // }

  OnePaymentBloc onePaymentBloc = OnePaymentBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => onePaymentBloc,
      child: Scaffold(
        appBar: AppBar(title: Text(widget.name)),
        body: SizedBox(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            // children: [
            child: PaymentDetailsWidget(payment: widget.payment)
            // Expanded(
            //     child: BlocConsumer<OnePaymentBloc, OnePaymentState>(
            //         listener: (context, status) {
            //   if (status is OnePaymentLoadedState && (status).failure != null) {
            //     showFailedFlashBar(status.failure!.error.reason);
            //   }
            //   logger("status $status");
            // }, builder: (context, status) {
            //   if (status is OnePaymentLoadingState ||
            //       status is OnePaymentInitialState) {
            //     return const LoadingWidget();
            //   } else if (status is OnePaymentErrorState) {
            //     return FailureScreen( name:Trans.payments.trans(),
            //         failure: status.failure, onRefresh: _onRefresh);
            //   } else if (status is PaymentsEmptyState) {
            //     return NoDataFound(
            //         onRefresh: _onRefresh,
            //         text: Trans.noDataFound.trans(
            //             args: [Trans.payments.trans()], context: context));
            //   } else if (status is OnePaymentLoadedState) {
            //     return Column(children: [
            //       Expanded(
            //           child: RefreshIndicator(
            //         onRefresh: _onRefresh,
            //         child: PaymentDetailsWidget(payment: status.data),
            //       ))
            //     ]);
            //   }
            //   return const SizedBox.shrink();
            // })),
            // ],
            ),
      ),
    );
  }

  // Future<void> _onRefresh() async {
  //   onePaymentBloc.add(OnePaymentGetEvent(id: widget.id));
  //   await onePaymentBloc.stream.first;
  // }
}

import 'package:app/core/shared/imports.dart';
import 'package:app/feature/account/data/repo/account_repo.dart';
import 'package:app/feature/reports/data/datasources/reports_remote_data_source.dart';
import 'package:app/feature/reports/data/models/customer_statement_model.dart';
import 'package:app/feature/reports/domain/repositories/reports_repository.dart';

class ReportsRepositoryImpl implements ReportsRepository {
  final ReportsRemoteDataSource remote;
  final AccountRepo accountRepo;

  ReportsRepositoryImpl({required this.remote, required this.accountRepo});

  static const _platform = 'mobile';
  static const _end = 2000;

  @override
  Future<Either<Failure, CustomerAccountStatement>> fetchCustomerAccountStatement() {
    return _fetchStatement(EndPoints.customerAccountStatement, isPayInstead: false);
  }

  @override
  Future<Either<Failure, CustomerAccountStatement>> fetchCustomerPayInsteadStatement() {
    return _fetchStatement(EndPoints.customerPayInsteadStatement, isPayInstead: true);
  }

  Future<Either<Failure, CustomerAccountStatement>> _fetchStatement(
    String endpoint, {
    required bool isPayInstead,
  }) async {
    logger("STATEMENTS: _fetchStatement endpoint=$endpoint, isPayInstead=$isPayInstead");
    final query = <String, dynamic>{
      'platform': _platform,
      'end': _end,
    };
    final result = await remote.fetchStatement(
      endpoint: endpoint,
      queryParameters: query,
      name: isPayInstead ? Trans.customerPayInsteadStatement.trans() : Trans.customerAccountStatement.trans(),
    );
    if (result.isLeft()) {
      logger("STATEMENTS: remote.fetchStatement returned LEFT -> ${result.getLeft()}");
      return Left(result.getLeft()!);
    }
    final body = result.getRight(() => null);
    logger("STATEMENTS: remote.fetchStatement returned RIGHT of type ${body.runtimeType}");
    CustomerAccountStatement statement;
    if (body is List) {
      final items = body
          .map((e) => CustomerStatementItem.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList();
      final name = await _getCustomerNameFallback();
      double? initialLoan;
      double? currentLoan;
      double? initialPayInstead;
      double? currentPayInstead;
      if (items.isNotEmpty) {
        final firstBalance = items.first.balance ?? items.first.price ?? 0.0;
        final lastBalance = items.last.balance ?? items.last.price ?? 0.0;
        if (isPayInstead) {
          initialPayInstead = firstBalance;
          currentPayInstead = lastBalance;
        } else {
          initialLoan = firstBalance;
          currentLoan = lastBalance;
        }
      }
      statement = CustomerAccountStatement(
        customerName: name,
        initialLoan: initialLoan,
        currentLoan: currentLoan,
        initialPayInstead: initialPayInstead,
        currentPayInstead: currentPayInstead,
        items: items,
      );
    } else if (body is Map<String, dynamic>) {
      statement = CustomerAccountStatement.fromJson(body);
      if (statement.customerName == null ||
          CustomerAccountStatement.looksLikeUsername(statement.customerName!)) {
        final name = await _getCustomerNameFallback();
        statement = CustomerAccountStatement(
          customerName: name,
          initialLoan: statement.initialLoan,
          currentLoan: statement.currentLoan,
          initialPayInstead: statement.initialPayInstead,
          currentPayInstead: statement.currentPayInstead,
          items: statement.items,
        );
      }
    } else {
      statement = const CustomerAccountStatement(items: []);
    }
    final normalized = _normalizeItems(statement);
    return Right(normalized);
  }

  Future<String?> _getCustomerNameFallback() async {
    final infoResult = await accountRepo.getInfo();
    return infoResult.getRight(() => null)?.name;
  }

  /// Single pass: resolve amount (price/withdraw/deposit with sign), fill running balance.
  CustomerAccountStatement _normalizeItems(CustomerAccountStatement statement) {
    final items = statement.items;
    if (items.isEmpty) return statement;
    double runningBalance = statement.initialLoan ?? statement.initialPayInstead ?? 0.0;
    final normalized = <CustomerStatementItem>[];
    for (final item in items) {
      final amount = item.amount;
      runningBalance += amount;
      normalized.add(item.copyWith(balance: runningBalance));
    }
    double? currentLoan = statement.currentLoan;
    double? currentPayInstead = statement.currentPayInstead;
    if (normalized.isNotEmpty) {
      final last = normalized.last.balance ?? 0;
      if (statement.initialLoan != null) currentLoan = last;
      if (statement.initialPayInstead != null) currentPayInstead = last;
    }
    return CustomerAccountStatement(
      customerName: statement.customerName,
      initialLoan: statement.initialLoan,
      currentLoan: currentLoan,
      initialPayInstead: statement.initialPayInstead,
      currentPayInstead: currentPayInstead,
      items: normalized,
    );
  }
}

import 'package:app/core/shared/imports.dart';
import 'package:app/feature/reports/data/models/customer_statement_model.dart';

abstract class ReportsRepository {
  Future<Either<Failure, CustomerAccountStatement>> fetchCustomerAccountStatement();
  Future<Either<Failure, CustomerAccountStatement>> fetchCustomerPayInsteadStatement();
}

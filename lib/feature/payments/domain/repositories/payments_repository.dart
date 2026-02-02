
import 'package:app/core/generics/generic_repository.dart';
import 'package:app/feature/payments/data/models/payment_details_model.dart';
import 'package:app/feature/payments/data/models/payments_filter.dart';
import 'package:app/feature/payments/data/models/payments_model.dart';
import 'package:app/feature/payments/data/models/create_payment_model.dart';
import 'package:app/feature/payments/data/models/update_payment_model.dart';
import 'package:app/core/shared/imports.dart';

abstract class PaymentsRepositoryAbs
    implements 
        GetOneGenericRepository<PaymentDetailsModel? ,int>,
        CreateGenericRepository<CreatePaymentModel, PaymentModel?>,
        UpdateGenericRepository<UpdatePaymentModel, PaymentModel?>,
        DeleteGenericRepository<UnitModel?,int>,
        GetAllGenericRepository<PaymentModel, PaymentsFilterModel> 
     {
 
    }

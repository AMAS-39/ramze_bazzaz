
import 'package:app/core/generics/generic_repository.dart';
import 'package:app/feature/pay_insteads/data/models/pay_instead_details_model.dart';
import 'package:app/feature/pay_insteads/data/models/pay_insteads_filter.dart';
import 'package:app/feature/pay_insteads/data/models/pay_insteads_model.dart';
import 'package:app/feature/pay_insteads/data/models/create_pay_instead_model.dart';
import 'package:app/feature/pay_insteads/data/models/update_pay_instead_model.dart';
import 'package:app/core/shared/imports.dart';

abstract class PayInsteadsRepositoryAbs
    implements 
        GetOneGenericRepository<PayInsteadDetailsModel? ,int>,
        CreateGenericRepository<CreatePayInsteadModel, PayInsteadModel?>,
        UpdateGenericRepository<UpdatePayInsteadModel, PayInsteadModel?>,
        DeleteGenericRepository<UnitModel?,int>,
        GetAllGenericRepository<PayInsteadModel, PayInsteadsFilterModel> 
     {
 
    }

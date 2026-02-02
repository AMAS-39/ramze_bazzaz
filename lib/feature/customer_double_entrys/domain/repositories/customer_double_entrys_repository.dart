import 'package:app/core/generics/generic_repository.dart';
import 'package:app/core/shared/imports.dart';
import 'package:app/feature/customer_double_entrys/data/models/create_customer_double_entry_model.dart';
import 'package:app/feature/customer_double_entrys/data/models/customer_double_entry_details_model.dart';
import 'package:app/feature/customer_double_entrys/data/models/customer_double_entrys_filter.dart';
import 'package:app/feature/customer_double_entrys/data/models/customer_double_entrys_model.dart';
import 'package:app/feature/customer_double_entrys/data/models/update_customer_double_entry_model.dart';

abstract class CustomerDoubleEntrysRepositoryAbs
    implements
        GetOneGenericRepository<CustomerDoubleEntryDetailsModel?, int>,
        CreateGenericRepository<CreateCustomerDoubleEntryModel,
            CustomerDoubleEntryModel?>,
        UpdateGenericRepository<UpdateCustomerDoubleEntryModel,
            CustomerDoubleEntryModel?>,
        DeleteGenericRepository<UnitModel?, int>,
        GetAllGenericRepository<CustomerDoubleEntryModel,
            CustomerDoubleEntrysFilterModel> {}

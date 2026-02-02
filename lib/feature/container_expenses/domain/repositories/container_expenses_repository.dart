
import 'package:app/core/generics/generic_repository.dart';
import 'package:app/feature/container_expenses/data/models/container_expense_details_model.dart';
import 'package:app/feature/container_expenses/data/models/container_expenses_filter.dart';
import 'package:app/feature/container_expenses/data/models/container_expenses_model.dart';
import 'package:app/feature/container_expenses/data/models/create_container_expense_model.dart';
import 'package:app/feature/container_expenses/data/models/update_container_expense_model.dart';
import 'package:app/core/shared/imports.dart';

abstract class ContainerExpensesRepositoryAbs
    implements 
        GetOneGenericRepository<ContainerExpenseDetailsModel? ,int>,
        CreateGenericRepository<CreateContainerExpenseModel, ContainerExpenseModel?>,
        UpdateGenericRepository<UpdateContainerExpenseModel, ContainerExpenseModel?>,
        DeleteGenericRepository<UnitModel?,int>,
        GetAllGenericRepository<ContainerExpenseModel, ContainerExpensesFilterModel> 
     {
 
    }

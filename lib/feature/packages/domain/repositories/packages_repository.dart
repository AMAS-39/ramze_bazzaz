
import 'package:app/core/generics/generic_repository.dart';
import 'package:app/feature/packages/data/models/package_details_model.dart';
import 'package:app/feature/packages/data/models/packages_filter.dart';
import 'package:app/feature/packages/data/models/packages_model.dart';
import 'package:app/feature/packages/data/models/create_package_model.dart';
import 'package:app/feature/packages/data/models/update_package_model.dart';
import 'package:app/core/shared/imports.dart';

abstract class PackagesRepositoryAbs
    implements 
        GetOneGenericRepository<PackageDetailsModel? ,int>,
        CreateGenericRepository<CreatePackageModel, PackageModel?>,
        UpdateGenericRepository<UpdatePackageModel, PackageModel?>,
        DeleteGenericRepository<UnitModel?,int>,
        GetAllGenericRepository<PackageModel, PackagesFilterModel> 
     {
 
    }

import 'package:app/core/generics/generic_repository.dart';
import 'package:app/core/shared/imports.dart';
import 'package:app/feature/containers/data/models/container_details_model.dart';
import 'package:app/feature/containers/data/models/containers_filter.dart';
import 'package:app/feature/containers/data/models/containers_model.dart';
import 'package:app/feature/containers/data/models/create_container_model.dart';
import 'package:app/feature/containers/data/models/update_container_model.dart';

abstract class ContainersRepositoryAbs
    implements
        GetOneGenericRepository<ContainerDetailsModel?, String>,
        CreateGenericRepository<CreateContainerModel, ContainerModel?>,
        UpdateGenericRepository<UpdateContainerModel, ContainerModel?>,
        DeleteGenericRepository<UnitModel?, int>,
        GetAllGenericRepository<ContainerModel, ContainersFilterModel> {}

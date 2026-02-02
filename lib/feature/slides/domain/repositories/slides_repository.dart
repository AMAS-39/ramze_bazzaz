
import 'package:app/core/generics/generic_repository.dart';
import 'package:app/feature/slides/data/models/slide_details_model.dart';
import 'package:app/feature/slides/data/models/slides_filter.dart';
import 'package:app/feature/slides/data/models/slides_model.dart';
import 'package:app/feature/slides/data/models/create_slide_model.dart';
import 'package:app/feature/slides/data/models/update_slide_model.dart';
import 'package:app/core/shared/imports.dart';

abstract class SlidesRepositoryAbs
    implements 
        GetOneGenericRepository<SlideDetailsModel? ,int>,
        CreateGenericRepository<CreateSlideModel, SlideModel?>,
        UpdateGenericRepository<UpdateSlideModel, SlideModel?>,
        DeleteGenericRepository<UnitModel?,int>,
        GetAllGenericRepository<SlideModel, SlidesFilterModel> 
     {
 
    }

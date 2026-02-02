
import 'package:app/core/generics/generic_repository.dart';
import 'package:app/feature/attachments/data/models/attachment_details_model.dart';
import 'package:app/feature/attachments/data/models/attachments_filter.dart';
import 'package:app/feature/attachments/data/models/attachments_model.dart';
import 'package:app/feature/attachments/data/models/create_attachment_model.dart';
import 'package:app/feature/attachments/data/models/update_attachment_model.dart';
import 'package:app/core/shared/imports.dart';

abstract class AttachmentsRepositoryAbs
    implements 
        GetOneGenericRepository<AttachmentDetailsModel? ,int>,
        CreateGenericRepository<CreateAttachmentModel, AttachmentModel?>,
        UpdateGenericRepository<UpdateAttachmentModel, AttachmentModel?>,
        DeleteGenericRepository<UnitModel?,int>,
        GetAllGenericRepository<AttachmentModel, AttachmentsFilterModel> 
     {
 
    }

import 'package:equatable/equatable.dart';

class UpdateAttachmentModel extends Equatable {
  const UpdateAttachmentModel({
    required this.id,
    required this.name,
 
  });

  final  int id;
  final String name;
 
  factory UpdateAttachmentModel.fromMap(Map<String, dynamic> json) => UpdateAttachmentModel(
        id: json["id"],
        name: json["name"],
        
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
         
      };

  @override
  List<Object?> get props => [
        id,
        name,
       
      ];
}

import 'package:equatable/equatable.dart';

class CreateAttachmentModel extends Equatable {
  const CreateAttachmentModel({
    required this.name,
 
  });

  final String name;
 
  factory CreateAttachmentModel.fromMap(Map<String, dynamic> json) => CreateAttachmentModel(
        name: json["name"],
        
      );

  Map<String, dynamic> toMap() => {
        "name": name,
         
      };

  @override
  List<Object?> get props => [
        name
       
      ];
}

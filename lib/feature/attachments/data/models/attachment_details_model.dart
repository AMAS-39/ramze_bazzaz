import 'package:equatable/equatable.dart';

class AttachmentDetailsModel extends Equatable {
  const AttachmentDetailsModel({
    required this.id,
    required this.name,
 
  });

  final  int id;
  final String name;
 
  factory AttachmentDetailsModel.fromMap(Map<String, dynamic> json) => AttachmentDetailsModel(
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

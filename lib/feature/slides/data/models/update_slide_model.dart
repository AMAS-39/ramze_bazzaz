import 'package:equatable/equatable.dart';

class UpdateSlideModel extends Equatable {
  const UpdateSlideModel({
    required this.id,
    required this.name,
 
  });

  final  int id;
  final String name;
 
  factory UpdateSlideModel.fromMap(Map<String, dynamic> json) => UpdateSlideModel(
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

import 'package:equatable/equatable.dart';

class UpdateContainerModel extends Equatable {
  const UpdateContainerModel({
    required this.id,
    required this.name,
 
  });

  final  int id;
  final String name;
 
  factory UpdateContainerModel.fromMap(Map<String, dynamic> json) => UpdateContainerModel(
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

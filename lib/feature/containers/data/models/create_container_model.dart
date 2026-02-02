import 'package:equatable/equatable.dart';

class CreateContainerModel extends Equatable {
  const CreateContainerModel({
    required this.name,
 
  });

  final String name;
 
  factory CreateContainerModel.fromMap(Map<String, dynamic> json) => CreateContainerModel(
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

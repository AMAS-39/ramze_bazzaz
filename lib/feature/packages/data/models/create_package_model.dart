import 'package:equatable/equatable.dart';

class CreatePackageModel extends Equatable {
  const CreatePackageModel({
    required this.name,
 
  });

  final String name;
 
  factory CreatePackageModel.fromMap(Map<String, dynamic> json) => CreatePackageModel(
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

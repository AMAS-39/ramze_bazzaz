import 'package:equatable/equatable.dart';

class UpdatePackageModel extends Equatable {
  const UpdatePackageModel({
    required this.id,
    required this.name,
 
  });

  final  int id;
  final String name;
 
  factory UpdatePackageModel.fromMap(Map<String, dynamic> json) => UpdatePackageModel(
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

import 'package:equatable/equatable.dart';

class PackageDetailsModel extends Equatable {
  const PackageDetailsModel({
    required this.id,
    required this.name,
 
  });

  final  int id;
  final String name;
 
  factory PackageDetailsModel.fromMap(Map<String, dynamic> json) => PackageDetailsModel(
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

import 'package:equatable/equatable.dart';

class CustomerDoubleEntryDetailsModel extends Equatable {
  const CustomerDoubleEntryDetailsModel({
    required this.id,
    required this.name,
 
  });

  final  int id;
  final String name;
 
  factory CustomerDoubleEntryDetailsModel.fromMap(Map<String, dynamic> json) => CustomerDoubleEntryDetailsModel(
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

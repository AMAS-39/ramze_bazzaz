import 'package:equatable/equatable.dart';

class UpdateCustomerDoubleEntryModel extends Equatable {
  const UpdateCustomerDoubleEntryModel({
    required this.id,
    required this.name,
 
  });

  final  int id;
  final String name;
 
  factory UpdateCustomerDoubleEntryModel.fromMap(Map<String, dynamic> json) => UpdateCustomerDoubleEntryModel(
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

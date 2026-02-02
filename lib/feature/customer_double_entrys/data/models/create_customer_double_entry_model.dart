import 'package:equatable/equatable.dart';

class CreateCustomerDoubleEntryModel extends Equatable {
  const CreateCustomerDoubleEntryModel({
    required this.name,
 
  });

  final String name;
 
  factory CreateCustomerDoubleEntryModel.fromMap(Map<String, dynamic> json) => CreateCustomerDoubleEntryModel(
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

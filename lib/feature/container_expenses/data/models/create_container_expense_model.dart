import 'package:equatable/equatable.dart';

class CreateContainerExpenseModel extends Equatable {
  const CreateContainerExpenseModel({
    required this.name,
 
  });

  final String name;
 
  factory CreateContainerExpenseModel.fromMap(Map<String, dynamic> json) => CreateContainerExpenseModel(
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

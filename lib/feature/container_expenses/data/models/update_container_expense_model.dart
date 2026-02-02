import 'package:equatable/equatable.dart';

class UpdateContainerExpenseModel extends Equatable {
  const UpdateContainerExpenseModel({
    required this.id,
    required this.name,
 
  });

  final  int id;
  final String name;
 
  factory UpdateContainerExpenseModel.fromMap(Map<String, dynamic> json) => UpdateContainerExpenseModel(
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

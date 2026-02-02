import 'package:equatable/equatable.dart';

class UpdatePayInsteadModel extends Equatable {
  const UpdatePayInsteadModel({
    required this.id,
    required this.name,
 
  });

  final  int id;
  final String name;
 
  factory UpdatePayInsteadModel.fromMap(Map<String, dynamic> json) => UpdatePayInsteadModel(
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

import 'package:equatable/equatable.dart';

class CreatePayInsteadModel extends Equatable {
  const CreatePayInsteadModel({
    required this.name,
 
  });

  final String name;
 
  factory CreatePayInsteadModel.fromMap(Map<String, dynamic> json) => CreatePayInsteadModel(
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

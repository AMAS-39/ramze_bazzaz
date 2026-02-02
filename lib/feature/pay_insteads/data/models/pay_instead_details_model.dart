import 'package:equatable/equatable.dart';

class PayInsteadDetailsModel extends Equatable {
  const PayInsteadDetailsModel({
    required this.id,
    required this.name,
 
  });

  final  int id;
  final String name;
 
  factory PayInsteadDetailsModel.fromMap(Map<String, dynamic> json) => PayInsteadDetailsModel(
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

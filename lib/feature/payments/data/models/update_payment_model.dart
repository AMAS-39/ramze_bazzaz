import 'package:equatable/equatable.dart';

class UpdatePaymentModel extends Equatable {
  const UpdatePaymentModel({
    required this.id,
    required this.name,
 
  });

  final  int id;
  final String name;
 
  factory UpdatePaymentModel.fromMap(Map<String, dynamic> json) => UpdatePaymentModel(
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

import 'package:equatable/equatable.dart';

class CreatePaymentModel extends Equatable {
  const CreatePaymentModel({
    required this.name,
 
  });

  final String name;
 
  factory CreatePaymentModel.fromMap(Map<String, dynamic> json) => CreatePaymentModel(
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

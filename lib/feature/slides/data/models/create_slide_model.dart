import 'package:equatable/equatable.dart';

class CreateSlideModel extends Equatable {
  const CreateSlideModel({
    required this.name,
 
  });

  final String name;
 
  factory CreateSlideModel.fromMap(Map<String, dynamic> json) => CreateSlideModel(
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

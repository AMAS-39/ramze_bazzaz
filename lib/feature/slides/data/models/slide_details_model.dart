import 'package:equatable/equatable.dart';

class SlideDetailsModel extends Equatable {
  const SlideDetailsModel({
    required this.id,
    required this.name,
 
  });

  final  int id;
  final String name;
 
  factory SlideDetailsModel.fromMap(Map<String, dynamic> json) => SlideDetailsModel(
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

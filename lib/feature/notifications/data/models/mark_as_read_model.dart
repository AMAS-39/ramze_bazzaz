import 'package:equatable/equatable.dart';

class MarkNotificationAsReadModel extends Equatable {
  const MarkNotificationAsReadModel({
    required this.id,
  });

  final String id;

  Map<String, dynamic> toMap() => {
        "id": id,
      };

  @override
  List<Object?> get props => [id];
}

import 'package:equatable/equatable.dart';

class ContainerDetailsModel extends Equatable {
  final DateTime date;
  final DateTime? acceptedDate;
  final DateTime? shippingDate;
  final DateTime? arrivalDate;
  final String containerStatus;
  final String containerTypeName;
  final int containerTypeId;
  final String number;
  final String? description;
  final String? awbNumber;
  final String? line;
  final String? faxNumber;
  final String? originCountryName;
  final int originCountryId;
  final String? destinationCountryName;
  final int destinationCountryId;
  final String? attachment;
  final String? note;
  final int id;
  const ContainerDetailsModel({
    required this.date,
    this.acceptedDate,
    this.shippingDate,
    this.arrivalDate,
    required this.containerStatus,
    required this.containerTypeName,
    required this.containerTypeId,
    required this.number,
    this.description,
    this.awbNumber,
    this.line,
    this.faxNumber,
    this.originCountryName,
    required this.originCountryId,
    this.destinationCountryName,
    required this.destinationCountryId,
    this.attachment,
    this.note,
    required this.id,
  });

  ContainerDetailsModel copyWith({
    DateTime? date,
    DateTime? acceptedDate,
    DateTime? shippingDate,
    DateTime? arrivalDate,
    String? containerStatus,
    String? containerTypeName,
    int? containerTypeId,
    String? number,
    String? description,
    String? awbNumber,
    String? line,
    String? faxNumber,
    String? originCountryName,
    int? originCountryId,
    String? destinationCountryName,
    int? destinationCountryId,
    String? attachment,
    String? note,
    int? id,
  }) {
    return ContainerDetailsModel(
      date: date ?? this.date,
      acceptedDate: acceptedDate ?? this.acceptedDate,
      shippingDate: shippingDate ?? this.shippingDate,
      arrivalDate: arrivalDate ?? this.arrivalDate,
      containerStatus: containerStatus ?? this.containerStatus,
      containerTypeName: containerTypeName ?? this.containerTypeName,
      containerTypeId: containerTypeId ?? this.containerTypeId,
      number: number ?? this.number,
      description: description ?? this.description,
      awbNumber: awbNumber ?? this.awbNumber,
      line: line ?? this.line,
      faxNumber: faxNumber ?? this.faxNumber,
      originCountryName: originCountryName ?? this.originCountryName,
      originCountryId: originCountryId ?? this.originCountryId,
      destinationCountryName:
          destinationCountryName ?? this.destinationCountryName,
      destinationCountryId: destinationCountryId ?? this.destinationCountryId,
      attachment: attachment ?? this.attachment,
      note: note ?? this.note,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date.toIso8601String(),
      'acceptedDate': acceptedDate?.toIso8601String(),
      'shippingDate': shippingDate?.toIso8601String(),
      'arrivalDate': arrivalDate?.toIso8601String(),
      'containerStatus': containerStatus,
      'containerTypeName': containerTypeName,
      'containerTypeId': containerTypeId,
      'number': number,
      'description': description,
      'awbNumber': awbNumber,
      'line': line,
      'faxNumber': faxNumber,
      'originCountryName': originCountryName,
      'originCountryId': originCountryId,
      'destinationCountryName': destinationCountryName,
      'destinationCountryId': destinationCountryId,
      'attachment': attachment,
      'note': note,
      'id': id,
    };
  }

  factory ContainerDetailsModel.fromMap(Map<String, dynamic> map) {
    return ContainerDetailsModel(
      date: DateTime.parse(map['date'] ?? ""),
      acceptedDate: map['acceptedDate'] != null
          ? DateTime.tryParse(map['acceptedDate'] ?? "")
          : null,
      shippingDate: map['shippingDate'] != null
          ? DateTime.tryParse(map['shippingDate'] ?? "")
          : null,
      arrivalDate: map['arrivalDate'] != null
          ? DateTime.tryParse(map['arrivalDate'] ?? "")
          : null,
      containerStatus: map['containerStatus'] ?? '',
      containerTypeName: map['containerTypeName'] ?? '',
      containerTypeId: map['containerTypeId']?.toInt() ?? 0,
      number: map['number'] ?? '',
      description: map['description'],
      awbNumber: map['awbNumber'],
      line: map['line'],
      faxNumber: map['faxNumber'],
      originCountryName: map['originCountryName'],
      originCountryId: map['originCountryId']?.toInt() ?? 0,
      destinationCountryName: map['destinationCountryName'],
      destinationCountryId: map['destinationCountryId']?.toInt() ?? 0,
      attachment: map['attachment'],
      note: map['note'],
      id: map['id']?.toInt() ?? 0,
    );
  }

  @override
  String toString() {
    return 'ContainerDetailsModel(date: $date, acceptedDate: $acceptedDate, shippingDate: $shippingDate, arrivalDate: $arrivalDate, containerStatus: $containerStatus, containerTypeName: $containerTypeName, containerTypeId: $containerTypeId, number: $number, description: $description, awbNumber: $awbNumber, line: $line, faxNumber: $faxNumber, originCountryName: $originCountryName, originCountryId: $originCountryId, destinationCountryName: $destinationCountryName, destinationCountryId: $destinationCountryId, attachment: $attachment, note: $note, id: $id)';
  }

  @override
  List<Object?> get props {
    return [
      date,
      acceptedDate,
      shippingDate,
      arrivalDate,
      containerStatus,
      containerTypeName,
      containerTypeId,
      number,
      description,
      awbNumber,
      line,
      faxNumber,
      originCountryName,
      originCountryId,
      destinationCountryName,
      destinationCountryId,
      attachment,
      note,
      id,
    ];
  }
}

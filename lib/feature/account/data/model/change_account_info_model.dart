
class ChangeAccountInfo {
  final String firstName;
  final String middleName;
  final String lastName;

  ChangeAccountInfo({
    required this.firstName,
    required this.middleName,
    required this.lastName,
  });

  ChangeAccountInfo copyWith({
    String? firstName,
    String? middleName,
    String? lastName,
  }) =>
      ChangeAccountInfo(
        firstName: firstName ?? this.firstName,
        middleName: middleName ?? this.middleName,
        lastName: lastName ?? this.lastName,
      );

  factory ChangeAccountInfo.fromJson(Map<String, dynamic> json) =>
      ChangeAccountInfo(
        firstName: json["firstName"],
        middleName: json["middleName"],
        lastName: json["lastName"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "middleName": middleName,
        "lastName": lastName,
      };
}

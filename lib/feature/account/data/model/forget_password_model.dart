class ForgetPasswordModel {
  final String email;

  ForgetPasswordModel({
    required this.email,
  });

  ForgetPasswordModel copyWith({
    String? email,
  }) =>
      ForgetPasswordModel(
        email: email ?? this.email,
      );

  Map<String, dynamic> toMap() => {
        "email": email,
      };
}

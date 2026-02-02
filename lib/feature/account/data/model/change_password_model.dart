class ChangePasswordModel {
  final String currentPassword;
  final String password;
  final String confirmPassword;

  ChangePasswordModel({
    required this.currentPassword,
    required this.password,
    required this.confirmPassword,
  });

  ChangePasswordModel copyWith({
    String? currentPassword,
    String? password,
    String? confirmPassword,
  }) =>
      ChangePasswordModel(
        currentPassword: currentPassword ?? this.currentPassword,
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword,
      );

  Map<String, dynamic> toJson() => {
        "current_password": currentPassword,
        "password": password,
        "type": "password",
        "password_confirmation": confirmPassword,
      };
}

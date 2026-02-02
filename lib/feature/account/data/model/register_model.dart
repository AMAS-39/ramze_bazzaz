class RegisterModel {
  final String name;
  final String email;
  final String password;
  final String cPassword;
  RegisterModel({
    required this.name,
    required this.email,
    required this.password,
    required this.cPassword,
  });

  RegisterModel copyWith({
    String? name,
    String? email,
    String? password,
    String? cPassword,
  }) {
    return RegisterModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      cPassword: cPassword ?? this.cPassword,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'c_password': cPassword,
    };
  }
}

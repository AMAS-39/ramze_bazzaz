import 'dart:convert';

class LoginRequestModel {
  LoginRequestModel({
    required this.userName,
    required this.password,
  });

  final String userName;
  final String password;

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'password': password,
    };
  }

  LoginRequestModel copyWith({
    String? userName,
    String? password,
  }) {
    return LoginRequestModel(
      userName: userName ?? this.userName,
      password: password ?? this.password,
    );
  }

  factory LoginRequestModel.fromMap(Map<String, dynamic> map) {
    return LoginRequestModel(
      userName: map['userName'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginRequestModel.fromJson(String source) => LoginRequestModel.fromMap(json.decode(source));

  @override
  String toString() => 'LoginRequestModel(userName: $userName, password: $password)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is LoginRequestModel &&
      other.userName == userName &&
      other.password == password;
  }

  @override
  int get hashCode => userName.hashCode ^ password.hashCode;
}

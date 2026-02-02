import 'package:app/feature/account/data/model/account_model.dart';

class UpdateAccountRep {
  final AccountModel data;
  UpdateAccountRep({
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'data': data.toMap(),
    };
  }

  factory UpdateAccountRep.fromMap(Map<String, dynamic> map) {
    return UpdateAccountRep(
      data: AccountModel.fromMap(map['data']),
    );
  }
}

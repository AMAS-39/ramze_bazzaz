import 'package:app/core/shared/imports.dart';

String? validateAddress(String? value) {
  if (value == null || value.trim().isEmpty) {
    return Trans.required.trans();
  } else {
    return null;
  }
}

String? validateDate(String? value) {
  if (value == null || value.trim().isEmpty) {
    return Trans.required.trans();
  } else {
    return null;
  }
}

String? validateTitle(String? value) {
  if (value == null || value.trim().isEmpty) {
    return Trans.required.trans();
  } else {
    return null;
  }
}

String? validateDropDown(String? value) {
  if (value == null || value.trim().isEmpty) {
    return Trans.required.trans();
  } else {
    return null;
  }
}

String? validateNote(String? value) {
  if (value == null || value.trim().isEmpty) {
    return Trans.required.trans();
  } else {
    return null;
  }
}

String? validatePrice(String? value) {
  if (value == null || value.trim().isEmpty || value.isEmpty) {
    return Trans.required.trans();
  } else if (checkDouble(value) <= 0) {
    return Trans.valueMustBeMoreThanZeros.trans();
  }
  return null;
}

String? validateName(String? value) {
  if (value == null || value.trim().isEmpty || value.isEmpty) {
    return Trans.required.trans();
  }
  return null;
}

String? validateEmail(String? value) {
  if (value == null || value.trim().isEmpty || value.isEmpty) {
    return Trans.required.trans();
  } else if (value.trim().length < 3) {
    return Trans.tooShort.trans();
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.trim().isEmpty || value.isEmpty) {
    return Trans.required.trans();
  } else if (value.trim().length < 4) {
    return Trans.tooShort.trans();
  }
  return null;
}

String? validatePasswordMatch(String? value, String? pass2) {
  if (validatePassword(value) != null) {
    return Trans.required.trans();
  } else if (pass2 != value) {
    return Trans.newPasswordNotMatchWithConferm.trans();
  }
  return null;
}

String? validatephoneNullAble(String? value) {
  String pattern = '^7[3-9][0-9][0-9]{7}\$';
  RegExp regex = RegExp(pattern);

  if (value == null || value.trim().isEmpty) {
    return null;
  }
  if (!regex.hasMatch(value)) {
    return "7XX XXX XXXX";
  } else {
    return null;
  }
}

String? validatephone(String? value) {
  String pattern = '^7[0-9][0-9][0-9]{7}\$';
  RegExp regex = RegExp(pattern);
  if (value == null || value.trim().isEmpty) {
    return Trans.required.trans();
  }
  if (!regex.hasMatch(value)) {
    return "7XX XXX XXXX";
  } else {
    return null;
  }
}

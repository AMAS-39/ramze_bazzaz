import 'package:app/core/shared/imports.dart';
import 'package:app/core/utils/validations.dart';
import 'package:app/feature/account/data/model/change_password_model.dart';
import 'package:app/feature/account/data/repo/account_repo.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/form_widgets/form_widgets.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late TextEditingController newPassword;
  late TextEditingController currentPassword;
  late TextEditingController confirmNewPassword;

  @override
  void initState() {
    newPassword = TextEditingController();
    confirmNewPassword = TextEditingController();
    currentPassword = TextEditingController();

    super.initState();
  }

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Trans.changePassword.trans(),
                style: context.style20W400B,
              ),
              const SizedBox(height: 20),
              GeneralTextFiled(
                isRequired: true,
                controller: currentPassword,
                isLable: true,
                validate: validatePassword,
                labelText: Trans.currentPassword.trans(),
              ),
              const SizedBox(height: 20),
              GeneralTextFiled(
                isRequired: true,
                controller: newPassword,
                isLable: true,
                validate: validatePassword,
                labelText: Trans.newPassword.trans(),
              ),
              const SizedBox(height: 20),
              GeneralTextFiled(
                isRequired: true,
                controller: confirmNewPassword,
                isLable: true,
                validate: (p0) {
                  return validatePasswordMatch(p0, newPassword.text);
                },
                labelText: Trans.confirmNewPassword.trans(),
              ),
              const SizedBox(height: 20),
              GeneralButton(
                radius: 20,
                onTap: () async {
                  if (formKey.currentState?.validate() != true) {
                  } else {
                    sl<AccountRepo>().changePassword(
                      ChangePasswordModel(
                        currentPassword: currentPassword.text,
                        password: newPassword.text,
                        confirmPassword: confirmNewPassword.text,
                      ),
                    );
                  }
                },
                text: Trans.save.trans(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

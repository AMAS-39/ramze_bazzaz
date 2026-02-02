import 'package:app/core/shared/imports.dart';
import 'package:app/core/utils/validations.dart';
import 'package:app/feature/account/data/datasources/account_remote_data_source.dart';
import 'package:app/feature/account/data/model/forget_password_model.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/form_widgets/form_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final GlobalKey<FormState> phoneFormKey = GlobalKey<FormState>();

  final String usernameStr = "admin@admin.com";

  late TextEditingController email;
  @override
  void initState() {
    email = TextEditingController(text: kReleaseMode ? "" : usernameStr);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(kIndent * 1.5),
          child: Form(
            key: phoneFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  Trans.appName.trans(),
                  style: context.style20W600B.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.primaryColor,
                      fontSize: 22),
                ),
                const SizedBox(height: 35),
                Text(
                  Trans.forgottenPassword.trans(),
                  style: context.style20W600B.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  Trans.enterYourEmailWeWillSendYouVerificationCode.trans(),
                  textAlign: TextAlign.center,
                  style: context.style14W400.copyWith(height: 1.5),
                ),
                const SizedBox(height: 40),
                GeneralTextFiled(
                    // fillColor: Colors.white,
                    prefixIcon: const Icon(
                      Icons.email,
                      color: Colors.grey,
                    ),
                    hasBorder: true,
                    isLable: false,
                    isRequired: true,
                    filled: false,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.emailAddress,
                    hintText: Trans.email.trans(),
                    validate: validateEmail,
                    controller: email),
                const SizedBox(height: 32),
                GeneralButton(
                    padding: const EdgeInsets.only(
                        top: kIndent * 1.2, bottom: kIndent * 1.2),
                    text: Trans.send.trans(),
                    onTap: () {
                      _send();
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _send() async {
    closeKeyBoard(context);
    if (phoneFormKey.currentState?.validate() == true) {
      sl<AccountRemoteSrc>().forgetPassowrd(
          showLoading: ShowLoading.show,
          data: ForgetPasswordModel(email: email.text));
    }
  }
}

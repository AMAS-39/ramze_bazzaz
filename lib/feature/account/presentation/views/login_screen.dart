import 'dart:io';

import 'package:app/core/shared/imports.dart';
import 'package:app/core/utils/validations.dart';
import 'package:app/feature/account/data/datasources/account_local_data_source.dart';
import 'package:app/feature/account/data/model/login_model.dart';
import 'package:app/feature/account/presentation/bloc/account/account_bloc.dart';
import 'package:app/feature/account/presentation/views/register_screen.dart';
import 'package:app/feature/notifications/data/datasources/notifications_services.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/form_widgets/form_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final bool isFromTabScreen;
  const LoginScreen({super.key, required this.isFromTabScreen});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> phoneFormKey = GlobalKey<FormState>();

  late TextEditingController username;
  late TextEditingController password;
  ValueNotifier<bool> valueNotifier = ValueNotifier<bool>(true);
  @override
  void initState() {
    NotificationHelper.i.initFirebase();
    username = TextEditingController(
        text: sl<AccountLocalSrc>().loginRequestModel?.userName ??
            (kDebugMode ? appConfig.username : ""));
    password = TextEditingController(
        text: sl<AccountLocalSrc>().loginRequestModel?.password ??
            (kDebugMode ? appConfig.password : ""));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: (appConfig.app == App.kostolog &&
              (!kIsWeb && Platform.isIOS || kDebugMode))
          ? Padding(
              padding: const EdgeInsets.all(kIndent),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(Trans.haventAnAccount.trans(),
                      style: context.style16W400B.copyWith(
                          color: context.subTitleStyle.color,
                          fontWeight: FontWeight.w400)),
                  InkWell(
                    onTap: () {
                      // openEmail("kosto@kosto-log.com.tr");
                      context.to(const RegisterScreen());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(Trans.getOne.trans(),
                          style: context.style16W400B.copyWith(
                              color: context.primaryColor,
                              fontWeight: FontWeight.w500)),
                    ),
                  )
                ],
              ),
            )
          : null,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(kIndent * 1.5),
          child: Form(
            key: phoneFormKey,
            child: Column(
              crossAxisAlignment: appConfig.app == App.rbb
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                const SizedBox(height: kIndent * 5),
                if (appConfig.app == App.rbb)
                  Image.asset(appConfig.logo, width: 150.h, height: 150.h),
                Text(
                  appConfig.app == App.rbb
                      ? Trans.welcomeBack.trans()
                      : Trans.login.trans(),
                  textAlign: TextAlign.center,
                  style: context.style20W600B.copyWith(
                    fontSize: 22,
                  ),
                ),

                const SizedBox(height: 30),
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
                    hintText: Trans.username.trans(),
                    validate: validateEmail,
                    controller: username),
                const SizedBox(height: kIndent),
                ValueListenableBuilder(
                  valueListenable: valueNotifier,
                  builder: (context, value, child) {
                    return GeneralTextFiled(
                        isLable: false,
                        isRequired: true,
                        // fillColor: Colors.white,
                        prefixIcon: const Icon(
                          Icons.privacy_tip,
                          color: Colors.grey,
                        ),
                        subfixIcon: InkWell(
                            onTap: () {
                              valueNotifier.value = !valueNotifier.value;
                            },
                            child: Icon(!valueNotifier.value
                                ? Icons.visibility
                                : Icons.visibility_off)),
                        hasBorder: true,
                        filled: false,
                        obscureText: valueNotifier.value,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 16),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.visiblePassword,
                        hintText: Trans.password.trans(),
                        validate: validateEmail,
                        controller: password);
                  },
                ),
                const SizedBox(height: 32),
                GeneralButton(
                    padding: const EdgeInsets.only(
                        top: kIndent * 1.2, bottom: kIndent * 1.2),
                    text: Trans.login.trans(),
                    onTap: () {
                      _login();
                    }),
                const SizedBox(height: 40),
                // Center(
                //   child: InkWell(
                //     onTap: () {
                //       context.to(const ForgetPasswordScreen());
                //     },
                //     child: Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: Text(Trans.forgotPassword.trans(),
                //           style: context.style16W400B.copyWith(
                //               color: context.primaryColor,
                //               fontWeight: FontWeight.w700)),
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    closeKeyBoard(context);
    // context.toAndRemove(const TabsScreen());
    // return;
    if (phoneFormKey.currentState?.validate() == true) {
      sl<AccountBloc>().add(AccountLoginEvent(
          isSelected: true,
          loginModel: LoginRequestModel(
              userName: username.text, password: password.text),
          dataSource: DataSource.remote));
    }
  }
}

import 'package:app/core/shared/imports.dart';
import 'package:app/core/utils/validations.dart';
import 'package:app/feature/account/data/model/register_model.dart';
import 'package:app/feature/account/data/repo/account_repo.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/form_widgets/form_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  ValueNotifier<bool> privacyPolicy = ValueNotifier<bool>(false);
  TextEditingController fullName =
      TextEditingController(text: !kDebugMode ? null : "Hussen Ibrahim");
  TextEditingController email = TextEditingController(
      text: !kDebugMode ? null : "hussenibrahim245@gmail.com");
  TextEditingController password =
      TextEditingController(text: !kDebugMode ? null : "12345678");
  TextEditingController confirmPassword =
      TextEditingController(text: !kDebugMode ? null : "12345678");
  ValueNotifier<bool> valueNotifier = ValueNotifier<bool>(true);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(kIndent * 1.5),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: kIndent * 2),
                Text(
                  Trans.registration.trans(),
                  style: context.style20W600B.copyWith(fontSize: 22),
                ),
                // const SizedBox(height: kIndent / 2),
                // Text(Trans.letsRegisterApplyToStartExpolre.trans(),
                //     style: context.style14W400),
                const SizedBox(height: kIndent),
                GeneralTextFiled(
                    hasBorder: true,
                    isLable: false,
                    isRequired: true,
                    filled: false,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 18),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.name,
                    hintText: Trans.fullName.trans(),
                    validate: validateName,
                    controller: fullName),
                const SizedBox(height: kIndent),
                GeneralTextFiled(
                    hasBorder: true,
                    isLable: false,
                    isRequired: true,
                    filled: false,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 18),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.emailAddress,
                    hintText: Trans.email.trans(),
                    validate: validateEmail,
                    controller: email),
                const SizedBox(height: kIndent),
                ValueListenableBuilder(
                  valueListenable: valueNotifier,
                  builder: (context, value, child) {
                    return GeneralTextFiled(
                        isLable: false,
                        isRequired: true,
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
                            horizontal: 20, vertical: 18),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.visiblePassword,
                        hintText: Trans.password.trans(),
                        validate: validatePassword,
                        controller: password);
                  },
                ),
                const SizedBox(height: kIndent),
                ValueListenableBuilder(
                  valueListenable: valueNotifier,
                  builder: (context, value, child) {
                    return GeneralTextFiled(
                        isLable: false,
                        isRequired: true,
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
                            horizontal: 20, vertical: 18),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.visiblePassword,
                        hintText: Trans.confirmPassword.trans(),
                        validate: (p0) {
                          return validatePasswordMatch(p0, password.text);
                        },
                        controller: confirmPassword);
                  },
                ),
                const SizedBox(height: 16),
                // ValueListenableBuilder(
                //     valueListenable: privacyPolicy,
                //     builder: (context, bool value, child) {
                //       return FormEntryFormField<bool>(
                //         padding: const EdgeInsetsDirectional.only(start: 10),
                //         child: (changeHandler) {
                //           return Row(
                //             children: [
                //               Checkbox(
                //                 value: value,
                //                 materialTapTargetSize:
                //                     MaterialTapTargetSize.shrinkWrap,
                //                 onChanged: (value) {
                //                   changeHandler.call(value ?? false);
                //                   privacyPolicy.value = value ?? false;
                //                 },
                //               ),
                //               Text(
                //                 Trans.youAgreeWithOur.trans(),
                //                 style: context.style14W400,
                //               ),
                //               InkWell(
                //                 enableFeedback: false,
                //                 onTap: () {
                //                   // context.to(DynamicContentScreen(
                //                   //   title: Trans.privacyPolicy.trans(),
                //                   //   bloc: sl<PrivacyPolicyBloc>(),
                //                   // ));
                //                 },
                //                 child: Text(
                //                   Trans.privacyPolicy.trans().toLowerCase(),
                //                   style: context.style14W400.copyWith(
                //                     decoration: TextDecoration.underline,
                //                     color: context.primaryColor,
                //                   ),
                //                 ),
                //               )
                //             ],
                //           );
                //         },
                //         initialValue: value,
                //         validator: (value) {
                //           if (value == false) {
                //             return Trans.youMustAcceptOutPrivacyPolicy.trans();
                //           }
                //           return null;
                //         },
                //         onSaved: (newValue) {},
                //       );
                //     }),
                // const SizedBox(height: kIndent * 2),
                GeneralButton(
                    text: Trans.register.trans(),
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        sl<AccountRepo>().register(
                            registerModel: RegisterModel(
                              name: fullName.text,
                              email: email.text,
                              password: password.text,
                              cPassword: confirmPassword.text,
                            ),
                            showLoading: ShowLoading.show);
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

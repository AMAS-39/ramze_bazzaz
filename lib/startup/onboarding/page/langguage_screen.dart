// ignore_for_file: use_build_context_synchronously
import 'package:app/core/shared/imports.dart';
import 'package:app/core/shared/language.dart';
import 'package:app/feature/app_setting/data/model/local_app_setting.dart';
import 'package:app/feature/app_setting/persentation/bloc/local_setting/local_app_setting_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// class LanguageScreen extends StatefulWidget {
//   const LanguageScreen({
//     super.key,
//     required this.fromSplash,
//   });
//   final bool fromSplash;
//   @override
//   State<LanguageScreen> createState() => _LanguageScreenState();
// }

// class _LanguageScreenState extends State<LanguageScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(

//         body: Padding(
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Padding(
//             padding: EdgeInsets.only(
//                 top: widget.fromSplash ? kIndent * 5 : 0,
//                 bottom: kIndent * 1.5),
//             child: Text(
//               Trans.selectYourLanguage.trans(context: context),
//               style: context.titleStyle.copyWith(fontSize: 20),
//             ),
//           ),
//           BlocBuilder<LocalAppSettingsCubit, AppSettingsState>(
//             builder: (context, state) {
//               return ListView.separated(
//                 separatorBuilder: (context, index) =>
//                     const SizedBox(height: kIndent),
//                 shrinkWrap: true,
//                 itemCount: languages.length,
//                 itemBuilder: (context, index) {
//                   bool isSelected = sl<LocalAppSettingsCubit>().state.lang ==
//                       languages[index].code;
//                   return _LangWidget(
//                       language: languages[index], isSelected: isSelected);
//                 },
//               );
//             },
//           ),
//           const SizedBox(height: kIndent * 3),
//           if (widget.fromSplash)
//             GeneralButton(
//                 onTap: () {
//                   context.toAndRemove(const SplashScreen());
//                 },
//                 text: Trans.next.trans(context: context)),
//         ],
//       ),
//     ));
//   }
// }

class _LangWidget extends StatefulWidget {
  const _LangWidget({
    required this.isSelected,
    required this.language,
  });

  final bool isSelected;
  final Language language;

  @override
  State<_LangWidget> createState() => _LangWidgetState();
}

class _LangWidgetState extends State<_LangWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(BORDER_RADUIS),
      enableFeedback: false,
      onTap: () async {
        sl<LocalAppSettingsCubit>().changeLang(widget.language.code);
        context.pop();
      },
      child: Container(
        padding: const EdgeInsetsDirectional.all(20),
        decoration: BoxDecoration(
          color: context.cardColor,
          border: Border.all(
              width: 1,
              color: widget.isSelected
                  ? context.primaryColor
                  : Colors.transparent),
          borderRadius: BorderRadius.circular(BORDER_RADUIS),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.asset(widget.language.flag,
                  width: 28, height: 20, fit: BoxFit.cover),
            ),
            const SizedBox(width: kIndent),
            Text(
              widget.language.name,
              style: context.titleStyle.copyWith(fontSize: 16),
              strutStyle: const StrutStyle(forceStrutHeight: true, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> showChangeLang() async {
  return await showModalBottomSheet(
      context: Helper.i.context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(BORDER_RADUIS),
              topRight: Radius.circular(BORDER_RADUIS))),
      builder: (context) {
        return const __NewWidget();
      });
}

class __NewWidget extends StatelessWidget {
  const __NewWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 75,
            height: 8,
            decoration: BoxDecoration(
                color: context.primaryColor,
                borderRadius: BorderRadius.circular(BORDER_RADUIS)),
          ),
          const SizedBox(height: 20),
          BlocBuilder<LocalAppSettingsCubit, LocalAppSettingsState>(
            builder: (context, state) {
              return ListView.separated(
                padding: EdgeInsets.zero,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: kIndent),
                shrinkWrap: true,
                itemCount: languages.length,
                itemBuilder: (context, index) {
                  bool isSelected = sl<LocalAppSettingsCubit>().state.lang ==
                      languages[index].code;
                  return _LangWidget(
                      language: languages[index], isSelected: isSelected);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

Future<void> showChangeTheme() async {
  return await showModalBottomSheet(
      context: Helper.i.context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(BORDER_RADUIS),
              topRight: Radius.circular(BORDER_RADUIS))),
      builder: (context) {
        return const __ThemeWidget();
      });
}

class __ThemeWidget extends StatelessWidget {
  const __ThemeWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 75,
            height: 8,
            decoration: BoxDecoration(
                color: context.primaryColor,
                borderRadius: BorderRadius.circular(BORDER_RADUIS)),
          ),
          const SizedBox(height: 20),
          BlocBuilder<LocalAppSettingsCubit, LocalAppSettingsState>(
            builder: (context, state) {
              return ListView.separated(
                padding: EdgeInsets.zero,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: kIndent),
                shrinkWrap: true,
                itemCount: ThemeMode.values.length,
                itemBuilder: (context, index) {
                  bool isSelected =
                      sl<LocalAppSettingsCubit>().state.themeMode ==
                          ThemeMode.values[index];
                  return _ThemeWidget(
                      theme: ThemeMode.values[index], isSelected: isSelected);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ThemeWidget extends StatefulWidget {
  const _ThemeWidget({
    required this.isSelected,
    required this.theme,
  });

  final bool isSelected;
  final ThemeMode theme;

  @override
  State<_ThemeWidget> createState() => _ThemeWidgetState();
}

class _ThemeWidgetState extends State<_ThemeWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(BORDER_RADUIS),
      enableFeedback: false,
      onTap: () async {
        await sl<LocalAppSettingsCubit>().changeTheme(widget.theme);
        context.pop();
      },
      child: Container(
        padding: const EdgeInsetsDirectional.all(20),
        decoration: BoxDecoration(
          color: context.cardColor,
          border: Border.all(
              width: 1,
              color: widget.isSelected
                  ? context.primaryColor
                  : Colors.transparent),
          borderRadius: BorderRadius.circular(BORDER_RADUIS),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.theme.name.trans(),
              style: context.titleStyle.copyWith(fontSize: 16),
              strutStyle: const StrutStyle(forceStrutHeight: true, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:app/core/shared/imports.dart';
import 'package:flutter/material.dart';

Future<Options?> showOptionBottomSheet({required List<Options> options}) async {
  return await showModalBottomSheet<Options?>(
      context: Helper.i.context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))),
      builder: (BuildContext context) {
        return OptionsView(options: options);
      });
}

class OptionsView extends StatelessWidget {
  const OptionsView({
    super.key,
    required this.options,
  });
  final List<Options> options;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        maintainBottomViewPadding: true,
        top: true,
        child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Container(
                  height: 5,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10.0)),
                  margin: const EdgeInsets.only(
                    top: 20,
                    bottom: 10,
                  )),
              Column(
                children: options
                    .map((e) => InkWell(
                        onTap: () => context.pop(e),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          child: Row(children: [
                            Icon(e.icon),
                            const SizedBox(width: 10),
                            Text(e.label,
                                style: TextStyle(
                                  color: context.titleStyle.color,
                                  fontSize: 16.sp,
                                )),
                          ]),
                        )))
                    .toList(),
              ),
              const SizedBox(height: 20)
            ])));
  }
}

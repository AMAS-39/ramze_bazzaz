import 'package:app/core/shared/imports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LabeledSwitch extends StatelessWidget {
  const LabeledSwitch({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: Text(label,
                    style: context.titleStyle
                        .copyWith(fontWeight: FontWeight.w500))),
            CupertinoSwitch(
                activeTrackColor: Theme.of(context).primaryColor,
                value: value,
                onChanged: onChanged),
          ],
        ),
      ),
    );
  }
}

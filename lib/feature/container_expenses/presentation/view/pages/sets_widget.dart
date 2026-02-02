import 'package:app/core/shared/imports.dart';
import 'package:app/feature/pay_insteads/presentation/view/pages/total.dart';
import 'package:flutter/material.dart';

class SetsWidget extends StatefulWidget {
  const SetsWidget(
      {super.key,
      required this.selected,
      this.totalY,
      this.totalS,
      required this.maxLength,
      required this.onChange});
  final int selected;
  final int maxLength;
  final double? totalY;
  final double? totalS;

  final void Function(int index) onChange;

  @override
  State<SetsWidget> createState() => _SetsWidgetState();
}

class _SetsWidgetState extends State<SetsWidget> {
  int selected = 0;

  @override
  void initState() {
    selected = widget.selected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final int makLength = widget.maxLength + 1;
    if (!appConfig.isRbb || makLength == 1) {
      return const SizedBox();
    }

    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  if (selected > 0) {
                    selected--;
                    widget.onChange(selected);
                    setState(() {});
                  }
                },
                child: Container(
                  height: 50,
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                  child: const Icon(Icons.skip_previous),
                ),
              ),
              Flexible(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  children: [
                    ...List.generate(makLength, (index) {
                      return InkWell(
                        onTap: () {
                          selected = index;
                          widget.onChange(selected);
                          setState(() {});
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 12),
                          decoration: BoxDecoration(
                              border: Border.all(),
                              color: selected == index
                                  ? context.primaryColor
                                  : null),
                          child: Text(
                            index.toString(),
                            style: context.titleStyle.copyWith(
                                color: selected == index ? Colors.white : null),
                          ),
                        ),
                      );
                    })
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  if (selected < makLength - 1) {
                    selected++;
                    widget.onChange(selected);
                    setState(() {});
                  }
                },
                child: Container(
                  height: 50,
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                  child: const Icon(Icons.skip_next),
                ),
              ),
            ],
          ),
        ),
        if (widget.totalY != null || widget.totalS != null)
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            padding: const EdgeInsets.symmetric(vertical: kIndent / 2),
            decoration: BoxDecoration(
                color: appConfig.app == App.rbb ? context.cardColor : null,
                borderRadius: BorderRadius.circular(10)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (widget.totalY != null)
                    InfoWidget(
                      title: "${Trans.amount.trans()} ¥ ",
                      value: widget.totalY!.format,
                      icon: null,
                    ),
                  if (widget.totalS != null)
                    InfoWidget(
                      title: "${Trans.total.trans()} \$ ",
                      value: widget.totalS!.format,
                      icon: null,
                    )
                ]),
          )
      ],
    );
  }
}

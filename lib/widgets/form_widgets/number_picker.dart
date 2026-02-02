part of "form_widgets.dart";

Future<int?> numberPicker({
  required int selected,
  required List<int> data,
}) async {
  return await showDialog<int?>(
    context: Helper.i.context,
    // barrierColor: Colors.transparent,
    builder: (context) => AlertDialog(
      actionsPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      content: _AddCalories(data: data, selected: selected),
    ),
  );
}

class _AddCalories extends StatefulWidget {
  const _AddCalories({
    required this.selected,
    required this.data,
  });
  final int selected;
  final List<int> data;

  @override
  __AddCaloriesState createState() => __AddCaloriesState();
}

class __AddCaloriesState extends State<_AddCalories> {
  late FixedExtentScrollController scrollController;
  int index = 0;

  @override
  void initState() {
    index = widget.data.indexOf(widget.selected);
    logger(index);
    scrollController = FixedExtentScrollController(initialItem: index);

    super.initState();
  }

  int selected = 0;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 100.w,
            height: 200.h,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            decoration: BoxDecoration(
                color: context.canvacColor,
                borderRadius: BorderRadius.circular(BORDER_RADUIS)),
            child: CupertinoPicker(
              backgroundColor: Colors.transparent,
              squeeze: 0.95,
              diameterRatio: 1.5,
              itemExtent: 36.0,
              selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(),
              scrollController: scrollController,
              children: widget.data
                  .map((e) => Text(
                        "$e",
                        style: TextStyle(
                          height: 1.5,
                          color: theme.textTheme.bodyLarge?.color,
                        ),
                      ))
                  .toList(),
              onSelectedItemChanged: (value) {
                index = value;
                logger(index);
              },
            ),
          ),
        ],
      ),
    );
  }
}

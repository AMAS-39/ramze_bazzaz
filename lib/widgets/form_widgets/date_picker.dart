part of "form_widgets.dart";

Future<DateTime?> datePicker(
    {required DateTime start,
    required DateTime end,
    required DateTime? selected,
    String? title}) async {
  return await showDatePicker(
      context: Helper.i.context,
      initialDate: selected ?? DateTime.now(),
      firstDate: start,
      lastDate: end);
  // return await showDialog<DateTime?>(
  //     context: Helper.i.context,
  //     barrierColor: Colors.transparent,
  //     builder: (context) => BackdropFilter(
  //           filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
  //           child: AlertDialog(
  //             actionsPadding: EdgeInsets.zero,
  //             contentPadding: EdgeInsets.symmetric(horizontal: 5.w),
  //             backgroundColor: Colors.transparent,
  //             content: _Picker(
  //                 start: start, end: end, title: title, selected: selected),
  //           ),
  //         ));
}

class _Picker extends StatefulWidget {
  final DateTime? selected;
  final DateTime start;
  final DateTime end;
  final String? title;

  const _Picker(
      {required this.end,
      required this.selected,
      required this.start,
      required this.title});

  @override
  __PickerState createState() => __PickerState();
}

class __PickerState extends State<_Picker> {
  late DateTime? dateTime;
  late FixedExtentScrollController yearsControllers;
  late FixedExtentScrollController daysControllers;
  late FixedExtentScrollController monthsControllers;
  int monthLength = 31;
  @override
  void initState() {
    dateTime = widget.selected;
    yearsControllers = FixedExtentScrollController(
        initialItem:
            ((widget.selected ?? widget.start).year - widget.start.year).abs());
    daysControllers =
        FixedExtentScrollController(initialItem: (dateTime?.day ?? 1) - 1);
    selectedDate = dateTime?.day ?? 0;
    monthsControllers = FixedExtentScrollController(
        initialItem: (dateTime ?? widget.start).month - 1);
    monthLength = getMonthLength((widget.selected ?? widget.start).year,
        (widget.selected ?? widget.start).month);
    super.initState();
  }

  int selectedDate = 0;
  GlobalKey key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = 79.w;
    return Container(
        decoration: BoxDecoration(
            color: context.scaffoldBackgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Container(
            padding: EdgeInsets.only(left: 15.w, right: 15.w),
            width: context.width,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              SizedBox(height: 30.h),
              Text(widget.title ?? Trans.selectDate.trans(),
                  style: context.titleStyle),
              SizedBox(height: 25.h),
              Container(
                  height: 215.h,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: context.cardColor,
                      borderRadius: BorderRadius.circular(BORDER_RADUIS)),
                  child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: 250.h,
                            width: width,
                            child: CupertinoPicker.builder(
                                squeeze: 0.95,
                                diameterRatio: 1.5,
                                itemExtent: 35.h,
                                scrollController: yearsControllers,
                                onSelectedItemChanged: (int index) {
                                  changeMonthLength();
                                },
                                itemBuilder: (BuildContext context, int index) {
                                  String st = "${index + widget.start.year}";
                                  return SwperText(value: st, theme: theme);
                                },
                                childCount: widget.end.year - widget.start.year,
                                selectionOverlay:
                                    const CupertinoPickerDefaultSelectionOverlay())),
                        SizedBox(width: 5.w),
                        SizedBox(
                          height: 250.h,
                          width: width,
                          child: CupertinoPicker.builder(
                            scrollController: monthsControllers,
                            onSelectedItemChanged: (int index) {
                              changeMonthLength();
                            },
                            itemBuilder: (BuildContext context, int index) {
                              return SwperText(
                                  value: "${index + 1} ", theme: theme);
                            },
                            squeeze: 0.95,
                            diameterRatio: 1.5,
                            itemExtent: 35.h,
                            childCount: 12,
                            selectionOverlay:
                                const CupertinoPickerDefaultSelectionOverlay(),
                          ),
                        ),
                        SizedBox(width: 5.w),
                        SizedBox(
                          height: 250.h,
                          width: width,
                          child: CupertinoPicker.builder(
                            key: key,
                            squeeze: 0.95,
                            diameterRatio: 1.5,
                            itemExtent: 35.h,
                            onSelectedItemChanged: (int index) {
                              selectedDate = index + 1;
                            },
                            itemBuilder: (BuildContext context, int index) {
                              return SwperText(
                                  value: "${index + 1}", theme: theme);
                            },
                            scrollController: daysControllers,
                            childCount: monthLength,
                            selectionOverlay:
                                const CupertinoPickerDefaultSelectionOverlay(),
                          ),
                        ),
                      ].reversed.toList())),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: context.pop,
                      child: Text(
                        Trans.cancel.trans(),
                        style: TextStyle(fontSize: 17.sp),
                      )),
                  SizedBox(width: 20.w),
                  TextButton(
                      child: Text(
                        Trans.ok.trans(),
                        style: TextStyle(fontSize: 17.sp),
                      ),
                      onPressed: () {
                        dateTime = DateTime(
                            yearsControllers.selectedItem + widget.start.year,
                            monthsControllers.selectedItem + 1,
                            daysControllers.selectedItem + 1);
                        Navigator.of(context).pop<DateTime>(dateTime);
                      }),
                ],
              ),
              SizedBox(height: 8.h),
            ])));
  }

  void changeMonthLength() {
    int year = yearsControllers.selectedItem + widget.start.year;
    int mon = monthsControllers.selectedItem + 1;

    int temp = getMonthLength(year, mon);
    if (monthLength == temp) {
      return;
    }
    monthLength = temp;
    logger(
        "year $year   mon $mon  $selectedDate $monthLength ${selectedDate > monthLength ? selectedDate - (monthLength - selectedDate) : selectedDate}");
    daysControllers = FixedExtentScrollController(initialItem: selectedDate);
    key = GlobalKey();
    setState(() {});
  }

  int getMonthLength(int year, int month) {
    if ([1, 3, 5, 7, 8, 10, 12].contains(month)) {
      return 31;
    } else if ([4, 6, 9, 11].contains(month)) {
      return 30;
    } else {
      if (year % 4 == 0) {
        return 28;
      } else {
        return 29;
      }
    }
  }
}

class SwperText extends StatelessWidget {
  const SwperText({
    super.key,
    required this.theme,
    required this.value,
  });
  final String value;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35.h,
      child: Center(
        child: Container(
          alignment: Alignment.center,
          child: Text(
            value,
            style: TextStyle(
              fontFamily: "",
              color: theme.textTheme.bodyLarge?.color,
              height: 1,
              fontSize: 18.sp,
            ),
          ),
        ),
      ),
    );
  }
}

// const MONTHS = [
//   'Jan',
//   'Feb',
//   'Mar',
//   'Apr',
//   'May',
//   'Jun',
//   'Jul',
//   'Aug',
//   'Sep',
//   'Oct',
//   'Nov',
//   'Dec'
// ];

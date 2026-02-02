part of  'export_status_widgets.dart';

 
class NetWorkErrorWidget extends StatelessWidget {
  final Future<void> Function() onPress;
  final String text;
  const NetWorkErrorWidget(
      {super.key, required this.onPress, required this.text});
  @override
  Widget build(BuildContext context) {
    TextStyle boldTextStyle = TextStyle(
      color: Theme.of(context).textTheme.bodyLarge?.color,
      fontSize: (20.sp),
    );
    return RefreshIndicator(
      onRefresh: onPress,
      child: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image.asset(Assets.images.error.path, height: 240.h),
                const SizedBox(height: 25),
                Text(text, textAlign: TextAlign.center, style: boldTextStyle),
                const SizedBox(height: 14),
                TextButton(
                  onPressed: () {
                    onPress();
                  },
                  child: Text(Trans.retry.trans(),
                      textAlign: TextAlign.center, style: boldTextStyle),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

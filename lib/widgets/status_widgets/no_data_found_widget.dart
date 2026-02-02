part of 'export_status_widgets.dart';

class NoDataFound extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final String text;
  final bool showImage;
  const NoDataFound(
      {super.key,
      required this.onRefresh,
      this.showImage = true,
      required this.text});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, con) {
      logger("con ${con.maxHeight}");
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: con.maxHeight,
        child: RefreshIndicator(
          onRefresh: onRefresh,
          child: ListView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            // shrinkWrap: false,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: con.maxHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // if (showImage) const Icon(Icons.error, size: 80),
                    const SizedBox(height: 25),
                    Text(Trans.noResultToDisplay.trans(),
                        textAlign: TextAlign.center,
                        style: context.titleStyle.copyWith(fontSize: 22.sp)),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}

part of 'export_status_widgets.dart';

class FaliedLoadPageWIdget extends StatelessWidget {
  final Future<void> Function() onPress;
  final String text;
  const FaliedLoadPageWIdget({
    super.key,
    required this.onPress,
    required this.text,
  });
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, con) {
      logger("con ${con.maxHeight} $text");
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: con.maxHeight,
        child: RefreshIndicator(
          onRefresh: onPress,
          child: ListView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            // shrinkWrap: false,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: con.maxHeight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error,
                        size: 80,
                        color: context.primaryColor,
                      ),
                      const SizedBox(height: 25),
                      Text(text,
                          textAlign: TextAlign.center,
                          style: context.titleStyle.copyWith(fontSize: 22.sp)),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}

part of 'export_status_widgets.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget(
      {super.key,
      this.height,
      this.skeletonChild,
      this.padding,
      this.isGIrdView = false,
      this.shrinWrap,
      this.spacer});
  final double? height;
  final Widget? skeletonChild;
  final Widget? spacer;
  final bool? shrinWrap;
  final bool? isGIrdView;

  final EdgeInsets? padding;
  @override
  Widget build(BuildContext context) {
    if (skeletonChild != null) {
      return Skeletonizer(
        child: ListView.separated(
          separatorBuilder: (context, index) =>
              spacer ?? const SizedBox(height: 8),
          shrinkWrap: shrinWrap ?? false,
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 20),
          physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics()),
          itemCount: 20,
          itemBuilder: (BuildContext context, int index) {
            return skeletonChild;
          },
        ),
      );
    }

    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: CircularProgressIndicator.adaptive(
            valueColor: AlwaysStoppedAnimation<Color>(context.primaryColor),
          ),
        ));
  }
}

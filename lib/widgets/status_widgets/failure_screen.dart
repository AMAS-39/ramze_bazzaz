part of 'export_status_widgets.dart';

class FailureScreen extends StatelessWidget {
  const FailureScreen({
    super.key,
    required this.failure,
    required this.onRefresh,
    required this.name,
  });
  final Failure failure;
  final String name;
  final Future<void> Function() onRefresh;
  @override
  Widget build(BuildContext context) {
    final String reason = failure.error.reason;
    if ((failure is NetworkFailure)) {
      return NetWorkErrorWidget(onPress: onRefresh, text: reason);
    } else if ((failure is ErrorFailure)) {
      return FaliedLoadPageWIdget(onPress: onRefresh, text: reason);
    } else if ((failure is UnAuthFailure)) {
      return FaliedLoadPageWIdget(onPress: onRefresh, text: reason);
    } else if ((failure is ServerFailure)) {
      return FaliedLoadPageWIdget(onPress: onRefresh, text: reason);
    } else if ((failure is EmptyData)) {
      return NoDataFound(
          onRefresh: onRefresh,
          text: Trans.noDataFound.trans(args: [name], context: context));
    } else {
      return FaliedLoadPageWIdget(
          onPress: onRefresh,
          text: Trans.failedLoadData.trans(context: context));
    }
  }
}

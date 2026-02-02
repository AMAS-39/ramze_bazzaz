part of "imports.dart";

class Helper {
  static final Helper _singleton = Helper._();
  static Helper get i => _singleton;
  Helper._();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  BuildContext get context => navigatorKey.currentContext!;

  bool get canPop => Navigator.canPop(context);
}

int getHoursOrMinutes(String dayNum, bool hour) {
  try {
    var data = dayNum.split(":");
    if (hour) {
      int hours = int.parse(data[0]);
      return hours;
    }
    return int.parse(data[1]);
  } catch (e) {
    return 0;
  }
}

/// used to save others data realted to a student
String get tableSubFix {
  // if(sl<LoginBloc>().info?.userType.isStudent){
  return sl<AccountBloc>().info!.id.toString();
  // }else   if(sl<LoginBloc>().info?.userType.isParent){
  //   required sl<LoginBloc>().info!.id?.toString();
  // }
}

// used for parent
String get studentTableSubFix {
  // if(sl<LoginBloc>().info?.userType.isStudent){
  return sl<AccountBloc>().info!.id.toString();
  // }else   if(sl<LoginBloc>().info?.userType.isParent){
  //   required sl<LoginBloc>().info!.id?.toString();
  // }
}

void openFile(FileType fileType, String? attached) {}

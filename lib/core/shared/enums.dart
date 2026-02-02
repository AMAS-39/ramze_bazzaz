// ignore_for_file: constant_identifier_names

part of "imports.dart";

enum Status { initial, loading, success, failure, networkError, empty }

extension StatusExtension on Status {
  bool get isInitial => this == Status.initial;
  bool get isLoading => this == Status.loading;
  bool get isLoadingOrInitial =>
      [Status.loading, Status.initial].contains(this);
  bool get isAnyError => [Status.networkError, Status.failure].contains(this);
  bool get isEmpty => this == Status.empty;
  bool get isNetworkError => this == Status.networkError;
  bool get isSuccess => this == Status.success;
  bool get isFailure => this == Status.failure;
}

enum Pagination { match, loading, notMatch, error }

extension PaginationExtension on Pagination {
  bool get isLoading => this == Pagination.loading;
  bool get isMatch => this == Pagination.match;
  bool get isNotMatch => this == Pagination.notMatch;
  bool get isError => this == Pagination.error;
}

enum ShowMessage {
  failedAlert,
  successAlert,
  bothAlert,
  failedToast,
  successToast,
  bothToast,
  failedAlertSuccessToast,
  failedToastSuccessAlert,
  none
}

enum ShowLoading { show, none }

extension ShowMessageEnumExtension on ShowMessage {
  bool get successAlert => [
        ShowMessage.successAlert,
        ShowMessage.bothAlert,
        ShowMessage.failedToastSuccessAlert
      ].contains(this);
  bool get failedAlert => [
        ShowMessage.failedAlert,
        ShowMessage.bothAlert,
        ShowMessage.failedAlertSuccessToast
      ].contains(this);
  bool get failedToast => [
        ShowMessage.bothToast,
        ShowMessage.failedToast,
        ShowMessage.failedToastSuccessAlert
      ].contains(this);

  bool get successToast => [
        ShowMessage.bothToast,
        ShowMessage.successToast,
        ShowMessage.failedAlertSuccessToast
      ].contains(this);
}

enum ParseBody { direct, data, products, none }

enum DataSource { local, remote, checkNetwork }

extension DataSourceExtension on DataSource {
  bool get isRemote => this == DataSource.remote;
  bool get isLocal => this == DataSource.local;
  bool get isCheckNetwork => this == DataSource.checkNetwork;
}

extension ShowLoadingExtension on ShowLoading {
  bool get isShow => this == ShowLoading.show;
  bool get isNone => this == ShowLoading.none;
}

/// to check database table type
/// for sembast database
enum DataBaseType { Integer, Strings }

//used in get default operation message
enum OperationType {
  SuccessGetAll,
  SuccessGetOne,
  SuccessAddAll,
  SuccessAddOne,
  SuccessUpdate,
  SuccessDelete,
  FailedAddAll,
  FailedGetAll,
  FailedGetOne,
  FailedAddOne,
  FailedUpdate,
  FailedDelete,
}

///
enum DataBaseFilterType {
  Equal,
  NotEqual,
  GreaterThan,
  GreaterOrEqual,
  IsInList,
  NotInList,
  LessThan,
  LessOrEqual,
}

class Days {
  static String saturday = "saturday";
  static String sunday = "sunday";
  static String monday = "monday";
  static String tuesday = "tuesday";
  static String wednesday = "wednesday";
  static String thursday = "thursday";
  static String friday = "friday";
  static List<String> get all => [
        saturday,
        sunday,
        monday,
        tuesday,
        wednesday,
        thursday,
        friday,
      ];
}

enum NotificationType {
  none,
  order;

  factory NotificationType.fromMap(String? value) {
    return NotificationType.values.firstWhereOrNull(
            (element) => value.toString().split("\\").last == element.name) ??
        NotificationType.none;
  }
}

enum ActionEnum { Delete }

enum Options {
  Delete,
  Edit,
  View,
  ;

  IconData get icon {
    switch (this) {
      case Options.Delete:
        return Icons.delete;
      case Options.Edit:
        return Icons.edit;

      case Options.View:
        return Icons.open_in_browser;
    }
  }

  String get label {
    switch (this) {
      case Options.Delete:
        return Trans.delete.trans();
      case Options.Edit:
        return Trans.edit.trans();
      case Options.View:
        return Trans.view.trans();
    }
  }

  Color? get color {
    switch (this) {
      case Options.Delete:
        return Colors.red;
      default:
        return null;
      // case Options.Edit:
      //   return Colors.blue;
      // case Options.View:
      //   return Colors.green;
      // case Options.MakeItActive:
      //   return Colors.green;
      // case Options.Clone:
      //   return Colors.blue;
      // case Options.Prompte:
      //   return Colors.blue;
      // case Options.makeItExpired:
      //   return Colors.red;
      // case Options.Applications:
      //   return Colors.orange;
    }
  }
}

enum WebViewStatus { uninitialized, loading, loaded, error }

enum Role {
  candidate,
  company,
  none;

  factory Role.fromMap(String? value) {
    return EnumExtension.fromName(value, Role.values) ?? Role.none;
  }
}

enum FileType {
  Image,
  Pdf,
  none;

  factory FileType.fromMap(String? value) {
    return EnumExtension.fromName(value, FileType.values) ?? FileType.none;
  }
}

extension RoleExtension on Role {
  bool get isCandidate => this == Role.candidate;
  bool get isCompany => this == Role.company;
}

extension EnumExtension<T> on T {
  String get _name => toString().split(".").last.toLowerCase();
  static T? fromName<T>(String? name, List<T> values, {T? defaultValue}) {
    logger("fromName $name");
    final res = values.firstWhereIndexedOrNull((index, enumValue) {
          logger("name $name");
          return "$name".toLowerCase() == enumValue._name.toLowerCase();
        }) ??
        defaultValue;
    logger("fromName $name $res");

    return res;
  }
}

enum LanguageEnum {
  en,
  ar,
  ku;

  factory LanguageEnum.fromMap(String? value) {
    return EnumExtension.fromName(value, LanguageEnum.values) ??
        LanguageEnum.en;
  }
}

enum Screens {
  home,
  payments,
  payInsteads,
  payReturns,
  attachments,
  packages,
  customerDoubleEntries,
  container,
  trackContainer,
  containerExpenses,
  language,
  theme,
  settings,
  logOut
}

enum PackageStatus {
  New,
  InOriginStock,
  InShipping,
  InDestinationStock,
  Delivered,
  ;

  factory PackageStatus.fromMap(String? value) {
    return EnumExtension.fromName(value, PackageStatus.values) ??
        PackageStatus.New;
  }
}

enum ContainerStatus {
  New,
  InShipping,
  Arrived;

  factory ContainerStatus.fromMap(String? value) {
    return EnumExtension.fromName(value, ContainerStatus.values) ??
        ContainerStatus.New;
  }
}

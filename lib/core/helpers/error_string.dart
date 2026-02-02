import 'package:app/core/error/failure_message_model.dart';
import 'package:app/core/shared/imports.dart';

///  here we check if user bassed his own message
///if true return his message
/// if not return general message
/// message is user custome message
/// name is the name of the end point or destination data
/// addtional is like network error or server error
/// operationType to return  message like (failed to create ,or filed to add or get or update)

FailureMessage getMessage(
    {String? message,
    String? reason,
    String? name,
    int? length,
    required int statusCode,
    required OperationType operationType}) {
  String errorMessage = _getPassedOrDefault(message, name, operationType);

  FailureMessage messageModel =
      FailureMessage(statusCode: statusCode, message: "", reason: "");

  messageModel.message = errorMessage;

  messageModel.reason = checkIsNull(reason) ? "" : "$reason";

  if (!checkIsNull(reason)) {
    errorMessage = "$errorMessage\n$reason";
  }

  return messageModel;
}

//return passed message or default message
String _getPassedOrDefault(
    String? error, String? name, OperationType operationType) {
  if (operationType == OperationType.SuccessGetAll) {
    return error ??
        (Trans.successToGetAllData
            .trans(args: [name?.trans(capital: false) ?? ""]));
  } else if (operationType == OperationType.SuccessGetOne) {
    return error ??
        (Trans.successToGetOne
            .trans(args: [name?.trans(capital: false) ?? ""]));
  } else if (operationType == OperationType.SuccessDelete) {
    return error ??
        (Trans.successToDeleteOne
            .trans(args: [name?.trans(capital: false) ?? ""]));
  } else if (operationType == OperationType.SuccessUpdate) {
    return error ??
        (Trans.successToUpdateOne
            .trans(args: [name?.trans(capital: false) ?? ""]));
  } else if (operationType == OperationType.SuccessAddOne) {
    return error ??
        (Trans.successToAddOne
            .trans(args: [name?.trans(capital: false) ?? ""]));
  } else if (operationType == OperationType.FailedGetAll) {
    return error ??
        (Trans.failedToGetAllData
            .trans(args: [name?.trans(capital: false) ?? ""]));
  } else if (operationType == OperationType.FailedGetOne) {
    return error ??
        (Trans.failedToGetOne.trans(args: [name?.trans(capital: false) ?? ""]));
  } else if (operationType == OperationType.FailedDelete) {
    return error ??
        (Trans.failedToDeleteOne
            .trans(args: [name?.trans(capital: false) ?? ""]));
  } else if (operationType == OperationType.FailedUpdate) {
    return error ??
        (Trans.failedToUpdateOne
            .trans(args: [name?.trans(capital: false) ?? ""]));
  } else if (operationType == OperationType.FailedUpdate) {
    return error ??
        (Trans.failedToAddOne.trans(args: [name?.trans(capital: false) ?? ""]));
  } else if (operationType == OperationType.SuccessAddAll) {
    return error ??
        (Trans.successToAddAll
            .trans(args: [name?.trans(capital: false) ?? ""]));
  } else if (operationType == OperationType.FailedAddAll) {
    return error ??
        (Trans.failedToAddAll.trans(args: [name?.trans(capital: false) ?? ""]));
  } else if (operationType == OperationType.FailedAddOne) {
    return error ??
        (Trans.failedToAddOne.trans(args: [name?.trans(capital: false) ?? ""]));
  } else {
    throw Exception("Unknown operation type:  $operationType");
  }
}

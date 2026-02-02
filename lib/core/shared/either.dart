part of "imports.dart";

/// Base Either class
///
/// Receives two values [L] and [R]
/// as [L] is an error and [R] is a success.
abstract class Either<L, R> {
  /// Default constructor.
  const Either();

  /// Returns the current result.
  ///
  /// It may be a [Right] or an [Left].
  /// Check with
  /// ```dart
  ///   result.isRight();
  /// ```
  /// or
  /// ```dart
  ///   result.isLeft();
  /// ```
  ///
  /// before casting the value;
  dynamic get();

  /// Returns the value of [R].
  R? getRight(R Function() dflt);

  /// Returns the value of [L].
  L? getLeft();

  /// Returns true if the current result is an [Left].
  bool isLeft();

  /// Returns true if the current result is a [success].
  bool isRight();

  /// Return the result in one of these functions.
  ///
  /// if the result is an error, it will be returned in
  /// [whenError],
  /// if it is a success it will be returned in [whenSuccess].
  W when<W>(
    W Function(L error) whenError,
    W Function(R success) whenSuccess,
  );
  W fold<W>(
    W Function(L error) whenError,
    W Function(R success) whenSuccess,
  );
}

/// Right Either.
///
/// return it when the result of a [Either] is
/// the expected value.

class Right<L, R> implements Either<L, R> {
  /// Receives the [R] param as
  /// the successful result.
  const Right(this._success);

  final R _success;

  @override
  R get() {
    return _success;
  }

  @override
  bool isLeft() => false;

  @override
  bool isRight() => true;

  @override
  int get hashCode => _success.hashCode;

  @override
  bool operator ==(Object other) =>
      other is Right && other._success == _success;

  @override
  W when<W>(
    W Function(L error) whenError,
    W Function(R success) whenSuccess,
  ) {
    return whenSuccess(_success);
  }

  @override
  W fold<W>(
    W Function(L error) whenError,
    W Function(R success) whenSuccess,
  ) {
    return whenSuccess(_success);
  }

  @override
  String toString() {
    return "Right:(${get()})";
  }

  @override
  L? getLeft() => null;

  @override
  R? getRight(R Function() dflt) =>
      fold((error) => dflt(), (success) => success);
}

/// Left Either.
///
/// return it when the result of a [Either] is
/// not the expected value.

class Left<L, R> implements Either<L, R> {
  /// Receives the [L] param as
  /// the error result.
  const Left(this._error);

  final L _error;

  @override
  L get() {
    return _error;
  }

  @override
  bool isLeft() => true;

  @override
  bool isRight() => false;

  @override
  int get hashCode => _error.hashCode;

  @override
  bool operator ==(Object other) => other is Left && other._error == _error;

  @override
  W when<W>(
    W Function(L error) whenError,
    W Function(R succcess) whenSuccess,
  ) {
    return whenError(_error);
  }

  @override
  W fold<W>(
    W Function(L error) whenError,
    W Function(R succcess) whenSuccess,
  ) {
    return whenError(_error);
  }

  @override
  L? getLeft() => _error;
  @override
  String toString() {
    return "Left:(${get()})";
  }

  @override
  R? getRight(R Function() dflt) =>
      fold((error) => dflt(), (success) => success);
}

/// Default success class.
///
/// Instead of returning void, as
/// ```dart
///   Either<Exception, void>
/// ```
/// return
/// ```dart
///   Either<Exception, SuccessResult>
/// ```
class SuccessResult {
  const SuccessResult._internal();
}

/// Default success case.
const success = SuccessResult._internal();

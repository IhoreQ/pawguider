import 'package:front_flutter/exceptions/api_error.dart';

sealed class Result<S, E> {
  const Result();
}

final class Success<S, E> extends Result<S, E> {
  const Success(this.value);
  final S value;
}

final class Failure<S, E> extends Result<S, E> {
  const Failure(this.error);
  final ApiError error;
}
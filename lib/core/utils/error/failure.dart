abstract class Failure implements Exception {
  Failure({required this.errorMessage, this.errorCode});

  int? errorCode;
  final String errorMessage;
}

class BadResponseFailure extends Failure {
  BadResponseFailure({super.errorCode, required super.errorMessage});
}

class NetworkFailure extends Failure {
  NetworkFailure({super.errorCode, required super.errorMessage});
}

class TimeoutFailure extends Failure {
  TimeoutFailure({super.errorCode, required super.errorMessage});
}

class UnexpectedFailure extends Failure {
  UnexpectedFailure({super.errorCode, required super.errorMessage});
}

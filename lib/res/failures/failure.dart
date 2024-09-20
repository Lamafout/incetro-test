class Failure{
  final String message;
  Failure(this.message);
  @override
  String toString() => 'Failure: $message';
}

class IncorrectTokenFailure extends Failure{
  IncorrectTokenFailure(super.message);
}

class NoTokenFailure extends Failure{
  NoTokenFailure(super.message);
}

class NoInternetFailure extends Failure{
  NoInternetFailure(super.message);
}

class IncorrectCodeFailure extends Failure{
  IncorrectCodeFailure(super.message);
}

class BadRequestException implements Exception{
  final String message;
  BadRequestException(this.message);
  @override
  String toString() => 'BadRequestException: $message';
}

class IncorrectTokenException implements Exception{
  final String message;
  IncorrectTokenException(this.message);
  @override
  String toString() => 'IncorrectTokenException: $message';
}

class IsAlreadyLikedException implements Exception{
  final String message;
  IsAlreadyLikedException(this.message);
  @override
  String toString() => 'IsAlreadyLiked: $message';
}

class IsAlreadyLikesFailure extends Failure {
  IsAlreadyLikesFailure(super.message);
}
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

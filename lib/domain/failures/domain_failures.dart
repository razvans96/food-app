abstract class DomainFailure implements Exception {

  final String message;
  const DomainFailure(this.message);

  
  @override
  String toString() => message;
}

class InvalidEmailFailure extends DomainFailure {
  const InvalidEmailFailure(super.message);
}

class InvalidUserIdFailure extends DomainFailure {
  const InvalidUserIdFailure(super.message);
}

class InvalidBarcodeFailure extends DomainFailure {
  const InvalidBarcodeFailure(super.message);
}

class ExternalServiceFailure extends DomainFailure {
  const ExternalServiceFailure(super.message);
}

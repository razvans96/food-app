sealed class Result<T> {
  const Result();
}

class Success<T> extends Result<T> {
  final String message;
  final T data;
  
  const Success(this.message, this.data);
  
  @override
  String toString() => 'Success(message: $message, data: $data)';
}

class Failure<T> extends Result<T> {
  final String error;
  
  const Failure(this.error);
  
  @override
  String toString() => 'Failure(error: $error)';
}

extension ResultExtensions<T> on Result<T> {
  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Failure<T>;
  
  String get message => switch (this) {
    Success(message: final msg) => msg,
    Failure(error: final error) => error,
  };
  
  T? get data => switch (this) {
    Success(data: final data) => data,
    Failure() => null,
  };
  
  String? get error => switch (this) {
    Success() => null,
    Failure(error: final error) => error,
  };

  R fold<R>(
    R Function(String error) onFailure,
    R Function(T data) onSuccess,
  ) {
    return switch (this) {
      Success(data: final data) => onSuccess(data),
      Failure(error: final error) => onFailure(error),
    };
  }
}

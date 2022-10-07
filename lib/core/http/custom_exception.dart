class BaseException implements Exception {
  BaseException(this._messages, {this.prefix, required this.errorCode});

  final dynamic _messages;
  final int errorCode;
  final dynamic prefix;

  String toString() {
    return "$prefix${getMessage()}";
  }

  int getErrorCode() {
    return this.errorCode;
  }

  String getMessage() {
    return _messages.toString();
  }
}

class FetchDataException extends BaseException {
  FetchDataException(messages, errorCode)
      : super(messages, errorCode: errorCode, prefix: "No internet connection");

  FetchDataException.no() :super({
    "error": [
      'Error occurred while Communication with Server with StatusCode : 0'
    ]
  }, errorCode: 0, prefix: "No internet connection");

}

class BadRequestException extends BaseException {
  BadRequestException(messages, errorCode)
      : super(messages, errorCode: errorCode);
}

class UnauthorizedException extends BaseException {
  UnauthorizedException(messages, errorCode)
      : super(messages, errorCode: errorCode, prefix: "Unauthorized");
}

class InvalidInputException extends BaseException {
  InvalidInputException(messages, errorCode)
      : super(messages, errorCode: errorCode, prefix: "Bad request");
}

class SystemException extends BaseException {
  SystemException(messages, errorCode)
      : super(messages, errorCode: errorCode, prefix: "System exception");
}

class HttpException implements Exception {
  String message;
  HttpException([this.message = 'Something went wrong']) {
    message = 'Response Exception: $message';
  }

  @override
  String toString() {
    return message;
  }
}
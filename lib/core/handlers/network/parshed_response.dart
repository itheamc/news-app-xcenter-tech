class ParsedResponse<T> {
  final bool isSuccess;
  final String? message;
  final T? data;

  ParsedResponse({
    this.isSuccess = true,
    this.message,
    this.data,
  });
}

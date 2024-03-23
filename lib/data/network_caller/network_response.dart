class NetworkResponse {
  final int? statusCode;
  final bool isSuccess;
  final dynamic? jsonResponse;
  final String? errorMessage;

  NetworkResponse({
    this.statusCode,
    required this.isSuccess,
    this.jsonResponse,
    this.errorMessage = "Something went to wrong",
  });
}
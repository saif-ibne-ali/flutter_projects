class ResponseData {
  final bool isSuccess;
  final int statusCode;
  final String errorMessage;
  final dynamic responseData;

  ResponseData(
      {this.errorMessage = 'Something went Wrong',
      required this.isSuccess,
      required this.statusCode,
      required this.responseData});
}

import 'package:http/http.dart' as http;

/// The class represents a response from a Facebook post request, including whether it was successful, a
/// message, and the HTTP response.
class FacebookPostResponse {
  final bool isSuccess;
  final String message;
  final http.Response? response;

  FacebookPostResponse(
      {required this.isSuccess, required this.message, this.response});
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:post_to_facebook/models/facebook_post_response.dart';

/// This function posts a message to a Facebook page using the Facebook Graph API and returns a response
/// indicating whether the post was successful or not.
///
/// Args:
///   accessToken (String): A string representing the access token for the Facebook account that has
/// permission to post to the specified Facebook page.
///   pageId (String): The ID of the Facebook page where the post will be made.
///   message (String): The message that you want to post on the Facebook page.
///
/// Returns:
///   A `Future` of `FacebookPostResponse` object is being returned.
Future<FacebookPostResponse> postToFacebook(
    {required String accessToken,
    required String pageId,
    required String message}) async {
  final url = Uri.parse(
      'https://graph.facebook.com/v16.0/$pageId/feed?access_token=$accessToken');

  final response = await http.post(url, body: {'message': message});

  /// This code block is checking if the HTTP response status code is equal to 200, which indicates a
  /// successful request. If the status code is 200, it creates a new `FacebookPostResponse` object with
  /// `isSuccess` set to `true`, a success message, and the HTTP response. It then returns this object
  /// as the result of the `postToFacebookPage` function.
  if (response.statusCode == 200) {
    return FacebookPostResponse(
      isSuccess: true,
      message: 'Successfully posted to Facebook page.',
      response: response,
    );
  }

  /// This code block is executed if the HTTP response status code is not equal to 200, indicating
  /// that the request to post to the Facebook page was not successful. It decodes the response body
  /// using JSON and extracts the error message from the response body. It then creates a new
  /// `FacebookPostResponse` object with `isSuccess` set to `false`, an error message indicating the
  /// reason for the failure, and the HTTP response. This object is then returned as the result of the
  /// `postToFacebookPage` function.
  else {
    final responseBody = json.decode(response.body);
    final errorMessage = responseBody['error']['message'];
    return FacebookPostResponse(
      isSuccess: false,
      message: 'Failed to post to Facebook page: $errorMessage',
      response: response,
    );
  }
}

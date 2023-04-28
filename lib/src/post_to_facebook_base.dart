import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:post_to_facebook/src/facebook_post_response.dart';

/// Posts a message and/or image to a Facebook page using the Facebook Graph API.
///
/// Required parameters:
/// * [accessToken]: The access token for the Facebook app associated with the page.
/// * [pageId]: The ID of the Facebook page to post to.
/// * [message]: The message to include in the post.
///
/// Optional parameter:
/// * [imageUrl]: The URL of the image to include in the post.
///
/// Returns a [Future] that completes with a [FacebookPostResponse] object containing:
/// * [isSuccess]: A [bool] indicating whether the post was successful.
/// * [message]: A [String] with a message describing the outcome of the post attempt.
/// * [response]: An [http.Response] object containing the response data from the Facebook API.
Future<FacebookPostResponse> postToFacebook({
  required String accessToken,
  required String pageId,
  required String message,
  String? imageUrl,
}) async {
  final url = Uri.parse(
      'https://graph.facebook.com/v16.0/$pageId/photos?access_token=$accessToken');

// Build the request body
  final body = {'message': message};
  if (imageUrl != null) {
    body['url'] = imageUrl;
  }
  final response = await http.post(url, body: body);

  if (response.statusCode == 200) {
    return FacebookPostResponse(
      isSuccess: true,
      message: 'Successfully posted to Facebook page.',
      response: response,
    );
  } else {
    final responseBody = json.decode(response.body);
    final errorMessage = responseBody['error']['message'];
    return FacebookPostResponse(
      isSuccess: false,
      message: 'Failed to post to Facebook page: $errorMessage',
      response: response,
    );
  }
}

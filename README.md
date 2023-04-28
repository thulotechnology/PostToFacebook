# `post_to_facebook`

A Dart package for posting content to Facebook on behalf of a user or page.

## Installation

To use this package, add post_to_facebook as a dependency in your pubspec.yaml file:

``` dart
dependencies:
  post_to_facebook: ^1.0.0
```

## Usage

To use this package, you need to have a valid Facebook access token that has the publish_pages and/or publish_to_groups permissions, depending on the targets you want to post to. You can obtain an access token by creating a Facebook app, authorizing it with your Facebook account, and using the app ID and secret to generate a token via the [Graph API Explorer][gApi].

[gApi]: https://developers.facebook.com/docs/graph-api/get-started

Here's an example of how to use the post_to_facebook function:

``` dart
import 'package:post_to_facebook/post_to_facebook.dart';

void main() async {
  final accessToken = 'your-access-token';
  final message = 'Hello, Facebook!';
  final pageId= 'your-page-id';
  try {
    await postToFacebook(
      accessToken: accessToken,
      message: message,
      pageId: pageId,
    );
    if (result.isSuccess) {
      print(result.message);
    } else {
      print(result.message);
      print('Response code: ${result.response?.statusCode}');
      print('Response body: ${result.response?.body}');
    }
  } catch (e) {
    print('Post failed with error: $e');
  }
}
```

## License

This package is licensed under the MIT License. See the LICENSE file for details.

## Contributions

Please file issues and feature requests in the GitHub repository. Contributions via pull requests are welcome and encouraged.

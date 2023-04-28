import 'package:flutter/material.dart';
import 'package:post_to_facebook/post_to_facebook.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Facebook Posting Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //Enter your message to post to Facebook
  String _message = '';
  //Get your access token and use it here
  var _accessToken = '';
  //Get your page  id and use it here
  var _pageId = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Facebook Posting Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                onChanged: (value) {
                  setState(() {
                    _message = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Enter your message',
                ),
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    _accessToken = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Enter your access token',
                ),
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    _pageId = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Enter your page ID',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  /// `postToFacebookPage` is a function from the `post_to_facebook` package that is being
                  /// called with three parameters: `accessToken`, `message`, and `pageId`. It is being
                  /// awaited and the result is being stored in the `result` variable. The function is
                  /// responsible for posting the message to the Facebook page associated with the provided
                  /// `pageId` using the provided `accessToken`. The `result` variable will contain
                  /// information about whether the post was successful or not, along with any relevant
                  /// error messages or response data.
                  final result = await postToFacebook(
                    accessToken: _accessToken,
                    message: _message,
                    pageId: _pageId,
                  );

                  /// This code block is checking the result of the `postToFacebookPage` function call. If
                  /// the post was successful, it will print the message returned by the function. If the
                  /// post was not successful, it will print the error message returned by the function,
                  /// along with the response code and response body (if available). The
                  /// `result.isSuccess` property is used to determine whether the post was successful or
                  /// not.
                  if (result.isSuccess) {
                    print(result.message);
                  } else {
                    print(result.message);
                    print('Response code: ${result.response?.statusCode}');
                    print('Response body: ${result.response?.body}');
                  }
                  setState(() {
                    _message = '';
                    _accessToken = '';
                    _pageId = '';
                  });
                },
                child: Text('Post to Facebook'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

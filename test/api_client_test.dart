import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';

void main() {
  final httpClient = http.Client();

  group('ApiClientTest', () {
    test('GetCategories', () async {
      try {
        final response = await httpClient.get(Uri.parse(
            'https://c6bs6iq059.execute-api.sa-east-1.amazonaws.com/api/category'));
        print(response.statusCode);
        print(response.body);
      } catch (e) {
        print(e);
      }
    });
  });
}

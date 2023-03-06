import 'package:flutter_test/flutter_test.dart';

void main() {
  test("formato", () {
    print(DateTime.now().toUtc().toIso8601String());
  });
}

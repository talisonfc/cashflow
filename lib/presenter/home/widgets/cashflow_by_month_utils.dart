import 'package:get/get.dart';

(int, int) getParameters() {
  final params = Get.parameters;
  if (params.isNotEmpty) {
    if (params.containsKey('year') && params.containsKey('month')) {
      final year = int.parse(params['year']!);
      final month = int.parse(params['month']!);
      return (year, month);
    }
  } else {
    final now = DateTime.now();
    return (now.year, now.month);
  }
  return (0, 0);
}

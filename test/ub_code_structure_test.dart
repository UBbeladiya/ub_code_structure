import 'package:flutter_test/flutter_test.dart';

import 'package:ub_code_structure/ub_code_structure.dart';

void main() {
  test('exposes package metadata', () {
    expect(UbCodeStructure.packageName, 'ub_code_structure');
    expect(UbCodeStructure.summary, isNotEmpty);
  });
}

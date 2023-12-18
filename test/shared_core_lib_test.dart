import 'package:flutter_test/flutter_test.dart';
import 'package:shared_flutter_lib/shared_flutter_lib.dart';

void main() {
  test('Optional with null value', () {
    expect(
      switch (Optional.from<String>(null)) {
        Some(:final value) => value,
        _ => null,
      },
      null,
    );
  });
  test('Optional with exist value', () {
    const str = 'Hello';
    expect(
      switch (Optional.from(str)) {
        Some(:final value) => value,
        _ => null,
      },
      str,
    );
  });
}

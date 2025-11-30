import 'package:chat_app/themes/dark_mode.dart';
import 'package:chat_app/themes/light_mode.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('themes have distinct brightness', () {
    expect(lightMode.brightness, isNot(darkMode.brightness));
  });
}

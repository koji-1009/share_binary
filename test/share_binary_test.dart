import 'package:flutter_test/flutter_test.dart';
import 'package:share_binary/share_binary_method_channel.dart';
import 'package:share_binary/share_binary_platform_interface.dart';

void main() {
  final ShareBinaryPlatform initialPlatform = ShareBinaryPlatform.instance;

  test('$MethodChannelShareBinary is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelShareBinary>());
  });
}

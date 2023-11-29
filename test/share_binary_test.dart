import 'package:flutter_test/flutter_test.dart';
import 'package:share_binary/share_binary.dart';
import 'package:share_binary/share_binary_platform_interface.dart';
import 'package:share_binary/share_binary_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockShareBinaryPlatform
    with MockPlatformInterfaceMixin
    implements ShareBinaryPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final ShareBinaryPlatform initialPlatform = ShareBinaryPlatform.instance;

  test('$MethodChannelShareBinary is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelShareBinary>());
  });

  test('getPlatformVersion', () async {
    ShareBinary shareBinaryPlugin = ShareBinary();
    MockShareBinaryPlatform fakePlatform = MockShareBinaryPlatform();
    ShareBinaryPlatform.instance = fakePlatform;

    expect(await shareBinaryPlugin.getPlatformVersion(), '42');
  });
}

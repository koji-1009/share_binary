import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:share_binary/share_binary.dart';
import 'package:share_binary/src/share_binary_method_channel.dart';
import 'package:share_binary/src/share_binary_platform_interface.dart';

base class FakeShareBinaryPlatform extends ShareBinaryPlatform {
  final calls = <({String method, Map<String, Object?> args})>[];

  @override
  Future<void> shareBinary({
    required Uint8List bytes,
    required String filename,
    String? chooserTitle,
  }) async {
    calls.add((
      method: 'shareBinary',
      args: {
        'bytes': bytes,
        'filename': filename,
        'chooserTitle': chooserTitle,
      },
    ));
  }

  @override
  Future<void> shareUri({required Uri uri, String? chooserTitle}) async {
    calls.add((
      method: 'shareUri',
      args: {'uri': uri, 'chooserTitle': chooserTitle},
    ));
  }
}

void main() {
  final initialPlatform = ShareBinaryPlatform.instance;

  test('default instance is MethodChannelShareBinary', () {
    expect(initialPlatform, isInstanceOf<MethodChannelShareBinary>());
  });

  group('ShareBinary delegates to platform', () {
    late FakeShareBinaryPlatform fakePlatform;

    setUp(() {
      fakePlatform = FakeShareBinaryPlatform();
      ShareBinaryPlatform.instance = fakePlatform;
    });

    tearDown(() {
      ShareBinaryPlatform.instance = initialPlatform;
    });

    test('shareBinary delegates with correct arguments', () async {
      final bytes = Uint8List.fromList([1, 2, 3]);

      await const ShareBinary().shareBinary(
        bytes: bytes,
        filename: 'image.png',
        chooserTitle: 'Share',
      );

      expect(fakePlatform.calls, hasLength(1));
      expect(fakePlatform.calls.first.method, 'shareBinary');
      expect(fakePlatform.calls.first.args['bytes'], bytes);
      expect(fakePlatform.calls.first.args['filename'], 'image.png');
      expect(fakePlatform.calls.first.args['chooserTitle'], 'Share');
    });

    test('shareUri delegates with correct arguments', () async {
      final uri = Uri.parse('https://example.com');

      await const ShareBinary().shareUri(uri: uri, chooserTitle: 'Open');

      expect(fakePlatform.calls, hasLength(1));
      expect(fakePlatform.calls.first.method, 'shareUri');
      expect(fakePlatform.calls.first.args['uri'], uri);
      expect(fakePlatform.calls.first.args['chooserTitle'], 'Open');
    });
  });
}

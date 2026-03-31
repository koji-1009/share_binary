import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:share_binary/src/share_binary_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final methodChannel = MethodChannelShareBinary();
  final log = <MethodCall>[];

  setUp(() {
    log.clear();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(methodChannel.methodChannel, (call) async {
          log.add(call);
          return null;
        });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(methodChannel.methodChannel, null);
  });

  group('shareBinary', () {
    test('invokes shareBinary with correct arguments', () async {
      final bytes = Uint8List.fromList([1, 2, 3]);

      await methodChannel.shareBinary(
        bytes: bytes,
        filename: 'test.png',
        chooserTitle: 'Share',
      );

      expect(log, hasLength(1));
      expect(log.first.method, 'shareBinary');
      expect(log.first.arguments['bytes'], bytes);
      expect(log.first.arguments['filename'], 'test.png');
      expect(log.first.arguments['chooserTitle'], 'Share');
    });

    test('passes null chooserTitle when not provided', () async {
      final bytes = Uint8List.fromList([0]);

      await methodChannel.shareBinary(bytes: bytes, filename: 'file.pdf');

      expect(log, hasLength(1));
      expect(log.first.arguments['chooserTitle'], isNull);
    });
  });

  group('shareUri', () {
    test('invokes shareUri with correct arguments', () async {
      await methodChannel.shareUri(
        uri: Uri.parse('https://example.com'),
        chooserTitle: 'Open',
      );

      expect(log, hasLength(1));
      expect(log.first.method, 'shareUri');
      expect(log.first.arguments['uri'], 'https://example.com');
      expect(log.first.arguments['chooserTitle'], 'Open');
    });

    test('passes null chooserTitle when not provided', () async {
      await methodChannel.shareUri(uri: Uri.parse('https://example.com/path'));

      expect(log, hasLength(1));
      expect(log.first.arguments['chooserTitle'], isNull);
    });
  });
}

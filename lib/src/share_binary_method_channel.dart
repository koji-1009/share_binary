import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'share_binary_platform_interface.dart';

/// An implementation of [ShareBinaryPlatform] that uses method channels.
final class MethodChannelShareBinary extends ShareBinaryPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('com.dr1009.app/share_binary');

  /// Share binary data
  ///
  ///   - [bytes] is required, set binary data.
  ///   - [filename] is required, the extension is important for inter-app cooperation.
  ///     On Android, the file name must be 127 characters or less.
  ///   - [chooserTitle] is only for Android.
  @override
  Future<void> shareBinary({
    required Uint8List bytes,
    required String filename,
    String? chooserTitle,
  }) async {
    await methodChannel.invokeMethod<void>(
      'shareBinary',
      <String, dynamic>{
        'bytes': bytes,
        'filename': filename,
        'chooserTitle': chooserTitle,
      },
    );
  }

  /// Share [Uri]
  ///
  ///  - [uri] is required, set [Uri] data.
  ///    It must be a URI with the necessary settings to share content.
  ///  - [chooserTitle] is only for Android.
  @override
  Future<void> shareUri({
    required Uri uri,
    String? chooserTitle,
  }) async {
    await methodChannel.invokeMethod<void>(
      'shareUri',
      <String, dynamic>{
        'uri': uri.toString(),
        'chooserTitle': chooserTitle,
      },
    );
  }
}

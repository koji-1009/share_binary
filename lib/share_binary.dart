import 'package:flutter/foundation.dart';

import 'src/share_binary_platform_interface.dart';

/// A plugin that easily inter-app cooperation binary
class ShareBinary {
  const ShareBinary();

  /// Share binary data
  ///
  ///   - [bytes] is required, set binary data.
  ///   - [filename] is required, the extension is important for inter-app cooperation.
  ///     On Android, the file name must be 127 characters or less.
  ///   - [chooserTitle] is only for Android.
  Future<void> shareBinary({
    required Uint8List bytes,
    required String filename,
    String? chooserTitle,
  }) =>
      ShareBinaryPlatform.instance.shareBinary(
        bytes: bytes,
        filename: filename,
        chooserTitle: chooserTitle,
      );

  /// Share [Uri]
  ///
  ///  - [uri] is required, set [Uri] data.
  ///    It must be a URI with the necessary settings to share content.
  ///  - [chooserTitle] is only for Android.
  Future<void> shareUri({
    required Uri uri,
    String? chooserTitle,
  }) =>
      ShareBinaryPlatform.instance.shareUri(
        uri: uri,
        chooserTitle: chooserTitle,
      );
}

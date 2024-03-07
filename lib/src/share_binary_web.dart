import 'dart:js_interop';

import 'package:web/web.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:mime/mime.dart';

import 'share_binary_platform_interface.dart';

/// A web implementation of the ShareBinaryPlatform of the ShareBinary plugin.
final class ShareBinaryWeb extends ShareBinaryPlatform {
  /// Constructs a ShareBinaryWeb
  ShareBinaryWeb();

  static void registerWith(Registrar registrar) {
    ShareBinaryPlatform.instance = ShareBinaryWeb();
  }

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
    final mimeType = lookupMimeType(filename) ?? 'application/octet-stream';
    final blob = Blob(
      [bytes.buffer.toJS].toJS,
      BlobPropertyBag(
        type: mimeType,
      ),
    );
    final url = URL.createObjectURL(blob);

    final anchor = HTMLAnchorElement()
      ..href = url
      ..download = filename
      ..click();

    URL.revokeObjectURL(url);
    anchor.remove();
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
    window.open(uri.toString(), '_blank');
  }
}

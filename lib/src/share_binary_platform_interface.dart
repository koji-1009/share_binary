import 'package:flutter/foundation.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'share_binary_method_channel.dart';

base class ShareBinaryPlatform extends PlatformInterface {
  /// Constructs a ShareBinaryPlatform.
  ShareBinaryPlatform() : super(token: _token);

  static final Object _token = Object();

  static ShareBinaryPlatform _instance = MethodChannelShareBinary();

  /// The default instance of [ShareBinaryPlatform] to use.
  ///
  /// Defaults to [MethodChannelShareBinary].
  static ShareBinaryPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ShareBinaryPlatform] when
  /// they register themselves.
  static set instance(ShareBinaryPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

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
  }) {
    throw UnimplementedError('shareBinary() has not been implemented.');
  }

  /// Share [Uri]
  ///
  ///  - [uri] is required, set [Uri] data.
  ///    It must be a URI with the necessary settings to share content.
  ///  - [chooserTitle] is only for Android.
  Future<void> shareUri({
    required Uri uri,
    String? chooserTitle,
  }) {
    throw UnimplementedError('shareUri() has not been implemented.');
  }
}

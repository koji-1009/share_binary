import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'share_binary_platform_interface.dart';

/// An implementation of [ShareBinaryPlatform] that uses method channels.
class MethodChannelShareBinary extends ShareBinaryPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('share_binary');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}

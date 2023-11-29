
import 'share_binary_platform_interface.dart';

class ShareBinary {
  Future<String?> getPlatformVersion() {
    return ShareBinaryPlatform.instance.getPlatformVersion();
  }
}

# share_binary

This library allows you to use the OS's share function while treating binary files such as images and videos as binary data in dart code.

## Usage

```dart
import 'package:share_binary/share_binary.dart';

Future<void> shareImage() async {
  final image = await rootBundle.load('assets/image.png');

  await const ShareBinary().shareBinary(
    bytes: image,
    filename: 'image.png',
    chooserTitle: 'Share image',
  );
}

Future<void> shareVideo() async {
  final video = await rootBundle.load('assets/video.mp4');

  await const ShareBinary().shareBinary(
    bytes: video,
    filename: 'video.mp4',
    chooserTitle: 'Share video',
  );
}
```

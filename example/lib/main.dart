import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_binary/share_binary.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
          brightness: Brightness.dark,
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          OutlinedButton(
            onPressed: () async {
              final byteData = await rootBundle.load('assets/image.png');
              final bytes = _converter(byteData);
              await const ShareBinary().shareBinary(
                bytes: bytes,
                filename: 'image.png',
                chooserTitle: 'Share binary',
              );
            },
            child: const Text('Share Image'),
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () async {
              final byteData = await rootBundle.load('assets/pdf.pdf');
              final bytes = _converter(byteData);
              await const ShareBinary().shareBinary(
                bytes: bytes,
                filename: 'pdf.pdf',
                chooserTitle: 'Share pdf',
              );
            },
            child: const Text('Share PDF'),
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () async {
              final byteData = await rootBundle.load('assets/word.doc');
              final bytes = _converter(byteData);
              await const ShareBinary().shareBinary(
                bytes: bytes,
                filename: 'word.doc',
                chooserTitle: 'Share word(doc)',
              );
            },
            child: const Text('Share Word(doc)'),
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () async {
              final byteData = await rootBundle.load('assets/word.docx');
              final bytes = _converter(byteData);
              await const ShareBinary().shareBinary(
                bytes: bytes,
                filename: 'word.docx',
                chooserTitle: 'Share word(docx)',
              );
            },
            child: const Text('Share Word(docx)'),
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () async {
              await const ShareBinary().shareUri(
                uri: Uri.parse("https://www.google.com/"),
                chooserTitle: 'Share URI',
              );
            },
            child: const Text('Share URI'),
          ),
        ],
      ),
    );
  }

  Uint8List _converter(ByteData data) =>
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
}

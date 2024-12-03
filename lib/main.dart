
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:url_launcher/link.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'リンク実装比較サンプル';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: const LinkComparisonPage(),
    );
  }
}

class LinkComparisonPage extends StatelessWidget {
  const LinkComparisonPage({Key? key}) : super(key: key);

  final String linkUrl = 'https://example.com';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('リンク実装比較サンプル'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              '方法1: SelectableText.rich を使用',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Method1SelectableTextRich(linkUrl: linkUrl),
            const Divider(height: 32),
            const Text(
              '方法2: Link ウィジェットを使用',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Method2LinkWidget(linkUrl: linkUrl),
            const Divider(height: 32),
            const Text(
              '方法3: RichText と GestureRecognizer を使用',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Method3RichTextGestureRecognizer(linkUrl: linkUrl),
            const Divider(height: 32),
            const Text(
              '方法4: TextButton を使用',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Method4TextButton(linkUrl: linkUrl),
            const Divider(height: 32),
            const Text(
              '方法5: InkWell を使用',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Method5InkWell(linkUrl: linkUrl),
          ],
        ),
      ),
    );
  }
}

// 方法1: SelectableText.rich を使用
class Method1SelectableTextRich extends StatelessWidget {
  const Method1SelectableTextRich({Key? key, required this.linkUrl}) : super(key: key);

  final String linkUrl;

  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      TextSpan(
        text: 'これは ',
        style: const TextStyle(color: Colors.black),
        children: [
          TextSpan(
            text: 'リンクテキスト',
            style: const TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                if (await canLaunchUrlString(linkUrl)) {
                  await launchUrlString(linkUrl, mode: LaunchMode.platformDefault);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('URLを開けません: $linkUrl')),
                  );
                }
              },
          ),
          const TextSpan(
            text: ' を含む文章です。テキストの選択が可能です。',
          ),
        ],
      ),
    );
  }
}

// 方法2: Link ウィジェットを使用
class Method2LinkWidget extends StatelessWidget {
  const Method2LinkWidget({Key? key, required this.linkUrl}) : super(key: key);

  final String linkUrl;

  @override
  Widget build(BuildContext context) {
    return Link(
      uri: Uri.parse(linkUrl),
      target: LinkTarget.blank, // 新しいタブで開く
      builder: (BuildContext context, Future<void> Function()? followLink) {
        return GestureDetector(
          onTap: followLink,
          child: Text(
            'リンクテキスト（右クリックメニュー有効）',
            style: const TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
          ),
        );
      },
    );
  }
}

// 方法3: RichText と GestureRecognizer を使用
class Method3RichTextGestureRecognizer extends StatelessWidget {
  const Method3RichTextGestureRecognizer({Key? key, required this.linkUrl}) : super(key: key);

  final String linkUrl;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'これは ',
        style: const TextStyle(color: Colors.black),
        children: [
          TextSpan(
            text: 'リンクテキスト',
            style: const TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                if (await canLaunchUrlString(linkUrl)) {
                  await launchUrlString(linkUrl, mode: LaunchMode.platformDefault);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('URLを開けません: $linkUrl')),
                  );
                }
              },
          ),
          const TextSpan(
            text: ' を含む文章です。テキストの選択はできません。',
          ),
        ],
      ),
    );
  }
}

// 方法4: TextButton を使用
class Method4TextButton extends StatelessWidget {
  const Method4TextButton({Key? key, required this.linkUrl}) : super(key: key);

  final String linkUrl;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        if (await canLaunchUrlString(linkUrl)) {
          await launchUrlString(linkUrl, mode: LaunchMode.platformDefault);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('URLを開けません: $linkUrl')),
          );
        }
      },
      child: const Text(
        'リンクテキスト（ボタン）',
        style: TextStyle(
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}

// 方法5: InkWell を使用
class Method5InkWell extends StatelessWidget {
  const Method5InkWell({Key? key, required this.linkUrl}) : super(key: key);

  final String linkUrl;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (await canLaunchUrlString(linkUrl)) {
          await launchUrlString(linkUrl, mode: LaunchMode.platformDefault);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('URLを開けません: $linkUrl')),
          );
        }
      },
      child: Text(
        'リンクテキスト（InkWell）',
        style: const TextStyle(
          color: Colors.blue,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}

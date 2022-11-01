import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetail extends StatefulWidget {
  final String url;
  final String title;

  const NewsDetail({
    super.key,
    required this.url,
    required this.title,
  });

  @override
  NewsDetailState createState() => NewsDetailState();
}

class NewsDetailState extends State<NewsDetail> {
  bool loaded = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> titleContent = [];
    if (!loaded) {
      titleContent.add(const CupertinoActivityIndicator());
    }
    titleContent.add(Container(width: 50.0));
    return WebView(
      initialUrl: widget.url,
    );
  }
}

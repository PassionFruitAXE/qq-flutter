import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

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
  final flutterWebviewPlugin = FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();
    flutterWebviewPlugin.onStateChanged.listen((state) {
      if (state.type == WebViewState.finishLoad) {
        setState(() {
          loaded = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> titleContent = [];
    if (!loaded) {
      titleContent.add(const CupertinoActivityIndicator());
    }
    titleContent.add(Container(width: 50.0));
    return WebviewScaffold(
      url: widget.url,
      appBar: AppBar(
          title: Expanded(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: titleContent,
      ))),
      withZoom: false,
      withLocalStorage: true,
      withJavascript: true,
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../api/generalNews.dart';
import '../../../model/new.dart';
import '../../../vendor/fluttertoast/global_message.dart';
import '../../../vendor/shared_preferences/storage.dart';
import '../../../vendor/sqflite/domain/user.dart';
import 'news_details/news_details.dart';

class Status extends StatefulWidget {
  final User? myAccount;

  const Status({super.key, required this.myAccount});

  @override
  StatusState createState() => StatusState();
}

class StatusState extends State<Status> {
  List<New> _news = [];
  bool _cancelConnect = false;

  void getNews() {
    getGeneralNews()
        .then((response) async {
          // 读取本地五条缓存新闻
          List<New>? cacheNews = await getCacheNews();
          if (!_cancelConnect) {
            List<dynamic> temp = response!['newslist'];
            List<New> news = temp.map((item) => New.fromMap(item)).toList();
            // 缓存前五条
            setCacheNews(cacheNews ?? news.sublist(0, 5));
            setState(() {
              _news = news;
            });
          }
        })
        .catchError((e) async {
          List<New>? cacheNews = await getCacheNews();
          if (cacheNews != null) {
            setState(() {
              _news = cacheNews;
            });
          }
          GlobalMessage.error("网络请求失败 错误原因${e.toString()}");
        })
        .timeout(const Duration(seconds: 5))
        .catchError((timeout) {
          GlobalMessage.warning('超时：$timeout');
          _cancelConnect = true;
        });
  }

  @override
  void initState() {
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "动态",
        home: Scaffold(
          appBar: AppBar(
            title: const Text("动态"),
            leading: IconButton(
                icon: const Icon(Icons.assistant_photo_outlined),
                onPressed: () {
                  removeCacheNews();
                  getNews();
                }),
          ),
          body: ListView.builder(
              itemCount: _news.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                    color: Colors.grey[250],
                    elevation: 5.0,
                    child: Builder(
                        builder: (context) => InkWell(
                            onTap: () =>
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (content) => NewsDetail(
                                          url: _news[index].url.toString(),
                                          title: _news[index].title.toString(),
                                        ))),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: CachedNetworkImage(
                                      imageUrl: _news[index].picUrl as String,
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          const Image(
                                              image:
                                                  AssetImage('images/加载中.png')),
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(_news[index].title.toString(),
                                          style: const TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold))),
                                  Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text('实践：${_news[index].ctime}',
                                          style:
                                              const TextStyle(fontSize: 12.0)))
                                ]))));
              }),
        ));
  }
}

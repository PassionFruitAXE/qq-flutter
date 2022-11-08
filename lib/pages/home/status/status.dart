import 'package:flutter/material.dart';
import '../../../api/network/generalNews.dart';
import '../../../model/new.dart';
import '../../../utils/global_message.dart';
import '../../../vendor/sqflite/database.dart';
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
        .then((response) {
          if (!_cancelConnect) {
            setState(() {
              List<dynamic> newsList = response!['newslist'];
              _news = newsList.map((item) => New.fromJson(item)).toList();
            });
          }
        })
        .catchError((e) {
          GlobalMessage.error(e.toString());
        })
        .whenComplete(() {
          GlobalMessage.success('热搜获取完毕');
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
                                      child: FadeInImage.assetNetwork(
                                          placeholder: "images/加载中.png",
                                          image:
                                              (_news[index].picUrl as String),
                                          fit: BoxFit.fitWidth)),
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

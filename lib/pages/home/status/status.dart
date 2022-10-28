import 'package:flutter/material.dart';
import '../../../../utils/user.dart';
import '../../../api/generalNews.dart';
import '../../../utils/new.dart';
import '../../../components/news_details.dart';

class Status extends StatefulWidget {
  final User? myAccount;
  const Status(this.myAccount, {super.key});

  @override
  StatusState createState() => StatusState();
}

class StatusState extends State<Status> {
  List<New> _news = [];
  bool _cancelConnect = false;

  @override
  void initState() {
    super.initState();
    getGeneralNews()
        .then((datas) {
          if (!_cancelConnect) {
            setState(() {
              List<dynamic> newsList = datas!['newslist'];
              _news = newsList.map((item) => New.fromJson(item)).toList();
            });
          }
        })
        .catchError((e) {
          print("Error: $e");
        })
        .whenComplete(() {
          print('新闻获取完毕');
        })
        .timeout(const Duration(seconds: 5))
        .catchError((timeout) {
          print('超市：$timeout');
          _cancelConnect = true;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
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
                                Image.network(_news[index].picUrl as String,
                                    fit: BoxFit.fitWidth),
                                Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(_news[index].title.toString(),
                                        style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold))),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10.0),
                                    child: Text('实践：${_news[index].ctime}',
                                        style: const TextStyle(fontSize: 12.0)))
                              ]))));
            }));
  }
}
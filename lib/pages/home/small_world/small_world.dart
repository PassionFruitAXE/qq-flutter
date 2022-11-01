import 'package:flutter/material.dart';
import '../../../../utils/user.dart';
import '../../../api/getHotReviews.dart';
import '../../../utils/hot_review.dart';
import '../../../utils/new.dart';
import '../../../components/news_details.dart';

class SmallWorld extends StatefulWidget {
  final User? myAccount;

  const SmallWorld(this.myAccount, {super.key});

  @override
  SmallWorldState createState() => SmallWorldState();
}

class SmallWorldState extends State<SmallWorld> {
  List<HotReview> _hotReviews = [];
  bool _cancelConnect = false;

  void getReviews() {
    getHotReviews()
        .then((datas) {
          if (!_cancelConnect) {
            setState(() {
              List<dynamic> newsList = datas!['newslist'];
              _hotReviews =
                  newsList.map((item) => HotReview.fromJson(item)).toList();
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
  void initState() {
    super.initState();
    getReviews();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "",
        home: Scaffold(
          appBar: AppBar(
            title: const Text("小世界"),
            leading: IconButton(
                icon: const Icon(Icons.assistant_photo_outlined),
                onPressed: () {}),
          ),
          body: ListView.builder(
              itemCount: _hotReviews.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                    color: Colors.grey[250],
                    elevation: 5.0,
                    child: Builder(
                        builder: (context) => InkWell(
                            onTap: () {},
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                          _hotReviews[index].hotword.toString(),
                                          style: const TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold))),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      child: Text(
                                          '标签：${_hotReviews[index].hottag}',
                                          style:
                                              const TextStyle(fontSize: 12.0))),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      child: Text(
                                          '热度：${_hotReviews[index].hotwordnum}',
                                          style:
                                              const TextStyle(fontSize: 12.0)))
                                ]))));
              }),
        ));
  }
}

class New {
  String? id;
  String? ctime;
  String? title;
  String? description;
  String? source;
  String? picUrl;
  String? url;

  New(
      {this.id,
      this.ctime,
      this.title,
      this.description,
      this.source,
      this.picUrl,
      this.url});

  Map<String, dynamic> toMap() => (<String, dynamic>{
        "id": id,
        "ctime": ctime,
        "title": title,
        "description": description,
        "source": source,
        "picUrl": picUrl,
        "url": url,
      });

  New.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    ctime = map["ctime"];
    title = map["title"];
    description = map["description"];
    source = map["source"];
    picUrl = map["picUrl"];
    url = map["url"];
  }
}

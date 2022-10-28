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
  factory New.fromJson(Map<String, dynamic> json) {
    return New(
        id: json["id"],
        ctime: json["ctime"],
        title: json["title"],
        description: json["description"],
        source: json["source"],
        picUrl: json["picUrl"],
        url: json["url"]);
  }
}

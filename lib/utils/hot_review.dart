class HotReview {
  String? hotword;
  String? hotwordnum;
  String? hottag;

  HotReview({this.hotword, this.hotwordnum, this.hottag});

  factory HotReview.fromJson(Map<String, dynamic> json) {
    return HotReview(
        hotword: json["hotword"],
        hotwordnum: json["hotwordnum"],
        hottag: json["hottag"]);
  }
}

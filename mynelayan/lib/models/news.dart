class News {
  String? newsId;
  String? newsTitle;
  String? newsDetail;
  String? createdAt;

  News({this.newsId, this.newsTitle, this.newsDetail, this.createdAt});

  News.fromJson(Map<String, dynamic> json) {
    newsId = json['news_id'];
    newsTitle = json['news_title'];
    newsDetail = json['news_detail'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['news_id'] = newsId;
    data['news_title'] = newsTitle;
    data['news_detail'] = newsDetail;
    data['created_at'] = createdAt;
    return data;
  }
}
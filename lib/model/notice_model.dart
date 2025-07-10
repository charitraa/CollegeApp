class NoticeModel {
  int? noticeId;
  String? subject;
  String? noticeDate;
  String? publishedOn;

  NoticeModel({this.noticeId, this.subject, this.noticeDate, this.publishedOn});

  NoticeModel.fromJson(Map<String, dynamic> json) {
    noticeId = json['notice_id'];
    subject = json['subject'];
    noticeDate = json['notice_date'];
    publishedOn = json['published_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notice_id'] = this.noticeId;
    data['subject'] = this.subject;
    data['notice_date'] = this.noticeDate;
    data['published_on'] = this.publishedOn;
    return data;
  }
}

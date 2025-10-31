class EmailNoticeModel {
  int? mailId;
  String? subject;
  String? sentOn;
  String? emailText;
  String? mailTo;
  String? mailToname;
  String? mailFrom;
  String? mailFromname;

  EmailNoticeModel(
      {this.mailId,
        this.subject,
        this.sentOn,
        this.emailText,
        this.mailTo,
        this.mailToname,
        this.mailFrom,
        this.mailFromname});

  EmailNoticeModel.fromJson(Map<String, dynamic> json) {
    mailId = json['mail_id'];
    subject = json['subject'];
    sentOn = json['sent_on'];
    emailText = json['email_text'];
    mailTo = json['mail_to'];
    mailToname = json['mail_toname'];
    mailFrom = json['mail_from'];
    mailFromname = json['mail_fromname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mail_id'] = this.mailId;
    data['subject'] = this.subject;
    data['sent_on'] = this.sentOn;
    data['email_text'] = this.emailText;
    data['mail_to'] = this.mailTo;
    data['mail_toname'] = this.mailToname;
    data['mail_from'] = this.mailFrom;
    data['mail_fromname'] = this.mailFromname;
    return data;
  }
}

class SmsModel {
  int? smsId;
  String? mobileNo;
  String? smsMessage;
  String? sentOn;

  SmsModel({this.smsId, this.mobileNo, this.smsMessage, this.sentOn});

  SmsModel.fromJson(Map<String, dynamic> json) {
    smsId = json['sms_id'];
    mobileNo = json['mobile_no'];
    smsMessage = json['sms_message'];
    sentOn = json['sent_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sms_id'] = this.smsId;
    data['mobile_no'] = this.mobileNo;
    data['sms_message'] = this.smsMessage;
    data['sent_on'] = this.sentOn;
    return data;
  }
}

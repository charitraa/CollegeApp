class BalanceModel {
  String? totalDue;
  String? totalPaid;
  String? balance;

  BalanceModel({this.totalDue, this.totalPaid, this.balance});

  BalanceModel.fromJson(Map<String, dynamic> json) {
    totalDue = json['total_due'];
    totalPaid = json['total_paid'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_due'] = this.totalDue;
    data['total_paid'] = this.totalPaid;
    data['balance'] = this.balance;
    return data;
  }
}

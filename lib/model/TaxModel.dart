class TaxModel {
  String? date;
  String? receiptNo;
  String? amount;
  String? tax;

  TaxModel({this.date, this.receiptNo, this.amount, this.tax});

  TaxModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    receiptNo = json['receiptNo'];
    amount = json['amount'];
    tax = json['tax'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['receiptNo'] = this.receiptNo;
    data['amount'] = this.amount;
    data['tax'] = this.tax;
    return data;
  }
}

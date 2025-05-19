class StatementModel {
  String? s;
  String? date;
  String? particular;
  String? dr;
  String? cr;
  String? balance;
  String? remarks;

  StatementModel(
      {this.s,
        this.date,
        this.particular,
        this.dr,
        this.cr,
        this.balance,
        this.remarks});

  StatementModel.fromJson(Map<String, dynamic> json) {
    s = json['s'];
    date = json['date'];
    particular = json['particular'];
    dr = json['dr'];
    cr = json['cr'];
    balance = json['balance'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['s'] = this.s;
    data['date'] = this.date;
    data['particular'] = this.particular;
    data['dr'] = this.dr;
    data['cr'] = this.cr;
    data['balance'] = this.balance;
    data['remarks'] = this.remarks;
    return data;
  }
}

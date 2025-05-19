class CreditNoteModel {
  String? date;
  String? creditNote;
  String? amount;
  String? status;

  CreditNoteModel({this.date, this.creditNote, this.amount, this.status});

  CreditNoteModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    creditNote = json['credit_note'];
    amount = json['amount'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['credit_note'] = this.creditNote;
    data['amount'] = this.amount;
    data['status'] = this.status;
    return data;
  }
}

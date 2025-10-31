class FeeModel {
  List<Dues>? dues;
  List<Currency>? currency;
  List<Receipts>? receipts;
  List<CreditNotes>? creditNotes;
  List<CreditSettlementModel>? creditNotesRefund;

  FeeModel(
      {this.dues,
        this.currency,
        this.receipts,
        this.creditNotes,
        this.creditNotesRefund});

  FeeModel.fromJson(Map<String, dynamic> json) {
    if (json['dues'] != null) {
      dues = <Dues>[];
      json['dues'].forEach((v) {
        dues!.add(new Dues.fromJson(v));
      });
    }
    if (json['currency'] != null) {
      currency = <Currency>[];
      json['currency'].forEach((v) {
        currency!.add(new Currency.fromJson(v));
      });
    }
    if (json['receipts'] != null) {
      receipts = <Receipts>[];
      json['receipts'].forEach((v) {
        receipts!.add(new Receipts.fromJson(v));
      });
    }
    if (json['credit_notes'] != null) {
      creditNotes = <CreditNotes>[];
      json['credit_notes'].forEach((v) {
        creditNotes!.add(new CreditNotes.fromJson(v));
      });
    }
    if (json['credit_notes_refund'] != null) {
      creditNotesRefund = <CreditSettlementModel>[];
      json['credit_notes_refund'].forEach((v) {
        creditNotesRefund!.add(new CreditSettlementModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dues != null) {
      data['dues'] = this.dues!.map((v) => v.toJson()).toList();
    }
    if (this.currency != null) {
      data['currency'] = this.currency!.map((v) => v.toJson()).toList();
    }
    if (this.receipts != null) {
      data['receipts'] = this.receipts!.map((v) => v.toJson()).toList();
    }
    if (this.creditNotes != null) {
      data['credit_notes'] = this.creditNotes!.map((v) => v.toJson()).toList();
    }
    if (this.creditNotesRefund != null) {
      data['credit_notes_refund'] =
          this.creditNotesRefund!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class CreditSettlementModel {
  String? settlementDate;
  String? fiscalYearName;
  String? settleType;
  String? creditNoteNo;
  String? amount;

  CreditSettlementModel(
      {this.settlementDate,
        this.fiscalYearName,
        this.settleType,
        this.creditNoteNo,
        this.amount});

  CreditSettlementModel.fromJson(Map<String, dynamic> json) {
    settlementDate = json['settlement_date'];
    fiscalYearName = json['fiscal_year_name'];
    settleType = json['settle_type'];
    creditNoteNo = json['credit_note_no'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['settlement_date'] = this.settlementDate;
    data['fiscal_year_name'] = this.fiscalYearName;
    data['settle_type'] = this.settleType;
    data['credit_note_no'] = this.creditNoteNo;
    data['amount'] = this.amount;
    return data;
  }
}

class Dues {
  int? debitId;
  String? paymentDate;
  String? particular;
  String? description;
  String? currency;
  String? currencySymbol;
  String? amount;
  String? status;
  String? amountPaid;
  String? remarks;
  String? creditRemarks;

  Dues(
      {this.debitId,
        this.paymentDate,
        this.particular,
        this.description,
        this.currency,
        this.currencySymbol,
        this.amount,
        this.status,
        this.amountPaid,
        this.remarks,
        this.creditRemarks});

  Dues.fromJson(Map<String, dynamic> json) {
    debitId = json['debit_id'];
    paymentDate = json['payment_date'];
    particular = json['particular'];
    description = json['description'];
    currency = json['currency'];
    currencySymbol = json['currency_symbol'];
    amount = json['amount'];
    status = json['status'];
    amountPaid = json['amount_paid'];
    remarks = json['remarks'];
    creditRemarks = json['credit_remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['debit_id'] = this.debitId;
    data['payment_date'] = this.paymentDate;
    data['particular'] = this.particular;
    data['description'] = this.description;
    data['currency'] = this.currency;
    data['currency_symbol'] = this.currencySymbol;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['amount_paid'] = this.amountPaid;
    data['remarks'] = this.remarks;
    data['credit_remarks'] = this.creditRemarks;
    return data;
  }
}

class Currency {
  String? currency;
  String? currencySymbol;

  Currency({this.currency, this.currencySymbol});

  Currency.fromJson(Map<String, dynamic> json) {
    currency = json['currency'];
    currencySymbol = json['currency_symbol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currency'] = this.currency;
    data['currency_symbol'] = this.currencySymbol;
    return data;
  }
}

class Receipts {
  int? receiptId;
  int? receiptNo;
  String? fiscalYearName;
  String? receiptDate;
  String? totalAmount;
  String? taxAmount;
  String? status;

  Receipts(
      {this.receiptId,
        this.receiptNo,
        this.fiscalYearName,
        this.receiptDate,
        this.totalAmount,
        this.taxAmount,
        this.status});

  Receipts.fromJson(Map<String, dynamic> json) {
    receiptId = json['receipt_id'];
    receiptNo = json['receipt_no'];
    fiscalYearName = json['fiscal_year_name'];
    receiptDate = json['receipt_date'];
    totalAmount = json['total_amount'];
    taxAmount = json['tax_amount'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['receipt_id'] = this.receiptId;
    data['receipt_no'] = this.receiptNo;
    data['fiscal_year_name'] = this.fiscalYearName;
    data['receipt_date'] = this.receiptDate;
    data['total_amount'] = this.totalAmount;
    data['tax_amount'] = this.taxAmount;
    data['status'] = this.status;
    return data;
  }
}

class CreditNotes {
  int? creditNoteId;
  int? creditNoteNo;
  String? fiscalYearName;
  String? issueDate;
  String? amount;
  String? status;
  String? particular;
  String? description;

  CreditNotes(
      {this.creditNoteId,
        this.creditNoteNo,
        this.fiscalYearName,
        this.issueDate,
        this.amount,
        this.status,
        this.particular,
        this.description});

  CreditNotes.fromJson(Map<String, dynamic> json) {
    creditNoteId = json['credit_note_id'];
    creditNoteNo = json['credit_note_no'];
    fiscalYearName = json['fiscal_year_name'];
    issueDate = json['issue_date'];
    amount = json['amount'];
    status = json['status'];
    particular = json['particular'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['credit_note_id'] = this.creditNoteId;
    data['credit_note_no'] = this.creditNoteNo;
    data['fiscal_year_name'] = this.fiscalYearName;
    data['issue_date'] = this.issueDate;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['particular'] = this.particular;
    data['description'] = this.description;
    return data;
  }
}

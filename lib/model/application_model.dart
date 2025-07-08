class ApplicationModel {
  int? applicationId;
  String? referenceNo;
  String? applicationDate;
  String? applicationType;
  String? appStartDate;
  String? appEndDate;
  String? applicationRequest;
  String? applicationStatus;

  ApplicationModel(
      {this.applicationId,
        this.referenceNo,
        this.applicationDate,
        this.applicationType,
        this.appStartDate,
        this.appEndDate,
        this.applicationRequest,
        this.applicationStatus});

  ApplicationModel.fromJson(Map<String, dynamic> json) {
    applicationId = json['application_id'];
    referenceNo = json['reference_no'];
    applicationDate = json['application_date'];
    applicationType = json['application_type'];
    appStartDate = json['app_start_date'];
    appEndDate = json['app_end_date'];
    applicationRequest = json['application_request'];
    applicationStatus = json['application_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['application_id'] = this.applicationId;
    data['reference_no'] = this.referenceNo;
    data['application_date'] = this.applicationDate;
    data['application_type'] = this.applicationType;
    data['app_start_date'] = this.appStartDate;
    data['app_end_date'] = this.appEndDate;
    data['application_request'] = this.applicationRequest;
    data['application_status'] = this.applicationStatus;
    return data;
  }
}

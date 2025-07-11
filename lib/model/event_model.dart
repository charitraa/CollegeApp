class EventModel {
  int? eventId;
  String? eventName;
  String? eventType;
  String? summary;
  String? description;
  String? location;
  String? eventFiles;
  String? colorCode;
  String? organizedBy;
  String? organizerName;
  String? organizerMobile;
  String? organizerEmail;
  String? eventContactName;
  String? eventContactMobile;
  String? eventContactEmail;
  String? startDate;
  String? startTime;
  String? endDate;
  String? endTime;
  String? status;

  EventModel(
      {this.eventId,
        this.eventName,
        this.eventType,
        this.summary,
        this.description,
        this.location,
        this.eventFiles,
        this.colorCode,
        this.organizedBy,
        this.organizerName,
        this.organizerMobile,
        this.organizerEmail,
        this.eventContactName,
        this.eventContactMobile,
        this.eventContactEmail,
        this.startDate,
        this.startTime,
        this.endDate,
        this.endTime,
        this.status});

  EventModel.fromJson(Map<String, dynamic> json) {
    eventId = json['event_id'];
    eventName = json['event_name'];
    eventType = json['event_type'];
    summary = json['summary'];
    description = json['description'];
    location = json['location'];
    eventFiles = json['event_files'];
    colorCode = json['color_code'];
    organizedBy = json['organized_by'];
    organizerName = json['organizer_name'];
    organizerMobile = json['organizer_mobile'];
    organizerEmail = json['organizer_email'];
    eventContactName = json['event_contact_name'];
    eventContactMobile = json['event_contact_mobile'];
    eventContactEmail = json['event_contact_email'];
    startDate = json['start_date'];
    startTime = json['start_time'];
    endDate = json['end_date'];
    endTime = json['end_time'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event_id'] = this.eventId;
    data['event_name'] = this.eventName;
    data['event_type'] = this.eventType;
    data['summary'] = this.summary;
    data['description'] = this.description;
    data['location'] = this.location;
    data['event_files'] = this.eventFiles;
    data['color_code'] = this.colorCode;
    data['organized_by'] = this.organizedBy;
    data['organizer_name'] = this.organizerName;
    data['organizer_mobile'] = this.organizerMobile;
    data['organizer_email'] = this.organizerEmail;
    data['event_contact_name'] = this.eventContactName;
    data['event_contact_mobile'] = this.eventContactMobile;
    data['event_contact_email'] = this.eventContactEmail;
    data['start_date'] = this.startDate;
    data['start_time'] = this.startTime;
    data['end_date'] = this.endDate;
    data['end_time'] = this.endTime;
    data['status'] = this.status;
    return data;
  }
}

class DCRDetailModel {
  String? subjectName;
  String? facultyName;
  List<ClassReport>? classReport;
  List<Attendance>? attendance;

  DCRDetailModel(
      {this.subjectName, this.facultyName, this.classReport, this.attendance});

  DCRDetailModel.fromJson(Map<String, dynamic> json) {
    subjectName = json['subject_name'];
    facultyName = json['faculty_name'];
    if (json['class_report'] != null) {
      classReport = <ClassReport>[];
      json['class_report'].forEach((v) {
        classReport!.add(new ClassReport.fromJson(v));
      });
    }
    if (json['attendance'] != null) {
      attendance = <Attendance>[];
      json['attendance'].forEach((v) {
        attendance!.add(new Attendance.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subject_name'] = this.subjectName;
    data['faculty_name'] = this.facultyName;
    if (this.classReport != null) {
      data['class_report'] = this.classReport!.map((v) => v.toJson()).toList();
    }
    if (this.attendance != null) {
      data['attendance'] = this.attendance!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClassReport {
  int? recordId;
  String? classDate;
  String? startTime;
  String? endTime;
  int? period;
  String? classType;
  String? shiftName;
  String? modeName;
  String? sectionId;
  String? blockName;
  int? roomNo;
  String? classStatus;
  String? taughtInClass;
  String? classActivity;
  String? assignment;
  String? facultyName;
  String? attendanceStatus;

  ClassReport(
      {this.recordId,
        this.classDate,
        this.startTime,
        this.endTime,
        this.period,
        this.classType,
        this.shiftName,
        this.modeName,
        this.sectionId,
        this.blockName,
        this.roomNo,
        this.classStatus,
        this.taughtInClass,
        this.classActivity,
        this.assignment,
        this.facultyName,
        this.attendanceStatus});

  ClassReport.fromJson(Map<String, dynamic> json) {
    recordId = json['record_id'];
    classDate = json['class_date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    period = json['period'];
    classType = json['class_type'];
    shiftName = json['shift_name'];
    modeName = json['mode_name'];
    sectionId = json['section_id'];
    blockName = json['block_name'];
    roomNo = json['room_no'];
    classStatus = json['class_status'];
    taughtInClass = json['taught_in_class'];
    classActivity = json['class_activity'];
    assignment = json['assignment'];
    facultyName = json['faculty_name'];
    attendanceStatus = json['attendance_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['record_id'] = this.recordId;
    data['class_date'] = this.classDate;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['period'] = this.period;
    data['class_type'] = this.classType;
    data['shift_name'] = this.shiftName;
    data['mode_name'] = this.modeName;
    data['section_id'] = this.sectionId;
    data['block_name'] = this.blockName;
    data['room_no'] = this.roomNo;
    data['class_status'] = this.classStatus;
    data['taught_in_class'] = this.taughtInClass;
    data['class_activity'] = this.classActivity;
    data['assignment'] = this.assignment;
    data['faculty_name'] = this.facultyName;
    data['attendance_status'] = this.attendanceStatus;
    return data;
  }
}

class Attendance {
  String? sessionCode;
  int? subjectId;
  String? subjectCode;
  String? subjectName;
  String? totalPeriod;
  String? present;
  String? absent;
  String? late;
  String? leave;

  Attendance(
      {this.sessionCode,
        this.subjectId,
        this.subjectCode,
        this.subjectName,
        this.totalPeriod,
        this.present,
        this.absent,
        this.late,
        this.leave});

  Attendance.fromJson(Map<String, dynamic> json) {
    sessionCode = json['session_code'];
    subjectId = json['subject_id'];
    subjectCode = json['subject_code'];
    subjectName = json['subject_name'];
    totalPeriod = json['total_period'];
    present = json['present'];
    absent = json['absent'];
    late = json['late'];
    leave = json['leave'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['session_code'] = this.sessionCode;
    data['subject_id'] = this.subjectId;
    data['subject_code'] = this.subjectCode;
    data['subject_name'] = this.subjectName;
    data['total_period'] = this.totalPeriod;
    data['present'] = this.present;
    data['absent'] = this.absent;
    data['late'] = this.late;
    data['leave'] = this.leave;
    return data;
  }
}

class DCRModel {
  int? subjectId;
  String? sectionId;
  String? subjectName;
  String? subjectCode;
  String? semesterName;
  String? sessionName;
  int? facultyId;
  String? facultyName;

  DCRModel(
      {this.subjectId,
        this.sectionId,
        this.subjectName,
        this.subjectCode,
        this.semesterName,
        this.sessionName,
        this.facultyId,
        this.facultyName});

  DCRModel.fromJson(Map<String, dynamic> json) {
    subjectId = json['subject_id'];
    sectionId = json['section_id'];
    subjectName = json['subject_name'];
    subjectCode = json['subject_code'];
    semesterName = json['semester_name'];
    sessionName = json['session_name'];
    facultyId = json['faculty_id'];
    facultyName = json['faculty_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subject_id'] = this.subjectId;
    data['section_id'] = this.sectionId;
    data['subject_name'] = this.subjectName;
    data['subject_code'] = this.subjectCode;
    data['semester_name'] = this.semesterName;
    data['session_name'] = this.sessionName;
    data['faculty_id'] = this.facultyId;
    data['faculty_name'] = this.facultyName;
    return data;
  }
}

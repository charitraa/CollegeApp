class ProfileModel {
  int? studentId;
  String? stuFirstname;
  String? stuMiddlename;
  String? stuLastname;
  String? stuGender;
  String? studentStatus;
  String? stuRollNo;
  String? stuUnivRollNo;
  String? stuMobile;
  String? stuEmail;
  String? stuProfilePath;
  String? stuPhoto;
  String? stuResCity;
  String? stuResCountry;
  int? collegeregId;
  String? courseName;
  String? courseShortName;
  String? semesterName;
  String? sessionName;
  String? stuFatherName;
  String? stuMotherName;
  String? stuGurName;
  String? stuGurMobile;
  String? stuGurEmail;
  String? stuWifiAccess;
  List<Subjects>? subjects;

  ProfileModel(
      {this.studentId,
        this.stuFirstname,
        this.stuMiddlename,
        this.stuLastname,
        this.stuGender,
        this.studentStatus,
        this.stuRollNo,
        this.stuUnivRollNo,
        this.stuMobile,
        this.stuEmail,
        this.stuProfilePath,
        this.stuPhoto,
        this.stuResCity,
        this.stuResCountry,
        this.collegeregId,
        this.courseName,
        this.courseShortName,
        this.semesterName,
        this.sessionName,
        this.stuFatherName,
        this.stuMotherName,
        this.stuGurName,
        this.stuGurMobile,
        this.stuGurEmail,
        this.stuWifiAccess,
        this.subjects});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    studentId = json['student_id'];
    stuFirstname = json['stu_firstname'];
    stuMiddlename = json['stu_middlename'];
    stuLastname = json['stu_lastname'];
    stuGender = json['stu_gender'];
    studentStatus = json['student_status'];
    stuRollNo = json['stu_roll_no'];
    stuUnivRollNo = json['stu_univ_roll_no'];
    stuMobile = json['stu_mobile'];
    stuEmail = json['stu_email'];
    stuProfilePath = json['stu_profile_path'];
    stuPhoto = json['stu_photo'];
    stuResCity = json['stu_res_city'];
    stuResCountry = json['stu_res_country'];
    collegeregId = json['collegereg_id'];
    courseName = json['course_name'];
    courseShortName = json['course_short_name'];
    semesterName = json['semester_name'];
    sessionName = json['session_name'];
    stuFatherName = json['stu_father_name'];
    stuMotherName = json['stu_mother_name'];
    stuGurName = json['stu_gur_name'];
    stuGurMobile = json['stu_gur_mobile'];
    stuGurEmail = json['stu_gur_email'];
    stuWifiAccess = json['stu_wifi_access'];
    if (json['subjects'] != null) {
      subjects = <Subjects>[];
      json['subjects'].forEach((v) {
        subjects!.add(new Subjects.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['student_id'] = this.studentId;
    data['stu_firstname'] = this.stuFirstname;
    data['stu_middlename'] = this.stuMiddlename;
    data['stu_lastname'] = this.stuLastname;
    data['stu_gender'] = this.stuGender;
    data['student_status'] = this.studentStatus;
    data['stu_roll_no'] = this.stuRollNo;
    data['stu_univ_roll_no'] = this.stuUnivRollNo;
    data['stu_mobile'] = this.stuMobile;
    data['stu_email'] = this.stuEmail;
    data['stu_profile_path'] = this.stuProfilePath;
    data['stu_photo'] = this.stuPhoto;
    data['stu_res_city'] = this.stuResCity;
    data['stu_res_country'] = this.stuResCountry;
    data['collegereg_id'] = this.collegeregId;
    data['course_name'] = this.courseName;
    data['course_short_name'] = this.courseShortName;
    data['semester_name'] = this.semesterName;
    data['session_name'] = this.sessionName;
    data['stu_father_name'] = this.stuFatherName;
    data['stu_mother_name'] = this.stuMotherName;
    data['stu_gur_name'] = this.stuGurName;
    data['stu_gur_mobile'] = this.stuGurMobile;
    data['stu_gur_email'] = this.stuGurEmail;
    data['stu_wifi_access'] = this.stuWifiAccess;
    if (this.subjects != null) {
      data['subjects'] = this.subjects!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subjects {
  int? subjectId;
  String? subjectCode;
  String? subjectName;
  String? subjectShortName;

  Subjects(
      {this.subjectId,
        this.subjectCode,
        this.subjectName,
        this.subjectShortName});

  Subjects.fromJson(Map<String, dynamic> json) {
    subjectId = json['subject_id'];
    subjectCode = json['subject_code'];
    subjectName = json['subject_name'];
    subjectShortName = json['subject_short_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subject_id'] = this.subjectId;
    data['subject_code'] = this.subjectCode;
    data['subject_name'] = this.subjectName;
    data['subject_short_name'] = this.subjectShortName;
    return data;
  }
}

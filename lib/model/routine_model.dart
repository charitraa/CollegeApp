class RoutineModel {
  final String sessionName;
  final String courseName;
  final String semesterName;
  final String blockName;
  final String roomNo;
  final String applicableFrom;
  final List<DayItem> days;
  final List<Times> times;
  final Map<String, dynamic> detail;

  RoutineModel({
    required this.sessionName,
    required this.courseName,
    required this.semesterName,
    required this.blockName,
    required this.roomNo,
    required this.applicableFrom,
    required this.days,
    required this.times,
    required this.detail,
  });

  factory RoutineModel.fromJson(Map<String, dynamic> json) {
    return RoutineModel(
      sessionName: json['session_name'],
      courseName: json['course_name'],
      semesterName: json['semester_name'],
      blockName: json['block_name'],
      roomNo: json['room_no'],
      applicableFrom: json['applicable_from'],
      days: (json['days'] as List)
          .map((e) => DayItem.fromJson(e))
          .toList(),
      times: (json['times'] as List)
          .map((e) => Times.fromJson(e))
          .toList(),
      detail: json['detail'] ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'session_name': sessionName,
      'course_name': courseName,
      'semester_name': semesterName,
      'block_name': blockName,
      'room_no': roomNo,
      'applicable_from': applicableFrom,
      'days': days.map((e) => e.toJson()).toList(),
      'times': times.map((e) => e.toJson()).toList(),
      'detail': detail,
    };
  }
}

class DayItem {
  final String day;

  DayItem({required this.day});

  factory DayItem.fromJson(Map<String, dynamic> json) {
    return DayItem(day: json['day']);
  }

  Map<String, dynamic> toJson() => {'day': day};
}

class Times {
  final String startTime;
  final String endTime;

  Times({required this.startTime, required this.endTime});

  factory Times.fromJson(Map<String, dynamic> json) {
    return Times(
      startTime: json['start_time'],
      endTime: json['end_time'],
    );
  }

  Map<String, dynamic> toJson() => {
    'start_time': startTime,
    'end_time': endTime,
  };
}

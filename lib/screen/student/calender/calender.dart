import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../constant/event.dart';
import '../../../model/event_model.dart';
import '../../../resource/colors.dart';
import 'calender_widget.dart';

class AcademicCalender extends StatefulWidget {
  const AcademicCalender({super.key});

  @override
  State<AcademicCalender> createState() => _AcademicCalenderState();
}

class _AcademicCalenderState extends State<AcademicCalender> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final Map<DateTime, List<Event>> _events = {
    DateTime.utc(2025, 5, 20): [
      Event('Orientation Day', EventType.academic),
    ],
    DateTime.utc(2025, 5, 22): [
      Event('Workshop', EventType.ccv),
      Event('Project Submission', EventType.academic),
    ],
    DateTime.utc(2025, 5, 23): [
      Event('Team Building Event', EventType.ccv),
    ],
    DateTime.utc(2025, 5, 25): [
      Event('Midterm Exam', EventType.academic),
    ],
    DateTime.utc(2025, 5, 27): [
      Event('Guest Lecture: AI in Industry', EventType.academic),
      Event('Hackathon Prep Session', EventType.ccv),
    ],
    DateTime.utc(2025, 5, 30): [
      Event('Coding Competition', EventType.ccv),
      Event('Campus Clean-up Drive', EventType.normal),
    ],
    DateTime.utc(2025, 6, 1): [
      Event('Semester Start', EventType.normal),
    ],
    DateTime.utc(2025, 6, 3): [
      Event('Library Orientation', EventType.normal),
    ],
    DateTime.utc(2025, 6, 5): [
      Event('Math Quiz', EventType.academic),
    ],
    DateTime.utc(2025, 6, 7): [
      Event('Sports Day', EventType.normal),
      Event('Debate Competition', EventType.ccv),
    ],
    DateTime.utc(2025, 6, 10): [
      Event('Group Project Review', EventType.academic),
    ],
    DateTime.utc(2025, 6, 15): [
      Event('Internship Talk', EventType.ccv),
    ],
    DateTime.utc(2025, 6, 20): [
      Event('Final Exam', EventType.academic),
    ],
    DateTime.utc(2025, 6, 25): [
      Event('Results Announcement', EventType.academic),
      Event('Farewell Ceremony', EventType.normal),
    ],
  };

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedDay = DateTime.utc(now.year, now.month, now.day);
  }

  List<Event> _getEventsForDay(DateTime day) {
    return _events[DateTime.utc(day.year, day.month, day.day)] ?? [];
  }

  Color _getColorForEventType(EventType type) {
    switch (type) {
      case EventType.academic:
        return Colors.red;
      case EventType.ccv:
        return Colors.orange;
      case EventType.normal:
        return Colors.blue;
    }
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
  }

  Map<EventType, List<Event>> _groupEventsByType(List<Event> events) {
    final Map<EventType, List<Event>> grouped = {};
    for (var event in events) {
      grouped.putIfAbsent(event.type, () => []).add(event);
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Academic Calendar",
          style: TextStyle(fontFamily: 'poppins', fontSize: 19),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.primary),
          onPressed: () => Navigator.pop(context),
          iconSize: 18,
        ),
        actions: const [
          Image(
            image: AssetImage('assets/images/lbef.png'),
            width: 70,
            height: 50,
            fit: BoxFit.contain,
          ),
          SizedBox(width: 14),
        ],
      ),
      body: Column(
        children: [
          TableCalendar<Event>(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) {
              setState(() => _calendarFormat = format);
            },
            eventLoader: _getEventsForDay,
            calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              markerDecoration: BoxDecoration(),
            ),
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, date, events) {
                if (events.isEmpty) return const SizedBox();
                final firstEvent = events.first;
                return Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: _getColorForEventType(firstEvent.type),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${events.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          if (_selectedDay != null) ...[
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  const Icon(Icons.event, size: 18, color: Colors.black54),
                  const SizedBox(width: 6),
                  Text(
                    "Events on: ${_formatDate(_selectedDay!)}",
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            if (_getEventsForDay(_selectedDay!).isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
                child: Text(
                  "No event on this day.",
                  style: TextStyle(fontSize: 14, color: Colors.black45),
                ),
              )
            else
              ..._groupEventsByType(_getEventsForDay(_selectedDay!)).entries.map((entry) {
                final type = entry.key;
                final events = entry.value;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        child: Text(
                          type.name.toUpperCase(),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: _getColorForEventType(type),
                          ),
                        ),
                      ),
                      ...events.map((event) => CalenderWidget(
                        title: event.title,
                        name: event.type.name.toUpperCase(),
                        date: _formatDate(_selectedDay!),
                        color: _getColorForEventType(event.type),
                      )),
                    ],
                  ),
                );
              }),
          ],
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lbef/screen/student/class_routines/widgets/friday.dart';
import 'package:lbef/screen/student/class_routines/widgets/monday.dart';
import 'package:lbef/screen/student/class_routines/widgets/sunday.dart';
import 'package:lbef/screen/student/class_routines/widgets/thursday.dart';
import 'package:lbef/screen/student/class_routines/widgets/tuesday.dart';
import 'package:lbef/screen/student/class_routines/widgets/wednesday.dart';

import '../../../resource/colors.dart';

class ClassRoutines extends StatefulWidget {
  const ClassRoutines({super.key});

  @override
  State<ClassRoutines> createState() => _ClassRoutinesState();
}

class _ClassRoutinesState extends State<ClassRoutines> {
  int index = 0;

  final ScrollController _scrollController = ScrollController();
  final List<String> days = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
  ];

  final List<GlobalKey> _tabKeys = List.generate(7, (_) => GlobalKey());

  @override
  void initState() {
    super.initState();

    final today = DateTime.now().weekday;
    index = today == 7 ? 0 : today;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCenter(index);
    });
  }

  void _scrollToCenter(int tabIndex) {
    final keyContext = _tabKeys[tabIndex].currentContext;
    if (keyContext == null) return;

    final box = keyContext.findRenderObject() as RenderBox;
    final position = box.localToGlobal(Offset.zero, ancestor: context.findRenderObject());
    final size = box.size;

    final screenWidth = MediaQuery.of(context).size.width;
    final offset = position.dx + size.width / 2 - screenWidth / 2;

    _scrollController.animateTo(
      _scrollController.offset + offset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Class Routines",
          style: TextStyle(fontFamily: 'poppins'),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.primary),
          onPressed: () {
            Navigator.pop(context);
          },
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: List.generate(days.length, (i) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: buildFilterButton(
                      days[i],
                          () {
                        setState(() {
                          index = i;
                        });
                        _scrollToCenter(i);
                      },
                      i,
                      _tabKeys[i],
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 10),
            if (index == 0) Sunday(),
            if (index == 1) Monday(),
            if (index == 2) Tuesday(),
            if (index == 3) Wednesday(),
            if (index == 4) Thursday(),
            if (index == 5) Friday(),

          ],
        ),
      ),
    );
  }

  Widget buildFilterButton(String title, VoidCallback onTap, int tabIndex, Key key) {
    return InkWell(
      key: key,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: index == tabIndex ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: AppColors.primary),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: index == tabIndex ? Colors.white : AppColors.primary,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

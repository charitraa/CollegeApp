import 'package:flutter/material.dart';
import 'package:lbef/resource/colors.dart';
import 'package:lbef/screen/student/class_routines/class_routines.dart';
import 'package:lbef/screen/student/notice/notice.dart';
import 'package:lbef/utils/navigate_to.dart';

import '../../download_forums/download_forums.dart';
import 'dashboard_card.dart';

class DashboardHead extends StatefulWidget {
  final String userName;

  const DashboardHead({super.key, required this.userName});

  @override
  State<DashboardHead> createState() => _DashboardHeadState();
}

class _DashboardHeadState extends State<DashboardHead> {
  late final TextEditingController _controller;
  String searchQuery = '';

  final List<Map<String, dynamic>> allCards = [
    {'text': 'Class Routines', 'icon': Icons.schedule, 'className':const ClassRoutines()},
    {'text': 'Results', 'icon': Icons.grade},
    {'text': 'Notice', 'icon': Icons.notifications,'className':const NoticeBoard()},
    {'text': 'Calendar', 'icon': Icons.calendar_month},
    {'text': 'Breo', 'icon': Icons.web},
    {'text': "Download forms", 'icon': Icons.assignment,'className': DocumentListPage()},
    {'text': 'Evision', 'icon': Icons.laptop},
    {'text': 'E-Library', 'icon': Icons.menu_book},
  ];

  List<Map<String, dynamic>> filteredCards = [];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    filteredCards = List.from(allCards);
  }

  void filterCards(String query) {
    final lowercaseQuery = query.toLowerCase();
    setState(() {
      searchQuery = query;
      if (query.isEmpty) {
        filteredCards = List.from(allCards);
      } else {
        filteredCards = allCards
            .where((card) => (card['text'] as String)
            .toLowerCase()
            .contains(lowercaseQuery))
            .toList();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 345,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 320,
                  // decoration: const BoxDecoration(
                  //   gradient: LinearGradient(
                  //     begin: Alignment.topCenter,
                  //     end: Alignment.bottomCenter,
                  //     colors: [Color(0xFF1967B8), Color(0xFF408EDB)],
                  //   ),
                  // ),
                  child: SizedBox(
                    width: 150,
                    height: 120,
                    child: Image.asset('assets/images/content.png', fit: BoxFit.cover),
                  ),
                ),
              ),
              Positioned(
                top: 30,
                left: 5,
                child: SizedBox(
                  width: 150,
                  height: 120,
                  child: Image.asset('assets/images/lbef.png', fit: BoxFit.cover),
                ),
              ),
              Positioned(
                top: 70,
                right: 24,
                child: InkWell(
                  onTap: () {},
                  child: const Icon(Icons.notifications, size: 32, color: Colors.white),
                ),
              ),
              Positioned(
                bottom: 90,
                left: 24,
                child: Text(
                  'Hi,\n${widget.userName}!!',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),
              Positioned(
                bottom: 90,
                right: 24,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                      image: AssetImage('assets/images/lbef.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 20,
                right: 20,
                child: TextField(
                  controller: _controller,
                  onChanged: filterCards,
                  decoration: InputDecoration(
                    hintText: 'Looking for...',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: searchQuery.isNotEmpty
                        ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _controller.clear();
                            filterCards('');
                          },
                          child: const Icon(Icons.clear, color: Colors.grey),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            filterCards(_controller.text);
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: const Icon(Icons.search, color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 6),
                      ],
                    )
                        : GestureDetector(
                      onTap: () {
                        filterCards(_controller.text);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
                        child: Container(
                          width: 45,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: const Icon(Icons.search, color: Colors.white, size: 26),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: filteredCards.isEmpty
              ? const Text("No results found.")
              : GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 4,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.85,
            children: filteredCards.map((card) {
              return InkWell(
                onTap: () {
                  if (card.containsKey('className')) {
                    Navigator.of(context).push(
                      SlideRightRoute(page: card['className']),
                    );
                  }
                },
                child: DashboardCard(
                  text: card['text']!,
                  icon: card['icon'],
                ),
              );
            }).toList(),

          ),
        ),
      ],
    );
  }
}

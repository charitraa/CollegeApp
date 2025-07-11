import 'package:flutter/material.dart';
import 'package:lbef/constant/base_url.dart';
import 'package:lbef/resource/colors.dart';
import 'package:lbef/screen/student/class_routines/class_routines.dart';
import 'package:lbef/screen/student/notice/notice.dart';
import 'package:lbef/screen/student/notification/notification.dart';
import 'package:lbef/utils/navigate_to.dart';
import 'package:lbef/widgets/custom_shimmer.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../data/status.dart';
import '../../../../view_model/user_view_model/current_user_model.dart';
import '../../../admit_card/admit_card.dart';
import '../../calender/calender.dart';
import '../../download_forums/download_forums.dart';
import 'dashboard_card.dart';

class DashboardHead extends StatefulWidget {
  const DashboardHead({
    super.key,
  });

  @override
  State<DashboardHead> createState() => _DashboardHeadState();
}

class _DashboardHeadState extends State<DashboardHead> {
  late final TextEditingController _controller;
  String searchQuery = '';


  final List<Map<String, dynamic>> allCards = [
    {
      'text': 'Class Routines',
      'icon': Icons.schedule,
      'className': const ClassRoutines()
    },
    {'text': 'Admit Card', 'icon': Icons.badge, 'className': const AdmitCard()},
    {
      'text': 'Notice',
      'icon': Icons.notifications,
      'className': const NoticeBoard()
    },
    {
      'text': 'Calendar',
      'icon': Icons.calendar_month,
      'className': const CalendarScreen()
    },
    {'text': 'Breo', 'icon': Icons.web},
    {
      'text': "Download forms",
      'icon': Icons.assignment,
      'className': DocumentListPage()
    },
    {'text': 'E-vision', 'icon': Icons.laptop},
    {'text': 'Change Password', 'icon': Icons.lock},
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
            .where((card) =>
                (card['text'] as String).toLowerCase().contains(lowercaseQuery))
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
                child: SizedBox(
                  height: 320,
                  child: SizedBox(
                    width: 150,
                    height: 120,
                    child: Image.asset('assets/images/content.png',
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              Positioned(
                top: 30,
                left: 15,
                child: SizedBox(
                  width: 190,
                  height: 120,
                  child: Image.asset('assets/images/lbef.png',
                      fit: BoxFit.contain),
                ),
              ),
              Consumer<UserDataViewModel>(
                builder: (context, userDataViewModel, child) {
                  final user = userDataViewModel.currentUser;
                  if (userDataViewModel.isLoading) {
                    return Positioned(
                      bottom: 90,
                      left: 20,
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          width: 120,
                          height: 50,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  } else if (userDataViewModel.userData.status ==
                      Status.ERROR) {
                    return const Positioned(
                      bottom: 90,
                      left: 24,
                      child: Text(
                        'Hi,\n Unexpected issue!!',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ),
                    );
                  } else if (user == null) {
                    String? getFirstWordsOrShrink(String? input) {
                      if (input == null || input.trim().isEmpty) return input;
                      List<String> words = input.trim().split(RegExp(r'\s+'));
                      if (words.length < 2) return words[0];
                      String twoWords = '${words[0]} ${words[1]}';
                      if (twoWords.length > 30) {
                        return words[0];
                      }
                      return twoWords;
                    }

                    String? name = getFirstWordsOrShrink("Unknown");
                    return Positioned(
                      bottom: 90,
                      left: 20,
                      child: Text(
                        'Hi,\n $name !!',
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ),
                    );
                  } else {
                    String? getFirstWordsOrShrink(String? input) {
                      if (input == null || input.trim().isEmpty) return input;
                      List<String> words = input.trim().split(RegExp(r'\s+'));
                      if (words.length < 2) return words[0];
                      String twoWords = '${words[0]} ${words[1]}';
                      if (twoWords.length > 30) {
                        return words[0];
                      }
                      return twoWords;
                    }

                    String? name = getFirstWordsOrShrink(user.stuFirstname);
                    return Positioned(
                      bottom: 90,
                      left: 24,
                      child: Text(
                        'Hi, $name !!',
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 26),
                      ),
                    );
                  }
                },
              ),
              Positioned(
                top: 70,
                right: 24,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const NotificationScreen(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          const curve = Curves.easeInOut;
                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));
                          var offsetAnimation = animation.drive(tween);
                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: const Icon(Icons.notifications,
                      size: 32, color: Colors.white),
                ),
              ),
              Consumer<UserDataViewModel>(
                builder: (context, userDataViewModel, child) {
                  final user = userDataViewModel.currentUser;

                  String? image =
                      "${BaseUrl.imageDisplay}/html/profiles/students/${user?.stuProfilePath}/${user?.stuPhoto}";
                  var logger=Logger();
                  logger.d(image);
                  return Positioned(
                    bottom: 90,
                    right: 24,
                    child: SizedBox(
                      height: 70,
                      child: Image.network(
                        image,
                        width: 70,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CustomShimmerLoading(
                              width: 120.0,
                              height: 122,
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 70,
                          height: 70,
                          color: Colors.white,
                          child: Center(
                            child: Icon(
                              Icons.school,
                              color: AppColors.primary,
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
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
                                child:
                                    const Icon(Icons.clear, color: Colors.grey),
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
                                  child: const Icon(Icons.search,
                                      color: Colors.white),
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 2),
                              child: Container(
                                width: 45,
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: const Icon(Icons.search,
                                    color: Colors.white, size: 26),
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

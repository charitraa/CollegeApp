import 'package:flutter/material.dart';
import 'package:lbef/resource/colors.dart';
import 'package:lbef/screen/student/profile/profile_shimmer.dart';
import 'package:provider/provider.dart';

import '../../../constant/base_url.dart';
import '../../../view_model/user_view_model/current_user_model.dart';

class ViewProfilePage extends StatefulWidget {
  const ViewProfilePage({super.key});

  @override
  State<ViewProfilePage> createState() => _ViewProfilePageState();
}

class _ViewProfilePageState extends State<ViewProfilePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Account',
          style: TextStyle(fontFamily: 'poppins'),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Image(
              image: AssetImage('assets/images/lbef.png'),
              width: 70,
              height: 50,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<UserDataViewModel>(
          builder: (context, userDataViewModel, child) {
            final user = userDataViewModel.currentUser;

            if (user == null) {
              return const ViewProfileShimmer();
            }
            if (user == null ||
                (user.stuFirstname == null &&
                    user.stuLastname == null &&
                    user.stuEmail == null)) {
              return const Center(
                child: Text(
                  'No information available',
                  style: TextStyle(fontSize: 16),
                ),
              );
            }

            String? image =
                "${BaseUrl.imageDisplay}/html/profiles/students/${user.stuProfilePath}/${user.stuPhoto}";

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 120,
                        width: 120,
                        child: ClipOval(
                          child: Image.network(
                            image,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: Container(
                                  width: 120.0,
                                  height: 120.0,
                                  color: Colors.grey[300],
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                                  width: 120,
                                  height: 120,
                                  color: AppColors.primary,
                                  child: const Center(
                                    child: Icon(
                                      Icons.school,
                                      color: Colors.white,
                                      size: 50,
                                    ),
                                  ),
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              Text(
                                '${user.stuFirstname ?? ''} ${user.stuLastname ?? ''}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                '${user.courseShortName} ${user.semesterName ?? ''}',
                                style: const TextStyle(
                                    fontSize: 18),
                              ),
                              Text(
                                user.stuRollNo ?? '',
                                style: const TextStyle(
                                fontSize: 18),

                              ),

                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'PERSONAL INFORMATION',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),
                _buildInfoRow(Icons.person, 'Full Name:', '${user.stuFirstname ?? ''} ${user.stuMiddlename ?? ''} ${user.stuLastname ?? ''}'),
                _buildInfoRow(Icons.male, 'Gender:', user.stuGender ?? ''),
                _buildInfoRow(Icons.phone, 'Mobile:', user.stuMobile ?? ''),
                _buildInfoRow(Icons.email, 'Email:', user.stuEmail ?? ''),
                _buildInfoRow(Icons.location_city, 'City:', user.stuResCity ?? ''),
                _buildInfoRow(Icons.location_on, 'Country:', user.stuResCountry ?? ''),
                _buildInfoRow(Icons.tag, 'Status:', user.studentStatus ?? ''),
                const SizedBox(height: 20),
                const Text(
                  'GUARDIAN INFORMATION',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                _buildInfoRow(Icons.person, 'Father Name:', user.stuFatherName ?? ''),
                _buildInfoRow(Icons.person, 'Mother Name:', user.stuMotherName ?? ''),
                _buildInfoRow(Icons.person, 'Guardian Name:', user.stuGurName ?? ''),
                _buildInfoRow(Icons.phone, 'Guardian Mobile:', user.stuGurMobile ?? ''),
                _buildInfoRow(Icons.email, 'Guardian Email:', user.stuGurEmail ?? ''),
                const SizedBox(height: 20),
                const Text(
                  'ACADEMIC INFORMATION',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                _buildInfoRow(Icons.school, 'Course:', user.courseName ?? ''),
                _buildInfoRow(Icons.badge, 'College ID:', user.stuRollNo?.toString() ?? ''),
                _buildInfoRow(Icons.calendar_today, 'Session:', user.sessionName ?? ''),
                _buildInfoRow(Icons.confirmation_number, 'Univ Roll No:', user.stuUnivRollNo ?? ''),
                _buildInfoRow(Icons.book, 'Semester:', user.semesterName ?? ''),
                _buildInfoRow(Icons.wifi, 'Wi-Fi Access:', user.stuWifiAccess ?? 'Not provided'),
                const SizedBox(height: 20),
                const Text(
                  'SUBJECTS',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                ...user.subjects?.map((subject) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    '⦿ ${subject.subjectName} (${subject.subjectCode})',
                    style: const TextStyle(fontSize: 14),
                  ),
                )) ?? [const Text('No subjects available')],
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: AppColors.primary),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '$label ',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: value,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
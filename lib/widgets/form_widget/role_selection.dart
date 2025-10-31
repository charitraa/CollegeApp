import 'package:flutter/material.dart';

enum UserRole { student, teacher }

class RoleSelectionWidget extends StatefulWidget {
  @override
  _RoleSelectionWidgetState createState() => _RoleSelectionWidgetState();
}

class _RoleSelectionWidgetState extends State<RoleSelectionWidget> {
  UserRole _selectedRole = UserRole.student;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Student Option
        Row(
          children: [
            Radio<UserRole>(
              value: UserRole.student,
              groupValue: _selectedRole,
              activeColor: Colors.blue,
              onChanged: (UserRole? value) {
                setState(() {
                  _selectedRole = value!;
                });
              },
            ),
            Text(
              'Student',
              style: TextStyle(
                color: _selectedRole == UserRole.student
                    ? Colors.blue
                    : Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
const SizedBox(width: 20,),
        // Dotted Vertical Divider
        // Container(
        //   margin: const EdgeInsets.symmetric(horizontal: 16),
        //   height: 40,
        //   width: 1,
        //   child: LayoutBuilder(
        //     builder: (context, constraints) {
        //       return Column(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: List.generate(
        //           (constraints.maxHeight / 4).floor(),
        //               (index) => Container(
        //             height: 2,
        //             width: 1,
        //             color: Colors.blue,
        //           ),
        //         ),
        //       );
        //     },
        //   ),
        // ),

        // Teacher Option
        Row(
          children: [
            Radio<UserRole>(
              value: UserRole.teacher,
              groupValue: _selectedRole,
              activeColor: Colors.blue,
              onChanged: (UserRole? value) {
                setState(() {
                  _selectedRole = value!;
                });
              },
            ),
            Text(
              'Teacher',
              style: TextStyle(
                color: _selectedRole == UserRole.teacher
                    ? Colors.blue
                    : Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

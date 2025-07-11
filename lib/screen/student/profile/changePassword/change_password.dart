import 'package:flutter/material.dart';
import 'package:lbef/resource/colors.dart';
import 'package:lbef/widgets/form_widget/custom_button.dart';
import 'package:lbef/widgets/form_widget/custom_label_password.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Change Password",
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
            image: AssetImage('assets/images/pcpsLogo.png'),
            width: 56,
            height: 50,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 14),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Add your password change form here
              PasswordTextfield(
                text: 'Current Password',
                hintText: 'Enter your current password',
                outlinedColor: AppColors.primary,
                focusedColor: AppColors.primary,
                width: double.infinity,
                obscureText: true,
                textController: TextEditingController(),
                keyboardType: TextInputType.visiblePassword,
                onChanged: (value) {},
              ),
              const SizedBox(height: 5),

              PasswordTextfield(
                text: 'New Password',
                hintText: 'Enter your new password',
                outlinedColor: AppColors.primary,
                focusedColor: AppColors.primary,
                width: double.infinity,
                obscureText: true,
                textController: TextEditingController(),
                keyboardType: TextInputType.visiblePassword,
                onChanged: (value) {},
              ),
              const SizedBox(height: 5),

              PasswordTextfield(
                text: 'Confirm New Password',
                hintText: 'Re-enter your new password',
                outlinedColor: AppColors.primary,
                focusedColor: AppColors.primary,
                width: double.infinity,
                obscureText: true,
                textController: TextEditingController(),
                keyboardType: TextInputType.visiblePassword,
                onChanged: (value) {},
              ),

              const SizedBox(height: 20),

              CustomButton(
                text: 'Change Password',
                onPressed: () {
                  // Handle password change logic here
                },
                buttonColor: AppColors.primary,
                isLoading: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

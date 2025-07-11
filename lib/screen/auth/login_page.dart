import 'package:flutter/material.dart';
import 'package:lbef/widgets/form_widget/role_selection.dart';
import 'package:provider/provider.dart';
import '../../resource/colors.dart';
import '../../utils/utils.dart';
import '../../view_model/user_view_model/auth_view_model.dart';
import '../../widgets/form_widget/custom_button.dart';
import '../../widgets/form_widget/custom_label_password.dart';
import '../../widgets/form_widget/custom_label_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _studentIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isLoading = false;
  bool _isSubmitted = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _studentIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: size.width,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 30),
                Container(
                  child: const Image(
                    image: AssetImage('assets/images/pcpsLogo.png'),
                    fit: BoxFit.contain,
                    width: 280,
                    height: 180,
                  ),
                ),
                const SizedBox(height: 18),
                if (isLoading) const LinearProgressIndicator(),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sign in",
                            style: TextStyle(
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Hi there! Nice to see you again.",
                            style: TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 13,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                RoleSelectionWidget(),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomLabelTextfield(
                              textController: _studentIdController,
                              hintText: "Student Id",
                              outlinedColor: Colors.grey,
                              focusedColor: AppColors.primary,
                              width: size.width,
                              helperStyle: const TextStyle(
                                color: Colors.red,
                                fontFamily: 'poppins',
                                fontStyle: FontStyle.italic,
                              ),
                              text: "Student Id",
                            ),
                            const SizedBox(height: 14),
                            PasswordTextfield(
                              textController: _passwordController,
                              hintText: "Password",
                              obscureText: true,
                              outlinedColor: Colors.grey,
                              focusedColor: AppColors.primary,
                              width: size.width,
                              helperStyle: const TextStyle(
                                color: Colors.red,
                                fontFamily: 'poppins',
                                fontStyle: FontStyle.italic,
                              ),
                              text: "Password",
                            ),
                            const SizedBox(height: 18),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: 'poppins',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 26),
                            CustomButton(
                                isLoading: isLoading,
                                text: "Sign in",
                                onPressed: () async {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  if (_studentIdController.text.isEmpty) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    return Utils.flushBarErrorMessage(
                                        "Student Id is required.", context);
                                  }
                                  if (_passwordController.text.isEmpty) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    return Utils.flushBarErrorMessage(
                                        "Password is required.", context);
                                  }

                                  await Provider.of<AuthViewModel>(context,
                                          listen: false)
                                      .login({
                                    "username": _studentIdController.text,
                                    "password": _passwordController.text
                                  }, context);
                                  setState(() {
                                    isLoading = false;
                                  });
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../resource/colors.dart';
import '../../utils/utils.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isLoading = false;
  bool _isSubmitted = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
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
                const SizedBox(height: 10),
                Container(
                  child: const Image(
                    image: AssetImage('assets/images/card_bg.png'),
                    fit: BoxFit.contain,
                    width: 140,
                    height: 140,
                  ),
                ),
                const SizedBox(height: 18),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CustomTitle(
                              title: "Sign in",
                              subTitle: "Sign in to your account",
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomLabelTextfield(
                              textController: _emailController,
                              hintText: "Email",
                              outlinedColor: Colors.grey,
                              focusedColor: AppColors.primary,
                              width: size.width,
                              helper: _isSubmitted
                                  ? Validators.validateEmail(
                                  _emailController.text)
                                  : null,
                              helperStyle: const TextStyle(
                                color: Colors.red,
                                fontFamily: 'poppins',
                                fontStyle: FontStyle.italic,
                              ),
                              text: "Email",
                            ),
                            const SizedBox(height: 14),
                            PasswordTextfield(
                              textController: _passwordController,
                              hintText: "Password",
                              obscureText: true,
                              outlinedColor: Colors.grey,
                              focusedColor: AppColors.primary,
                              width: size.width,
                              helper: _isSubmitted
                                  ? Validators.validatePassword(
                                  _passwordController.text)
                                  : null,
                              helperStyle: const TextStyle(
                                color: Colors.red,
                                fontFamily: 'poppins',
                                fontStyle: FontStyle.italic,
                              ),
                              text: "Password",
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        const ForgetPassword(),
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          const begin = Offset(1.0, 0.0);
                                          const end = Offset.zero;
                                          const curve = Curves.easeInOut;
                                          var tween = Tween(
                                              begin: begin, end: end)
                                              .chain(CurveTween(curve: curve));
                                          return SlideTransition(
                                              position: animation.drive(tween),
                                              child: child);
                                        },
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Forget Password?",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'poppins',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            CustomButton(
                                isLoading: isLoading,
                                text: "Login",
                                onPressed: () async {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  if (_emailController.text.isEmpty) {
                                    return Utils.flushBarErrorMessage(
                                        "Email Address is required.", context);
                                  }
                                  if (_passwordController.text.isEmpty) {
                                    return Utils.flushBarErrorMessage(
                                        "Password is required.", context);
                                  }

                                  await Provider.of<AuthViewModel>(context,
                                      listen: false)
                                      .login({
                                    "email": _emailController.text,
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
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "or",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomOutlined(
                      onPressed: () {},
                      icon: const Icon(Icons.facebook),
                      text: 'Google',
                    ),
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.only(bottom: 25, top: 13),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "New To Platform?",
                              style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'poppins',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(width: 5),
                            GestureDetector(
                              onTap: () {
                                // Navigator.pushNamed(context, '/home');
                              },
                              child: const Text(
                                "Register Now",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomOutlined(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const VendorRegistration(),
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        const begin = Offset(1.0, 0.0);
                                        const end = Offset.zero;
                                        const curve = Curves.easeInOut;
                                        var tween = Tween(
                                            begin: begin, end: end)
                                            .chain(CurveTween(curve: curve));
                                        return SlideTransition(
                                            position: animation.drive(tween),
                                            child: child);
                                      },
                                    ),
                                  );
                                },
                                icon: Icon(Icons.shopping_bag_outlined),
                                text: 'Vendor'),
                            const SizedBox(
                              width: 10,
                            ),
                            CustomOutlined(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const CustomerRegistration(),
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        const begin = Offset(1.0, 0.0);
                                        const end = Offset.zero;
                                        const curve = Curves.easeInOut;
                                        var tween = Tween(
                                            begin: begin, end: end)
                                            .chain(CurveTween(curve: curve));
                                        return SlideTransition(
                                            position: animation.drive(tween),
                                            child: child);
                                      },
                                    ),
                                  );
                                },
                                icon: Icon(Icons.person),
                                text: 'User')
                          ],
                        )
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

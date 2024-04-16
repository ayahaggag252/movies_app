
import 'package:flutter/material.dart';
import 'package:movies_app/components/rounded_elevated_button_big.dart';


import '../pages/home_page.dart';
import 'custom_text_field.dart';

class SignupTab extends StatefulWidget {
  const SignupTab({
    Key? key,
  }) : super(key: key);

  @override
  State<SignupTab> createState() => _SignupTabState();
}

class _SignupTabState extends State<SignupTab> {
  //final FirebaseAuthService _auth = FirebaseAuthService();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? errorMsg;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 24.0,
              ),
              CustomTextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                hint: "Email Address",
                hintColor: Colors.grey,
                suffixWidget: const Icon(Icons.email_rounded),
                onValidate: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "you Must Enter Your email";
                  }
                  var regex = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                  if (!regex.hasMatch(value)) {
                    return "invalid Email Address";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 12.0,
              ),
              CustomTextField(
                controller: passwordController,
                keyboardType: TextInputType.emailAddress,
                hint: "Password",
                hintColor: Colors.grey,
                isPassword: true,
                maxLines: 1,
                onValidate: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "you Must Enter Your Password";
                  }
                  var regex = RegExp(
                      r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$");

                  if (!regex.hasMatch(value)) {
                    return "The password must include at least \n* one lowercase letter, \n* one uppercase letter, \n* one digit, \n* one special character,\n* at least 6 characters long.";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 12.0,
              ),
              CustomTextField(
                controller: confirmPasswordController,
                keyboardType: TextInputType.emailAddress,
                hint: "Confirm Password",
                hintColor: Colors.grey,
                isPassword: true,
                maxLines: 1,
                onValidate: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "you Must Enter Your Password";
                  }
                  if (value != passwordController.text) {
                    return "password Not Matching";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 12.0,
              ),
              errorMsg != null && errorMsg!.isNotEmpty
                  ? Center(
                child: Text(
                  errorMsg ?? '',
                  style: const TextStyle(color: Colors.red),
                ),
              )
                  : Container(),
              errorMsg != null && errorMsg!.isNotEmpty
                  ? const SizedBox(
                height: 24.0,
              )
                  : Container(),
              Center(
                child: RoundedElevatedButtonBig(
                  title: 'Sign up',
                  color: const Color(0xFFFFBB3B),
                  onPressed: () async {
                    setState(
                          () {
                        errorMsg = '';
                      },
                    );
                    if (formKey.currentState != null &&
                        formKey.currentState!.validate()) {
                      bool passwordsMatch = passwordController.text ==
                          confirmPasswordController.text;
  /*                    if (passwordsMatch) {
                        try {
                          final newUser =
                          await _auth.createUserWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text);
                          if (newUser != null) {
                            if (!mounted) return;
                            emailController.text = '';
                            passwordController.text = '';
                            confirmPasswordController.text = '';
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation1, animation2) =>
                                const HomePage(),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                            );
                          }
                        } on FirebaseAuthException catch (e) {
                          setState(
                                () {
                              errorMsg = e.message;
                            },
                          );
                        }*/
                      } else {
                        setState(
                              () {
                            errorMsg = 'Passwords do not match';
                          },
                        );
                      }
                    }

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

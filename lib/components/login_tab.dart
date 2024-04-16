//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/components/rounded_elevated_button_big.dart';

//import '../../watchlist/services/firebase_auth_service.dart';
import '../pages/home_page.dart';
import 'custom_text_field.dart';

class LoginTab extends StatefulWidget {
  final Function onForgotPasswordPressed;
  const LoginTab({Key? key, required this.onForgotPasswordPressed})
      : super(key: key);

  @override
  State<LoginTab> createState() => _LoginTabState();
}

class _LoginTabState extends State<LoginTab> {
  //final FirebaseAuthService _auth = FirebaseAuthService();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? errorMsg;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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

              //email
              CustomTextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                hint: "Email",
                hintColor: Colors.grey,
                suffixWidget: const Icon(Icons.email_rounded),
                onValidate: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "you Must Enter Your Email Address";
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      widget.onForgotPasswordPressed();
                    },
                    child: const Text(
                      'Forgot password',
                      style: TextStyle(
                        color: Color(0xFFFFBB3B),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24.0,
              ),
              Column(
                children: [
                  Center(
                    child: RoundedElevatedButtonBig(
                      title: 'Login',
                      color:  Color(0xFFFFBB3B),
                      onPressed: () async {
                        if (formKey.currentState != null &&
                            formKey.currentState!.validate()) {
                          /*try {
                            final user = await _auth.signInWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text);
                            if (user != null) {
                              if (!mounted) return;
                              emailController.text = '';
                              passwordController.text = '';
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
    //                      } on FirebaseAuthException catch (e) {
                            setState(
                                  () {
      //                          errorMsg = e.message;
                              },
                            );
                          }*/
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () async {
                        /*try {
                          final user = await _auth.signInAnonymously();
                          if (user != null) {
                            if (!mounted) return;
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation1, animation2) =>
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
                      },
                      child: const Text(
                        'Login anonymously',
                        style: TextStyle(
                            color: Color(0xFFFFBB3B),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

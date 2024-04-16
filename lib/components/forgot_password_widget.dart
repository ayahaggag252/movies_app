//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/components/rounded_elevated_button_big.dart';

import 'custom_text_field.dart';


//import '../../watchlist/services/firebase_auth_service.dart';

class ForgotPassword extends StatefulWidget {
  final Function onBackPressed;

  const ForgotPassword({Key? key, required this.onBackPressed})
      : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
 // final FirebaseAuthService _auth = FirebaseAuthService();
  late TextEditingController emailController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? errorMsg;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(36.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Reset password',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                ),
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 36),
              child: RichText(
                text: const TextSpan(
                  text: 'Enter your email',
                  style: TextStyle(
                    color: Color(0xFF696969),
                    fontSize: 20.0,
                  ),
                  children: [
                    TextSpan(
                      text: ' reset ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    TextSpan(
                      text: 'your password!',
                      style: TextStyle(
                        color: Color(0xFF696969),
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
              height: 24.0,
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
                title: 'Reset',
                color: const Color(0xFF121312),
               onPressed: () {} /*async {
         if (formKey.currentState != null &&
                      formKey.currentState!.validate()) {
                    try {
                      await _auth.sendPasswordResetEmail(
                          email: emailController.text);
                    } on FirebaseAuthException catch (e) {
                      setState(
                            () {
                          errorMsg = e.message;
                        },
                      )
                    }
                  }
                }*/
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  widget.onBackPressed();
                },
                child: const Text(
                  'Back to login',
                  style: TextStyle(
                    color: Color(0xFFFFBB3B),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

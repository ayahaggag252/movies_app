import 'package:flutter/material.dart';

import '../components/centered_container.dart';
import '../components/custom_tabbar.dart';
import '../components/forgot_password_widget.dart';
import '../components/login_tab.dart';
import '../components/signup_tab.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final List<Widget> tabItems = [
    const Tab(text: "Login"),
    const Tab(text: "Sign up")
  ];

  bool showForgotPassword = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/movies.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: showForgotPassword
              ? CenteredContainer(
            child: ForgotPassword(
              onBackPressed: () {
                setState(
                      () {
                    showForgotPassword = false;
                  },
                );
              },
            ),
          )
              : DefaultTabController(
            length: tabItems.length,
            child: CenteredContainer(
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Column(
                  children: [
                    CustomTabBar(tabItems: tabItems),
                    Flexible(
                      child: TabBarView(
                        children: [
                          LoginTab(
                            onForgotPasswordPressed: () {
                              setState(
                                    () {
                                  showForgotPassword = true;
                                },
                              );
                            },
                          ),
                          const SignupTab(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:amazone_clone/common/widgets/signup_button.dart';
import 'package:amazone_clone/common/widgets/bottom_bar.dart';
import 'package:amazone_clone/constants/utils.dart';
import 'package:amazone_clone/providers/user.dart';
import 'package:amazone_clone/common/widgets/custom_textfield.dart';
import 'package:amazone_clone/constants/global_variables.dart';

enum Auth {
  signin,
  signup,
}

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth-screen';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signupFormKey = GlobalKey<FormState>();
  final _signupInFormKey = GlobalKey<FormState>();

  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  final TextEditingController _nameCtrl = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _nameCtrl.dispose();
  }

  void _signupUser() async {
    try {
      await Provider.of<UserProvider>(context, listen: false).singupUser(
        email: _emailCtrl.text,
        password: _passwordCtrl.text,
        name: _nameCtrl.text,
      );
      if (!mounted) return;
      showSnackBar(context, 'Account created successfully');
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> _signinUser() async {
    try {
      await Provider.of<UserProvider>(context, listen: false).singinUser(
        email: _emailCtrl.text,
        password: _passwordCtrl.text,
      );
      if (!mounted) return;
      showSnackBar(context, 'Logged in successfully');
      Navigator.of(context).pushReplacementNamed(BottomBar.routeName);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                ListTile(
                  tileColor: _auth == Auth.signup
                      ? GlobalVariables.backgroundColor
                      : GlobalVariables.greyBackgroundColor,
                  title: const Text('Create Account'),
                  leading: Radio(
                    activeColor: GlobalVariables.secondaryColor,
                    value: Auth.signup,
                    groupValue: _auth,
                    onChanged: (Auth? value) {
                      setState(() {
                        _auth = value!;
                      });
                    },
                  ),
                  onTap: () {
                    setState(() {
                      _auth = Auth.signup;
                    });
                  },
                ),
                if (_auth == Auth.signup)
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: GlobalVariables.backgroundColor,
                    child: Form(
                      key: _signupFormKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            textController: _nameCtrl,
                            hintText: 'Name',
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            textController: _emailCtrl,
                            hintText: 'Email',
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            textController: _passwordCtrl,
                            hintText: 'Password',
                            obscureText: true,
                          ),
                          const SizedBox(height: 10),
                          CustomButton(
                            btnText: 'Sign Up',
                            onTap: () {
                              if (!_signupFormKey.currentState!.validate()) {
                                return;
                              }
                              _signupUser();
                              // FocusScope.of(context).unfocus();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ListTile(
                  tileColor: _auth == Auth.signin
                      ? GlobalVariables.backgroundColor
                      : GlobalVariables.greyBackgroundColor,
                  title: const Text('Signin'),
                  leading: Radio(
                    activeColor: GlobalVariables.secondaryColor,
                    value: Auth.signin,
                    groupValue: _auth,
                    onChanged: (Auth? value) {
                      setState(() {
                        _auth = value!;
                      });
                    },
                  ),
                  onTap: () {
                    setState(() {
                      _auth = Auth.signin;
                    });
                  },
                ),
                if (_auth == Auth.signin)
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: GlobalVariables.backgroundColor,
                    child: Form(
                      key: _signupInFormKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            textController: _emailCtrl,
                            hintText: 'Email',
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            textController: _passwordCtrl,
                            hintText: 'Password',
                            obscureText: true,
                          ),
                          const SizedBox(height: 10),
                          CustomButton(
                            btnText: 'Sign In',
                            onTap: () {
                              if (!_signupInFormKey.currentState!.validate()) {
                                return;
                              }
                              _signinUser();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

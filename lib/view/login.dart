import 'package:ambulance_dashboard/Controller/authentication_base.dart';
import 'package:ambulance_dashboard/components/gradientButton.dart';
import 'package:ambulance_dashboard/utilities/constant/widgets.dart';
import 'package:ambulance_dashboard/utilities/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

import '../Controller/authentication_functions.dart';
import '../utilities/InfoDisp/message.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // final ValueNotifier<bool> _obsecureText = ValueNotifier(true);
  bool _obsecureText = true;
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();

  final FocusNode _passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 51, 231, 255),
                Colors.blue,
                Color.fromARGB(255, 51, 231, 255)
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  // Color.fromARGB(255, 51, 231, 255),
                  Colors.blue,
                  Color.fromARGB(255, 182, 247, 255),
                  Colors.blue,
                ],
              ),
            ),
          ),
          Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Container(
              height: _height,
              width: _width * .3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                // color: Colors.amber,
                gradient: const LinearGradient(
                    colors: [Colors.blue, Color.fromARGB(255, 126, 234, 248)]),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Card(
                  color: Color.fromARGB(203, 255, 255, 255),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // decorating email text field
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            focusNode: _emailFocusNode,
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text("Email"),
                              prefixIcon: Icon(Icons.email_rounded),
                            ),
                            onFieldSubmitted: (value) => FocusScope.of(context)
                                .requestFocus(_passwordFocusNode),
                          ),
                        ),
                        // listening to value for obsecure text
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            focusNode: _passwordFocusNode,
                            controller: _passwordController,
                            obscureText: _obsecureText,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              label: const Text("Password"),
                              prefixIcon: const Icon(
                                Icons.lock_rounded,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(_obsecureText
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined),
                                onPressed: () {
                                  setState(() {
                                    _obsecureText = !_obsecureText;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        // forgot password section
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text("Forgot Password?"),
                              TextButton(
                                  onPressed: () {
                                    // unfocusing the pointer
                                    FocusManager.instance.primaryFocus!
                                        .unfocus();

                                    // checking for valid email formating
                                    if (_emailController.text.isEmpty ||
                                        isEmail(_emailController.text)) {
                                      try {
                                        // reset mail
                                        AuthenticationBase auth =
                                            Authentication();
                                        auth.passwordReset(context,
                                            _emailController.text.trim());

                                        // Message.flutterToast(
                                        //     context, "Please Check your Mail box");
                                      } catch (e) {
                                        // show exception message
                                        Message.flutterToast(
                                            context, e.toString());
                                      }
                                    } else {
                                      // if email is empty or in invalid format display this message
                                      Message.flutterToast(context,
                                          'Enter valid Email to reset Password');
                                    }
                                  },
                                  child: const Text('Reset Password'))
                            ],
                          ),
                        ),
                        addVerticalSpace(60),

                        MyGradientButton(
                          onPress: () {
                            if (_emailController.text.isEmpty ||
                                !isEmail(_emailController.text)) {
                              Message.flutterToast(
                                  context, "Enter a valid Email address");

                              // checking for valid password
                            } else if (_passwordController.text.length < 6) {
                              Message.flutterToast(context,
                                  "Password must be at least 6 digits");
                            } else {
                              // sign in using email and password
                              // requesting to method of auth class
                              AuthenticationBase auth = Authentication();

                              final authentication = auth
                                  .signInWithEmailAndPassword(
                                      context,
                                      _emailController.text.trim(),
                                      _passwordController.text.trim())
                                  .then((value) {
                                final id = Authentication().currentUser?.uid;
                                if (id != null) {
                                  Navigator.pushReplacementNamed(
                                      context, RouteNames.delegator);
                                }
                              });
                            }
                          },
                          text: 'Login',
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }
}

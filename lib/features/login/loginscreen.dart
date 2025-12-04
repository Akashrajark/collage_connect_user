// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/common_widget/custom_button.dart';
// import 'package:flutter_application_1/common_widget/custom_text_formfield.dart';
// import 'package:flutter_application_1/features/home/home_screen.dart';
// import 'package:flutter_application_1/util/value_validator.dart';

// class Loginscreen extends StatefulWidget {
//   const Loginscreen({super.key});

//   @override
//   State<Loginscreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<Loginscreen> {
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();

//   bool isObscure = true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.purple,
//         body: Container(
//             margin: const EdgeInsets.only(
//                 top: 60, bottom: 60, left: 260, right: 200),
//             padding: const EdgeInsets.symmetric(horizontal: 100),
//             decoration: BoxDecoration(
//                 color: const Color.fromARGB(255, 199, 50, 225),
//                 borderRadius: BorderRadius.circular(20)),
//             child: Row(children: [
//               const Expanded(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Collage Connect',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                         fontSize: 50.0,
//                       ),
//                       textAlign: TextAlign.left,
//                     ),
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 80),
//                       child: Divider(),
//                     ),
//                     SizedBox(
//                       height: 15,
//                     ),
//                     Text(
//                       'Welcome',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                         fontSize: 40.0,
//                       ),
//                       textAlign: TextAlign.left,
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Text(
//                       '''Welcome to College Connect! Sign in to stay connected with your campus, network with peers, and access exclusive student resources. Let's make the most of your college journey together!''',
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 16.0,
//                           fontWeight: FontWeight.normal),
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(
//                       height: 30,
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: Center(
//                   child: Container(
//                     margin: const EdgeInsets.only(
//                         top: 10, bottom: 10, left: 60, right: 10),
//                     width: 400,
//                     height: 400,
//                     decoration: BoxDecoration(
//                         color: Colors.purple[500],
//                         borderRadius: BorderRadius.circular(20)),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 30, vertical: 20),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             'Sign in',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                               fontSize: 50.0,
//                             ),
//                             textAlign: TextAlign.left,
//                           ),
//                           const Text(
//                             'username',
//                             style: TextStyle(
//                               fontWeight: FontWeight.normal,
//                               color: Colors.white,
//                               fontSize: 16.0,
//                             ),
//                             textAlign: TextAlign.left,
//                           ),
//                           const SizedBox(
//                             height: 8,
//                           ),
//                           CustomTextFormField(
//                               labelText: 'Enter email',
//                               controller: _emailController,
//                               validator: emailValidator,
//                               isLoading: false),
//                           const SizedBox(
//                             height: 20,
//                           ),
//                           const Text(
//                             'password',
//                             style: TextStyle(
//                               fontWeight: FontWeight.normal,
//                               color: Colors.white,
//                               fontSize: 16.0,
//                             ),
//                             textAlign: TextAlign.left,
//                           ),
//                           const SizedBox(
//                             height: 8,
//                           ),
//                           const SizedBox(
//                             width: 200,
//                           ),
//                           CustomTextFormField(
//                               labelText: 'Enter password',
//                               controller: _passwordController,
//                               validator: notEmptyValidator,
//                               isLoading: false),
//                           const SizedBox(
//                             height: 30,
//                           ),
//                           CustomButton(
//                             color: Colors.white,
//                             onPressed: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) =>
//                                           const HomeScreen()));
//                             },
//                             label: 'Login',
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ])));
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../common_widgets.dart/custom_alert_dialog.dart';
import '../../common_widgets.dart/custom_button.dart';
import '../../common_widgets.dart/custom_text_formfield.dart';
import '../../theme/app_theme.dart';
import '../../util/value_validator.dart';
import '../home/home_screen.dart';
import 'login_bloc/login_bloc.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<Loginscreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isObscure = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(
        const Duration(
          milliseconds: 100,
        ), () {
      User? currentUser = Supabase.instance.client.auth.currentUser;
      if (currentUser != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocProvider(
          create: (context) => LoginBloc(),
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccessState) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (route) => false,
                );
              } else if (state is LoginFailureState) {
                showDialog(
                  context: context,
                  builder: (context) => CustomAlertDialog(
                    title: 'Failed',
                    description: state.message,
                    primaryButton: 'Ok',
                  ),
                );
              }
            },
            builder: (context, state) {
              return Stack(
                children: [
                  Image.network(
                    'https://images.unsplash.com/photo-1569413013126-5f9f76c55499?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                  Container(
                    color: Colors.black.withOpacity(0.5),
                  ),
                  Center(
                    child: Container(
                      width: 350,
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(50),
                        border: Border.all(color: primaryColor, width: 2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              Text(
                                'Log in',
                                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                                      color: Colors.white.withAlpha(220),
                                      fontWeight: FontWeight.bold,
                                    ),
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Email',
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.bold,
                                    ),
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              CustomTextFormField(
                                  labelText: 'Enter email',
                                  controller: _emailController,
                                  validator: emailValidator,
                                  isLoading: false),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Password',
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.bold,
                                    ),
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                  controller: _passwordController,
                                  obscureText: isObscure,
                                  decoration: InputDecoration(
                                    filled: true,
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          isObscure = !isObscure;
                                          setState(() {});
                                        },
                                        icon: Icon(
                                          isObscure ? Icons.visibility_off : Icons.visibility,
                                          color: Colors.white,
                                        )),
                                    border: const OutlineInputBorder(),
                                    labelText: 'Password',
                                    labelStyle: TextStyle(color: Colors.white),
                                    prefixIcon: const Icon(
                                      Icons.lock,
                                      color: Colors.white,
                                    ),
                                  )),
                              const SizedBox(
                                height: 30,
                              ),
                              CustomButton(
                                inverse: true,
                                isLoading: state is LoginLoadingState,
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    BlocProvider.of<LoginBloc>(context).add(
                                      LoginEvent(
                                        email: _emailController.text.trim(),
                                        password: _passwordController.text.trim(),
                                      ),
                                    );
                                  }
                                },
                                label: 'Login',
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ));
  }
}

// const Color.fromARGB(255, 199, 50, 225)

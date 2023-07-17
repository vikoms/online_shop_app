import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../di/injection.dart';
import '../../../utils/app_styles.dart';
import '../home/home_page.dart';
import 'bloc/sign_in_bloc.dart';

class SignInPage extends StatefulWidget {
  static const String ROUTE_NAME = '/sign-in';

  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    context.read<SignInBloc>().emit(SignInInitial());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: BlocListener<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state is SignInSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, HomePage.ROUTE_NAME, (route) => false);
          }
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/image_login_header.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 46,
                    left: 46,
                    top: 150,
                    bottom: 52,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Welcome Back',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Yay! You\'re back! Thanks for shopping with us. We have excited deals and promotions going on, grab your pick now! ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Spacer(),
                      Text(
                        'LOG IN',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              BlocBuilder<SignInBloc, SignInState>(
                builder: (context, state) {
                  return Container(
                    padding: EdgeInsets.only(
                      right: 45,
                      left: 45,
                      top: 40,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          state is SignInError ? state.errorMessage ?? '' : '',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Email address',
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              TextField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.email_outlined,
                                    color: Colors.black,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: purpleColor),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: textFieldBorderColor),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  hintText: 'Email',
                                  errorBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  errorText: state is SignInError
                                      ? state.emailErrorMessage
                                      : null,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 24,
                            bottom: 16,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Password',
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              TextField(
                                controller: _passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.lock_outline,
                                    color: Colors.black,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: purpleColor),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: textFieldBorderColor,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  errorText: state is SignInError
                                      ? (state as SignInError)
                                          .passwordErrorMessage
                                      : null,
                                  hintText: 'Password',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: true,
                                      onChanged: (val) {},
                                      activeColor: purpleColor,
                                    ),
                                    Text("Remember Me"),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "Forgot Password",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: purpleColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => context.read<SignInBloc>().add(
                                FormSubmitted(
                                  _emailController.text,
                                  _passwordController.text,
                                ),
                              ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: purpleColor,
                            minimumSize: const Size.fromHeight(50),
                            shape: StadiumBorder(),
                          ),
                          child: Text(
                            "LOG IN",
                          ),
                        ),
                        SizedBox(
                          height: 17,
                        ),
                        RichText(
                          text: TextSpan(
                            text: "Not registered yet? ",
                            style: TextStyle(fontSize: 12, color: greyColor),
                            children: [
                              TextSpan(
                                text: "Create an Account",
                                style: TextStyle(color: purpleColor),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

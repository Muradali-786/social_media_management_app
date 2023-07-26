import 'package:flutter/material.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/utils/utils.dart';
import 'package:tech_media/view_model/signup/signup_controller.dart';

import '../../utils/components/input_text_field.dart';
import '../../utils/components/round_button.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  FocusNode emaiLFocus = FocusNode();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ConfpasswordController = TextEditingController();
  FocusNode userNameFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode ConpasswordFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    emaiLFocus.dispose();
    passwordFocus.dispose();
    ConfpasswordController.dispose();
    userNameFocus.dispose();
    userNameController.dispose();
    ConpasswordFocus.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final Height = MediaQuery.of(context).size.height * 1;
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
          ),
          body: ChangeNotifierProvider(
            create: (_)=> SignUpController(),
            child: Consumer<SignUpController>(
              builder: (context,provider,child){
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: Height * 0.01,
                        ),
                        Text(
                          'Welcome To App',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        SizedBox(
                          height: Height * 0.01,
                        ),
                        Text(
                          'Enter your Email Address \nto register your account ',
                          style: Theme.of(context).textTheme.subtitle1,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: Height * 0.01,
                        ),
                        Form(
                            key: _formKey,
                            child: Padding(
                              padding: EdgeInsets.only(top: Height * 0.06,bottom: Height * 0.01),
                              child: Column(
                                children: [
                                  InputTextField(
                                    myController: userNameController,
                                    focusNode: userNameFocus,
                                    onFieldSubmittedValue: (on) {
                                      Utils.onFoucsChange(context, userNameFocus, emaiLFocus);
                                    },
                                    onValidator: (value) {
                                      return value.isEmpty ? 'Enter your Name' : null;
                                    },
                                    keyBoardType: TextInputType.emailAddress,
                                    obsecureText: true,
                                    hint: 'Username',
                                  ),
                                  SizedBox(
                                    height: Height * 0.01,
                                  ),
                                  InputTextField(
                                    myController: emailController,
                                    focusNode: emaiLFocus,
                                    onFieldSubmittedValue: (on) {
                                      Utils.onFoucsChange(context, emaiLFocus, passwordFocus);
                                    },
                                    onValidator: (value) {
                                      final RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

                                      if(value.isEmpty ){
                                        return 'Please enter your email';
                                      }

                                      else if (!emailRegExp.hasMatch(value)) {
                                        return 'Please enter a valid email address';
                                      }
                                      return null;


                                    },
                                    keyBoardType: TextInputType.emailAddress,
                                    obsecureText: true,
                                    hint: 'Email',
                                  ),
                                  SizedBox(
                                    height: Height * 0.01,
                                  ),
                                  InputTextField(
                                    myController: passwordController,
                                    focusNode: passwordFocus,
                                    onFieldSubmittedValue: (on) {
                                      Utils.onFoucsChange(context, passwordFocus, ConpasswordFocus);
                                    },
                                    onValidator: (value) {
                                      return value.isEmpty ? 'Enter the password' : null;
                                    },
                                    keyBoardType: TextInputType.emailAddress,
                                    obsecureText: true,
                                    hint: 'Password',
                                  ),
                                  SizedBox(
                                    height: Height * 0.01,
                                  ),
                                  InputTextField(
                                    myController: ConfpasswordController,
                                    focusNode: ConpasswordFocus,
                                    onFieldSubmittedValue: (on) {

                                    },
                                    onValidator: (value) {
                                      if(value!=passwordController.value.text){
                                        return "Please Enter Same Password";
                                      }

                                      return null;


                                    },
                                    keyBoardType: TextInputType.emailAddress,
                                    obsecureText: true,
                                    hint: 'Confirm Password',
                                  ),

                                ],
                              ),
                            )),
                        // Align(
                        //   alignment: Alignment.centerRight,
                        //
                        //   child: Text( 'ForgotPassword?',style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 15,decoration: TextDecoration.underline)
                        //   ),
                        // ),


                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        RoundButton(
                            title: 'Sign Up',
                            loading: provider.loading,
                            onPress: () {
                              if(_formKey.currentState!.validate()){
                               provider.signUpController(context,userNameController.text, emailController.text, passwordController.text);

                              }
                            },
                            color: AppColors.iconButtonColor,),
                        SizedBox(
                          height: Height * 0.02,
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.pushNamed(context, RouteName.loginScreen);
                          },
                          child: Text.rich(
                              TextSpan(text: 'Already have an account? ',style: Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 15),
                                  children:[
                                    TextSpan(text: 'Login',style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 15,decoration: TextDecoration.underline)
                                    )
                                  ])
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),

          )
        ));
  }
}


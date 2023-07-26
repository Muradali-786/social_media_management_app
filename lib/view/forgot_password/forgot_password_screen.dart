
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/utils/components/input_text_field.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/utils/utils.dart';
import 'package:tech_media/view_model/forgot_password_controller/forgot_password_controller.dart';
import 'package:tech_media/view_model/login/login_controller.dart';

import '../../res/color.dart';
import '../../utils/components/round_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  TextEditingController emailController = TextEditingController();

  FocusNode emaiLFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    emaiLFocus.dispose();

  }
  @override
  Widget build(BuildContext context) {
    final Height = MediaQuery.of(context).size.height * 1;
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top:20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: Height * 0.01,
                    ),
                    Text(
                      'Forgot Password',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    SizedBox(
                      height: Height * 0.01,
                    ),
                    Text(
                      'Enter your Email Address \nto reset to your password ',
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
                                myController: emailController,
                                focusNode: emaiLFocus,

                                onFieldSubmittedValue: (on) {
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

                            ],
                          ),
                        )),
                    // Align(
                    //   alignment: Alignment.centerRight,
                    //
                    //   child: GestureDetector(
                    //     onTap: (){
                    //       Navigator.pushNamed(context, RouteName.forgotPasswordScreen);
                    //     },
                    //     child: Text( 'ForgotPassword?',style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 15,decoration: TextDecoration.underline)
                    //     ),
                    //   ),
                    // ),


                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.08,
                    ),
                    ChangeNotifierProvider(create: (_)=>ForgotPasswordController(),
                      child: Consumer<ForgotPasswordController>(builder: (context,provider,child){
                        return  RoundButton(
                          title: 'Recover',
                          loading: provider.loading,
                          color: AppColors.primaryColor,
                          onPress: () {

                            if(_formKey.currentState!.validate()){
                              provider.forgotPassword(context, emailController.text);


                            }
                          },
                        );
                      }),
                    ),
                    SizedBox(
                      height: Height * 0.02,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

}
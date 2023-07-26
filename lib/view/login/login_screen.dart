import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/utils/components/input_text_field.dart';
import 'package:tech_media/utils/components/round_button.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/utils/utils.dart';
import 'package:tech_media/view_model/login/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  FocusNode emaiLFocus = FocusNode();

  TextEditingController passwordController = TextEditingController();
  FocusNode passwordFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    emaiLFocus.dispose();
    passwordFocus.dispose();

  }
  @override
  Widget build(BuildContext context) {
    final Height = MediaQuery.of(context).size.height * 1;
    return SafeArea(
        child: Scaffold(
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
                  'Welcome To App',
                  style: Theme.of(context).textTheme.headline1,
                ),
                SizedBox(
                  height: Height * 0.01,
                ),
                Text(
                  'Enter your Email Address \nto connect to your account ',
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
                     onFieldSubmittedValue: (on) {},
                     onValidator: (value) {
                       if(value.length<=5){
                         return 'Lenth is to short';
                       }
                       else if(value.isEmpty){
                         return 'Enter the password';
                       }
                       return null;

                     },
                     keyBoardType: TextInputType.emailAddress,
                     obsecureText: false,
                     hint: 'Password',
                   ),

               ],
             ),
                 )),
                Align(
                  alignment: Alignment.centerRight,

                  child: GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, RouteName.forgotPasswordScreen);
                    },
                    child: Text( 'ForgotPassword?',style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 15,decoration: TextDecoration.underline)
                    ),
                  ),
                ),


                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                ),
               ChangeNotifierProvider(create: (_)=>LoginController(),
                 child: Consumer<LoginController>(builder: (context,provider,child){
                   return  RoundButton(
                       title: 'Login',
                       loading: provider.loading,
                       color: AppColors.iconButtonColor,
                       onPress: () {

                         if(_formKey.currentState!.validate()){
                           provider.login(context, emailController.text, passwordController.text.toString());


                         }
                       },
                       );
                 }),
               ),
                SizedBox(
                  height: Height * 0.02,
                ),
                InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, RouteName.signUpScreen);
                  },
                  child: Text.rich(
                      TextSpan(text: 'Dont have an account? ',style: Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 15),
                          children:[
                            TextSpan(text: 'SignUp',style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 15,decoration: TextDecoration.underline)
                            )
                          ])
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }

}

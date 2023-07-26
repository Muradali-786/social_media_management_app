import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/utils/utils.dart';


class ForgotPasswordController with ChangeNotifier{

  FirebaseAuth auth=FirebaseAuth.instance;

  bool _loading =false;
  get loading =>_loading;

  setLoading(bool value){

    _loading=value;
    notifyListeners();

  }

  void forgotPassword(BuildContext context,String email)async{
    setLoading(true);
    try{
      auth.sendPasswordResetEmail(email: email).
      then((value){
        Utils.toastMessage('please check your email to reset the password');
        Navigator.pushNamed(context, RouteName.loginScreen);
        setLoading(false);
      }).onError((error, stackTrace) {
        Utils.toastMessage(error.toString());
        setLoading(false);
      });


    }catch(e){
      Utils.toastMessage(e.toString());
      setLoading(true);
    }

  }

}
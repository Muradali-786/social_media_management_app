import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/utils/utils.dart';
import 'package:tech_media/view/splash/session_controller.dart';


class LoginController with ChangeNotifier{

  FirebaseAuth auth=FirebaseAuth.instance;

  bool _loading =false;
  get loading =>_loading;

  setLoading(bool value){

    _loading=value;
    notifyListeners();

  }

  void login(BuildContext context,String email,String password)async{
    setLoading(true);
    try{
      auth.signInWithEmailAndPassword(email: email, password: password).
      then((value){
        SessionController().userId=value.user!.uid.toString();
        Navigator.pushNamed(context, RouteName.dashboardScreen);
        setLoading(false);
        Utils.toastMessage('login succesfull ');
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
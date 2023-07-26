import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/utils/utils.dart';
import 'package:tech_media/view/splash/session_controller.dart';


class SignUpController with ChangeNotifier{

  FirebaseAuth auth=FirebaseAuth.instance;
   DatabaseReference ref=FirebaseDatabase.instance.ref().child('User');

  bool _loading =false;
  get loading =>_loading;

  setLoading(bool value){

    _loading=value;
    notifyListeners();

  }

  void signUpController(BuildContext context,String username,String email,String password)async{
    setLoading(true);
    try{
      auth.createUserWithEmailAndPassword(email: email, password: password).
      then((value){
        SessionController().userId=value.user!.uid.toString();
        ref.child(value.user!.uid.toString()).set({
          'uid':value.user!.uid.toString(),
          'email':value.user!.email.toString(),
          'onlineStatus':'noOne',
          'phone':'',
          'username':username,
          'profile':'',

        }).then((value){
          Navigator.pushNamed(context, RouteName.dashboardScreen);
          setLoading(false);
        }).onError((error, stackTrace){
          setLoading(false);
          Utils.toastMessage(error.toString());
        });


        Utils.toastMessage('user created succesfully ');
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
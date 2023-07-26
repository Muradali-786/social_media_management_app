
import 'package:shared_preferences/shared_preferences.dart';

class SessionController{


 static final  SessionController? _session=SessionController._internal();
 String? userId;

 factory SessionController(){

   return _session!;
 }
 SessionController._internal(){

  }
 void idStore()async{
  SharedPreferences sp=await SharedPreferences.getInstance();
  sp.setString('uid',userId.toString());

 }


}
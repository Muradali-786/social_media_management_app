import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/view/splash/session_controller.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('User');
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('User List'),
          ),
          body: FirebaseAnimatedList(
              query: ref,
              itemBuilder: (context, snapshot, animation, index) {

                if( snapshot.child('uid').value.toString()==SessionController().userId.toString()){
                  return Container();
                }else{
                  return Card(
                    child: ListTile(
                      leading: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.iconButtonColor)),
                        child: snapshot.child('profile').value.toString() == ""
                            ? Icon(Icons.person_outlined)
                            : ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  snapshot.child('profile').value.toString())),
                        ),
                      ),
                      title: Text(snapshot.child('username').value.toString()),
                      subtitle: Text(snapshot.child('email').value.toString()),
                    ),
                  );
                }

              })),
    );
  }
}

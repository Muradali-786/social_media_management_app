import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/utils/components/round_button.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/utils/utils.dart';
import 'package:tech_media/view/splash/session_controller.dart';
import 'package:tech_media/view_model/profile/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ref = FirebaseDatabase.instance.ref('User');
  FirebaseAuth auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
      ),
      body: ChangeNotifierProvider(
        create: (_)=>ProfileController(),
        child: Consumer<ProfileController>(builder: (context,provider,child){
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  StreamBuilder(
                      stream:ref.child(SessionController().userId.toString()).onValue,
                      builder: (context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasData) {
                          Map<dynamic,dynamic> map=snapshot.data.snapshot.value;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                                    child: Center(
                                      child: Container(
                                        height: 120,
                                        width: 130,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(width: 3,color: AppColors.primaryTextTextColor.withOpacity(0.9)),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(100),

                                          child:provider.image==null?map['profile'].toString()==""? Icon(Icons.person,size: 35,):
                                          Image(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(map['profile']),
                                            loadingBuilder:
                                                (context, child, loadingProgress) {
                                              if (loadingProgress == null) return child;
                                              return const Center(
                                                  child: CircularProgressIndicator());
                                            },
                                            errorBuilder: (context, object, stack) {
                                              return Container(
                                                child: const Icon(
                                                  Icons.error_outline,
                                                  color: AppColors.alertColor,
                                                ),
                                              );
                                            },
                                          ):
                                              Stack(
                                                children: [
                                                  Image.file(
                                                    File(provider.image!.path).absolute

                                                  ),
                                                  const Center(
                                                    child: CircularProgressIndicator(),
                                                  )
                                                ],
                                              )
                                        ),
                                      ),
                                    ),
                                  ),

                                  InkWell(
                                    onTap: (){
                                     provider.pickImage(context);
                                    },
                                    child: CircleAvatar(
                                      radius: 15,
                                      backgroundColor: AppColors.iconButtonColor,
                                      child:   Icon(Icons.add,color: Colors.white,size: 15,),
                                    ),
                                  )

                                ],
                              ),

                              const  SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                  onTap: (){
                                    provider.showUserAlertBox(context, map['username']);
                                  },
                                  child: ReusableRow(iconData: Icons.person, title: 'username', value: map['username'])),
                              GestureDetector(
                                  onTap: (){
                                    provider.showPhoneAlertBox(context,  map['phone']);
                                  },
                                  child: ReusableRow(iconData: Icons.phone, title: 'phone', value: map['phone']==''?'xxx-xxx-xxx':map['phone'])),
                              ReusableRow(iconData: Icons.email_outlined, title: 'username', value: map['email'])
                            ],
                          );
                        } else {
                          return const Center(
                              child: Text(
                                'something went wrong ',
                                style: TextStyle(color: AppColors.alertColor),
                              ));
                        }
                      }),
                  const SizedBox(
                    height: 40,
                  ),
                  RoundButton(title: 'Log out', onPress: (){
                    auth.signOut().then((value) {
                      Navigator.pushNamed(context, RouteName.loginScreen);
                      SessionController().userId='';
                      Utils.toastMessage('log out');
                    }).onError((error, stackTrace) {
                      Utils.toastMessage(error.toString());

                    });
                  }, color:AppColors.iconButtonColor)
                ],
              ),
            ),
          );
        }),
      )
    );
  }
}

class ReusableRow extends StatelessWidget {
  final String title, value;
  final IconData iconData;
  const ReusableRow({
    Key? key,
    required this.iconData,
    required this.title,
    required this.value,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading:  Icon(iconData),
          title:Text(title,style: Theme.of(context).textTheme.subtitle2,),
          trailing: Text(value,style: Theme.of(context).textTheme.subtitle2,),
        ),
        Divider(color: AppColors.dividedColor.withOpacity(0.5),)
      ],
    );
  }
}

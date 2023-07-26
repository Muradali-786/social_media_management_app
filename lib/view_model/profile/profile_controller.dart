

import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tech_media/res/color.dart';
import 'package:firebase_storage/firebase_storage.dart' as firbase_storage;
import 'package:tech_media/utils/components/input_text_field.dart';
import 'package:tech_media/utils/utils.dart';
import 'package:tech_media/view/splash/session_controller.dart';

class ProfileController with ChangeNotifier{

  DatabaseReference ref=FirebaseDatabase.instance.ref().child('User');

  firbase_storage.FirebaseStorage storage=firbase_storage.FirebaseStorage.instance;


 final phoneController = TextEditingController();
 final nameController = TextEditingController();

 final nameFocus = FocusNode();
  final phoneFocus = FocusNode();



  final picker=ImagePicker();

  XFile? _image;
  XFile? get image=>_image;

  bool _loading =false;
  get loading =>_loading;

  setLoading(bool value){

    _loading=value;
    notifyListeners();

  }

  void galleryImage(BuildContext context)async{
    final pickedFile=await picker.pickImage(source: ImageSource.gallery,imageQuality: 100);

    if(pickedFile!=null){
      _image=XFile(pickedFile.path);
      notifyListeners();
      uploadImage(context);
    }

  }
  void cameraImage(BuildContext context)async{
    final pickedFile=await picker.pickImage(source: ImageSource.camera,imageQuality: 100);

    if(pickedFile!=null){
      _image=XFile(pickedFile.path);
      notifyListeners();
      uploadImage(context);
    }

  }

 void pickImage(context){

   showDialog(context: context, builder: (BuildContext context){
     return AlertDialog(

       content: Container(
         height: 120,
         child: Column(
           children: [
             ListTile(
               onTap: (){
                cameraImage(context);
                Navigator.pop(context);
               },
               leading: Icon(Icons.camera,color: AppColors.primaryIconColor,),
               title: Text('camera'),
             ),
             ListTile(  onTap: (){
               galleryImage(context);
               Navigator.pop(context);

             },
               leading: Icon(Icons.browse_gallery,color: AppColors.primaryIconColor,),
               title: Text('gallery'),
             ),
           ],
         ),
       ),
     );

   });



 }

 void uploadImage(BuildContext context)async{

    setLoading(true);
    firbase_storage.Reference  storageRef=firbase_storage.FirebaseStorage.instance.ref('/profileImage'+SessionController().userId.toString());
    firbase_storage.UploadTask uploadTask=storageRef.putFile(File(image!.path).absolute);

    await Future.value(uploadTask);
    final newUrl=await storageRef.getDownloadURL();

    ref.child(SessionController().userId.toString()).update({

      'profile':newUrl.toString()
    }).then((value) {

      Utils.toastMessage('image Uploaded ');
      setLoading(false);
      _image=null;
    }).onError((error, stackTrace) {
      Utils.toastMessage(error.toString());
      setLoading(false);
    });



 }

 void showUserAlertBox(BuildContext context,String name){
    nameController.text=name;
    showDialog(context: context, builder: (BuildContext context){

      return AlertDialog(
        title: const Center(child: Text('Update username')),
        content: SingleChildScrollView(
          child: Column(
            children: [
              InputTextField(

                  myController: nameController,
                  focusNode:nameFocus,

                  onFieldSubmittedValue:(v){

                  },
                  hint: 'Enter your name',
                  onValidator: (v){

                  },
                  keyBoardType: TextInputType.text
              )

            ],
          ),
        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);

          }, child: Text('cancel',style: Theme.of(context).textTheme.subtitle2!.copyWith(color: AppColors.alertColor),)),
          TextButton(onPressed: (){
            Navigator.pop(context);
            ref.child(SessionController().userId.toString()).update({
              'username':nameController.text
            }).then((value) {
              Utils.toastMessage('username updated successful');
            }).onError((error, stackTrace) {
              Utils.toastMessage('error');
            });

          }, child: Text('ok',style: Theme.of(context).textTheme.subtitle2))
        ],
      );




    });




 }

  void showPhoneAlertBox(BuildContext context,String phone){
    phoneController.text=phone;
    showDialog(context: context, builder: (BuildContext context){

      return AlertDialog(
        title: const Center(child: Text('Update phone number')),
        content: SingleChildScrollView(
          child: Column(
            children: [
              InputTextField(

                  myController: phoneController,
                  focusNode:phoneFocus,

                  onFieldSubmittedValue:(v){

                  },
                  hint: 'update phone number',
                  onValidator: (v){

                  },
                  keyBoardType: TextInputType.number
              )

            ],
          ),
        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);

          }, child: Text('cancel',style: Theme.of(context).textTheme.subtitle2!.copyWith(color: AppColors.alertColor),)),
          TextButton(onPressed: (){
            Navigator.pop(context);
            ref.child(SessionController().userId.toString()).update({
              'phone':phoneController.text
            }).then((value) {
              Utils.toastMessage('phone number updated successful');
            }).onError((error, stackTrace) {
              Utils.toastMessage('error');
            });

          }, child: Text('ok',style: Theme.of(context).textTheme.subtitle2))
        ],
      );




    });




  }


}
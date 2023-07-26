
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:tech_media/res/color.dart';

import 'package:tech_media/view/dashBoord/profile/profile_screen.dart';
import 'package:tech_media/view/dashBoord/user_list/user_list.dart';



class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override

final controller=PersistentTabController(initialIndex: 0);

List<Widget>  _buildScreen(){
  return  [
    Text('Home'),
    Text('Chats'),
    Text('Add'),
   UserList(),
    ProfileScreen(),
  ];

}
List<PersistentBottomNavBarItem>_navBarItems(){
  return [

    PersistentBottomNavBarItem(icon: Icon(Icons.home),
      activeColorPrimary: AppColors.primaryIconColor,
      inactiveIcon:const Icon(Icons.home,color: AppColors.textFieldDefaultBorderColor,),

    ),
    PersistentBottomNavBarItem(icon: Icon(Icons.chat),
      activeColorPrimary: AppColors.primaryIconColor,
      inactiveIcon:const Icon(Icons.chat,color: AppColors.textFieldDefaultBorderColor,),

    ), PersistentBottomNavBarItem(icon: Icon(Icons.add,color: AppColors.whiteColor,),
      activeColorPrimary: AppColors.primaryIconColor,
      inactiveIcon:const Icon(Icons.add,color: AppColors.textFieldDefaultBorderColor,),

    ), PersistentBottomNavBarItem(icon: Icon(Icons.message),
      activeColorPrimary: AppColors.primaryIconColor,
      inactiveIcon:const Icon(Icons.message,color: AppColors.textFieldDefaultBorderColor,),

    ), PersistentBottomNavBarItem(icon: Icon(Icons.person),
      activeColorPrimary: AppColors.primaryIconColor,
      inactiveIcon:const Icon(Icons.person,color: AppColors.textFieldDefaultBorderColor,),

    ),
  ];
}

@override
Widget build(BuildContext context) {
  return PersistentTabView(
    context,
    screens: _buildScreen(),
    items: _navBarItems(),
    backgroundColor: AppColors.secondaryTextColor,
    decoration: NavBarDecoration(
      borderRadius: BorderRadius.circular(1)
    ),
    controller: controller,
    navBarStyle: NavBarStyle.style15,
  );
}
}

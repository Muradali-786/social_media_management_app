import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:tech_media/res/color.dart';


class HomeScreen extends StatefulWidget {
  dynamic? data;
  HomeScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller=PersistentTabController(initialIndex: 0);

  List<Widget>  _buildScreen(){
    return [
      Text('Home'),
    Text('Chats'),
    Text('Add'),
    Text('Message'),
    Text('person'),
    ];

  }
  List<PersistentBottomNavBarItem>_navBarItems(){
    return [

      PersistentBottomNavBarItem(icon: Icon(Icons.home)
      ),
      PersistentBottomNavBarItem(icon: Icon(Icons.chat)),
      PersistentBottomNavBarItem(icon: Icon(Icons.add)),
      PersistentBottomNavBarItem(icon: Icon(Icons.message)),
      PersistentBottomNavBarItem(icon: Icon(Icons.person)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
        context,
        screens: _buildScreen(),
      items: _navBarItems(),
      backgroundColor: AppColors.primaryColor,



    );
  }
}





//
//
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(title: Text('dashboard'),
//       actions: [
//
//       ],
//     ),
//     body: Column(
//       children: [
//         Text(SessionController().userId.toString()),
//         GestureDetector(
//           onTap: (){
//             Navigator.pushNamed(context, RouteName.homeScreen);
//           },
//           child: Center(
//             child: Text('click'),
//           ),
//         )
//       ],
//     ),
//   );
// }
// }

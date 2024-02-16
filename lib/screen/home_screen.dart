import 'package:chat/screen/user_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../firebase/auth_controller.dart';
import '../shard_prf/SharedPref.dart';
import '../themes.dart';
import '../utils/snak_bar.dart';
import 'profile_user.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  static String id = '/home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> screen = [UserScreen(), ProfileUser()];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppThemes.cardDark,

        centerTitle: true,
        title: Text(
          'Chats',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: ()async {
                await   SharedPref.removeData(key: 'uid');
                await SharedPref.removeData(key: 'uidReceive');
                print('dd');

                AuthController auth = AuthController();
                auth.singOut();
                SankBers.showSnackBarSuccess(context, message: 'logout success');
                Navigator.pop(context);
              },
              icon: Icon(Icons.login_outlined)),
          SizedBox(
            width: 5,
          )
        ],
      ),
      body: screen[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme: IconThemeData(
          color: AppThemes.cardDark,
        ),
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              label: '',
              icon: Icon(CupertinoIcons.bubble_left_bubble_right_fill)),
          BottomNavigationBarItem(
              label: '', icon: Icon(CupertinoIcons.person_2_fill))
        ],
      ),
    );
  }
}

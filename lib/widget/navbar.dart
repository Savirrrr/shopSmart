import 'package:flutter/material.dart';
import 'package:shopsmart/pages/bot.dart';
import 'package:shopsmart/pages/hot_deals.dart';
import 'package:shopsmart/pages/profile.dart';
import 'package:shopsmart/pages/search.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if(index==0)
    {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SearchPage()));
    }

    if (index == 1) { // Search button clicked
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ChatScreen()),
      );
    }
  if(index==2){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HotDeals()));
  }
  if(index==3){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ProfilePage()));
  }
  }
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.lightBlue,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(
          backgroundColor: Colors.blue,
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.blue,
          icon: Icon(Icons.android),
          label: 'Bot',
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.blue,
          icon: Icon(Icons.local_fire_department),
          label: 'Deals',
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.blue,
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
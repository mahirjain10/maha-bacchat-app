import 'package:flutter/material.dart';
import 'package:frontend/features/account.dart';
import 'package:frontend/features/dashboard.dart';
import 'package:frontend/features/message.dart';
import 'package:frontend/features/order_and_request.dart';
import 'package:frontend/styles/colors.dart' as styles;

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<StatefulWidget> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 3;
  static const List<Widget> _widgetOptions = <Widget>[
    DashboardPage(),
    MessagePage(),
    OrderAndRequest(),
    AccountPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/icons/home.png"),
              // color: styles.backgroundColor,
              size: 35,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/icons/message.png"),
              // color: styles.backgroundColor,
              size: 35,
            ),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/icons/add.png"),
              // color: styles.backgroundColor,
              size: 35,
            ),
            label: 'Orders & Request',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/icons/account.png"),
              // color: styles.backgroundColor,
              size: 35,
            ),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: styles.backgroundColor,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}

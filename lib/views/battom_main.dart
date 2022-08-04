import 'package:creative/views/booking/backup.dart';
import 'package:creative/views/booking/mainpage.dart';
import 'package:creative/views/profile.dart';
import 'package:flutter/material.dart';
import 'booking/booking.dart';

class BottomBarMain extends StatefulWidget {
  BottomBarMain({Key? key, required this.index}) : super(key: key);
  int index;
  @override
  State<BottomBarMain> createState() => _BottomBarMainState();
}

class _BottomBarMainState extends State<BottomBarMain> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    MainPage(),
    Booking(),
    BackUp(),
    Profile()
  ];
  @override
  void initState() {
    // TODO: implement initState
    widget.index != null ? _selectedIndex = widget.index : _selectedIndex = 0;
  }

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
        backgroundColor: Color.fromARGB(255, 163, 50, 255),
        // selectedFontSize: 15,
        unselectedItemColor: Color.fromARGB(255, 80, 79, 79),
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'หาพี่เลี้ยง',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'นัดหมาย',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'ประวัติ',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
            ),
            label: 'บัญชี',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor:const Color.fromARGB(255, 160, 42, 207),
        onTap: _onItemTapped,
      ),
    );
  }
}

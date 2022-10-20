import 'package:creative/views/booking/backup.dart';
import 'package:creative/views/booking/mainpage.dart';
import 'package:creative/views/profile.dart';
import 'package:flutter/material.dart';
import 'booking/booking.dart';

class BottomBarMain extends StatefulWidget {
  const BottomBarMain({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  State<BottomBarMain> createState() => _BottomBarMainState();
}

class _BottomBarMainState extends State<BottomBarMain> {
  PageController controller = PageController(initialPage: 0, keepPage: true);

  static const List<Widget> _widgetOptions = <Widget>[
    MainPage(),
    Booking(),
    BackUp(),
    Profile()
  ];
  @override
  void initState() {
    super.initState();
    if (widget.index != 10) {
      controller = PageController(initialPage: widget.index);
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      controller.jumpToPage(index);
      controller = PageController(initialPage: index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        onPageChanged: (index) {
          _onItemTapped(index);
        },
        children: [
          Center(
            child: _widgetOptions.elementAt(0),
          ),
          Center(
            child: _widgetOptions.elementAt(1),
          ),
          Center(
            child: _widgetOptions.elementAt(2),
          ),
          Center(
            child: _widgetOptions.elementAt(3),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 76, 124, 172),
        // selectedFontSize: 15,
        unselectedItemColor: const Color.fromARGB(255, 80, 79, 79),
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
        currentIndex: controller.initialPage,
        selectedItemColor: const Color.fromARGB(255, 76, 124, 172),
        onTap: _onItemTapped,
      ),
    );
  }
}

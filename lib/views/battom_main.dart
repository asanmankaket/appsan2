import 'package:creative/views/booking/cancle_book.dart';
import 'package:creative/views/booking/finish_book.dart';
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
    FinishBooking(),
    CancleBooking(),
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
          Center(
            child: _widgetOptions.elementAt(4),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.purple,
        // selectedFontSize: 15,
        unselectedItemColor: const Color.fromARGB(255, 80, 79, 79),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.move_to_inbox),
            label: 'รับการจอง',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'จอง',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'สำเร็จ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer_off_outlined),
            label: 'ยกเลิก',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
            ),
            label: 'บัญชี',
          ),
        ],
        currentIndex: controller.initialPage,
        selectedItemColor: Colors.purple,
        onTap: _onItemTapped,
      ),
    );
  }
}

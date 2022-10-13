import 'package:flutter/material.dart';

import '../views/battom_main.dart';

class ButtonSidemenu extends StatelessWidget {
  const ButtonSidemenu(
      {Key? key, required this.next, required this.text, required this.page})
      : super(key: key);
  final IconData next;
  final String text;
  final int page;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(primary: const Color.fromARGB(255, 67, 67, 67)),
        onPressed: () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => BottomBarMain(index: page)),
              (Route<dynamic> route) => false);
        },
        child: Row(
          children: [
            Icon(next, size: 25),
            const SizedBox(width: 40),
            Text(
              text,
              style: const TextStyle(fontSize: 17),
            ),
          ],
        ));
  }
}

import 'package:flutter/material.dart';

class ProfileMenu extends StatefulWidget {
  const ProfileMenu({Key? key, required this.text, this.press, controller})
      : super(key: key);
  final String text;
  final VoidCallback? press;

  @override
  State<ProfileMenu> createState() => _ProfileMenuState();
}

class _ProfileMenuState extends State<ProfileMenu> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: const Color.fromARGB(255, 43, 103, 151),
          padding: const EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: const Color.fromARGB(255, 227, 230, 241),
        ),
        onPressed: widget.press,
        child: Row(
          children: [
            const SizedBox(width: 20),
            Expanded(child: Text(widget.text)),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}

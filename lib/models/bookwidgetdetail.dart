import 'package:flutter/material.dart';

class CardPageButtonDetail extends StatelessWidget {
  const CardPageButtonDetail({
    Key? key,
    required this.icona,
    required this.title,
    required this.subtitle,
    this.press,
  }) : super(key: key);
  final Icon icona;
  final Text title;
  final Text subtitle;
  final VoidCallback? press;

  // get press;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Card(
        elevation: 1,
        child: ListTile(
          leading: icona,
          title: title,
          trailing: subtitle,
        ),
      ),
    );
  }
}

class BookPageDetail extends StatelessWidget {
  const BookPageDetail(
      {Key? key,
      required this.icona,
      required this.title,
      required this.subtitle})
      : super(key: key);
  final Icon icona;
  final Text title;
  final Text subtitle;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: ListTile(leading: icona, title: title, trailing: subtitle),
    );
  }
}

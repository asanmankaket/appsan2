import 'package:creative/configs/api.dart';
import 'package:flutter/material.dart';

class DialogCancleBook extends StatelessWidget {
  const DialogCancleBook({Key? key, required this.bookId}) : super(key: key);
  final int bookId;
  @override
  Widget build(BuildContext context) {
    TextEditingController textcon = TextEditingController();
    return AlertDialog(
      title: const Text('โปรดแจ้งเหตุผลที่ต้องการยกเลิก'),
      content: TextFormField(
        controller: textcon,
        maxLines: 2,
        decoration: const InputDecoration(
          labelText: 'เหตุผลที่ต้องการยกเลิก',
          hintText: '255 ตัวอักษร',
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 92, 92, 92)),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('ยกเลิก'),
        ),
        TextButton(
          onPressed: () => confirmBook(bookId, 3, textcon.text, context),
          child: const Text('ยืนยัน'),
        ),
      ],
    );
  }
}

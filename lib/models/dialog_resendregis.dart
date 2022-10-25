import 'package:creative/configs/api.dart';
import 'package:flutter/material.dart';

class DialogReturnRegis extends StatelessWidget {
  const DialogReturnRegis({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    return AlertDialog(
      title: const Text('ต้องการส่งข้อมูลอีกครั้งหรือไม่'),
      content: const Text('โปรดเช็คข้อมูลว่าข้อมูลครบถ้วน'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('ยกเลิก'),
        ),
        TextButton(
          onPressed: () {
            resendRegis(now.toString(), context);
          },
          child: const Text('ยืนยัน'),
        ),
      ],
    );
  }
}

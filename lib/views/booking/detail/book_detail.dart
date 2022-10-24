import 'package:creative/models/avatar.dart';
import 'package:creative/models/bookwidgetdetail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/charofname.dart';
import '../../mapbook.dart';

class Bookdetail extends StatefulWidget {
  const Bookdetail({Key? key, required this.data}) : super(key: key);

  final dynamic data;
  @override
  State<Bookdetail> createState() => _BookdetailState();
}

class _BookdetailState extends State<Bookdetail> {
  PageController controller = PageController(initialPage: 0, keepPage: true);
  TextEditingController type = TextEditingController();
  dynamic worktype;

  @override
  void initState() {
    super.initState();
    if (widget.data['book_type'] != null) {
      worktype = typeWork(int.parse(widget.data['book_type']));
    } else {
      worktype = "";
    }
  }

  _makingPhoneCall(phone) async {
    var url = Uri.parse("tel:$phone");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ข้อมูลการจอง'),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          const SizedBox(height: 40),
          widget.data['cust_image'] != null
              ? CircleAvatar(
                  backgroundImage: NetworkImage(widget.data['cust_image']),
                  radius: 80)
              : CircleAvatar(backgroundImage: avatarUser(), radius: 80),
          Text(
            '${widget.data['cust_title']} ${widget.data['cust_fname']} ${widget.data['cust_lname']}',
            style: const TextStyle(fontSize: 25),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 400,
            child: PageView(
              controller: controller,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              pageSnapping: true,
              children: [
                Column(
                  children: [
                    BookPageDetail(
                        icona: const Icon(
                          Icons.calendar_month_outlined,
                          color: Colors.green,
                          size: 30,
                        ),
                        title: const Text('วันเริ่ม'),
                        subtitle:
                            Text(DateFormat('dd/MM/yyyy').format(DateTime.parse(
                          '${widget.data['book_startdate']}',
                        )))),
                    BookPageDetail(
                        icona: const Icon(
                          Icons.calendar_month_outlined,
                          color: Colors.red,
                          size: 30,
                        ),
                        title: const Text('วันจบ'),
                        subtitle:
                            Text(DateFormat('dd/MM/yyyy').format(DateTime.parse(
                          '${widget.data['book_enddate']}',
                        )))),
                    BookPageDetail(
                        icona: const Icon(
                          Icons.access_time,
                          color: Colors.green,
                          size: 30,
                        ),
                        title: const Text('เวลาเริ่ม'),
                        subtitle: Text(widget.data['book_starttime'] + ' น.')),
                    BookPageDetail(
                        icona: const Icon(
                          Icons.access_time,
                          color: Colors.red,
                          size: 30,
                        ),
                        title: const Text('เวลาจบงาน'),
                        subtitle: Text(widget.data['book_endtime'] + ' น.')),
                    BookPageDetail(
                        icona: const Icon(
                          Icons.attach_money,
                          size: 35,
                          color: Colors.green,
                        ),
                        title: const Text('ค่าบริการทั้งหมด'),
                        subtitle: Text(
                            '${widget.data['book_result'].toStringAsFixed(0)}  บาท')),
                    BookPageDetail(
                      icona: typeIcon(widget.data['book_type']),
                      title: const Text('ประเภทการทำงาน'),
                      subtitle: Text(worktype),
                    ),
                  ],
                ),
                Column(
                  children: [
                    CardPageButtonDetail(
                        press: () {
                          _makingPhoneCall(widget.data['cust_phone']);
                        },
                        icona: const Icon(
                          Icons.call,
                          color: Colors.blue,
                          size: 35,
                        ),
                        title: const Text(
                          'เบอร์โทรศัพท์',
                          style: TextStyle(color: Colors.blue),
                        ),
                        subtitle: Text(
                          widget.data['cust_phone'],
                          style: const TextStyle(color: Colors.blue),
                        )),
                    CardPageButtonDetail(
                        press: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                  builder: (BuildContext context) => GoogleMaps(
                                        data: widget.data,
                                      )));
                        },
                        icona: const Icon(Icons.pin_drop,
                            color: Colors.red, size: 35),
                        title: const Text(
                          'ที่อยู่',
                          style: TextStyle(color: Colors.blue),
                        ),
                        subtitle: Text(
                          '${widget.data['book_pinhome']} ตำบล  ${widget.data['book_tambons']} \n อำเภอ ${widget.data['book_amphures']} จังหวัด ${widget.data['book_provinces']}',
                          style: const TextStyle(color: Colors.blue),
                        )),
                    const SizedBox(height: 2),
                    Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 4, color: Colors.blue),
                        ),
                        height: 270,
                        width: double.maxFinite,
                        child: widget.data['book_images'] != null
                            ? Image(
                                image: NetworkImage(widget.data['book_images']),
                                fit: BoxFit.cover,
                              )
                            : const Center(child: Text('ไม่มีรูปเพิ่มเติม'))),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

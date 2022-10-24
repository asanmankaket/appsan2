import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../configs/api.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({Key? key}) : super(key: key);

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  dynamic data;
  late double ratting;
  @override
  void initState() {
    super.initState();
    startApi();
  }

  startApi() async {
    var item = await inputcomment();
    setState(() {
      data = item;
    });
  }

  rattingS(i) {
    ratting = double.parse('${data[i]['rev_score']}');
    return ratting;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('คะแนนและความคิดเห็น'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SizedBox(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: data?.length ?? 0,
          itemBuilder: (context, i) => InkWell(
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const SizedBox(width: 20),
                          Container(
                            padding: const EdgeInsets.all(22),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 5),
                                RatingBarIndicator(
                                  rating: data[i]['rev_score'] != null
                                      ? double.parse("${data[i]['rev_score']}")
                                      : 0,
                                  itemSize: 20,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 1),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  '${data[i]['rev_review']}',
                                  style: const TextStyle(fontSize: 18),
                                )
                              ],
                            ),
                          ),
                        ])
                  ]),
            ),
          ),
        ),
      )),
    );
  }
}

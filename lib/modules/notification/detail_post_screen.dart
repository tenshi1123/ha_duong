import 'package:flutter_html/flutter_html.dart';
import 'package:ha_duong/models/info_model.dart';
import 'package:ha_duong/utils/constants/color.dart';
import 'package:ha_duong/utils/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailPostScreen extends StatefulWidget {
  const DetailPostScreen({
    super.key,
    required this.postModel,
  });
  final PostModel postModel;
  @override
  State<DetailPostScreen> createState() => _DetailPostScreenState();
}

class _DetailPostScreenState extends State<DetailPostScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: keyBlack),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        title: Center(
          child: Text(
            'Bảng tin    ',
            style: defaultText18B.copyWith(
              color: keyBlack,
            ),
          ),
        ),
        actions: const [Icon(Icons.arrow_back_ios_new, color: Colors.white)],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.postModel.name,
              style: defaultText16B,
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(widget.postModel.updatedAt, style: defaultText14M),
            SizedBox(
              height: 8.h,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16.r))),
              child: Image.network(
                'https://bms.haduong.com.vn/images/${widget.postModel.img}',
                //height: 180.w,
                width: 300.h,
                fit: BoxFit.fitWidth,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Html(
              data: widget.postModel.content,
            ),
          ],
        ),
      ),
    );
  }
}

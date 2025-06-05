import 'package:flutter_html/flutter_html.dart';
import 'package:ha_duong/models/info_model.dart';
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
        backgroundColor: const Color(0xff273D8C),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        title: Text(
          'Chi tiết Tin',
          style: defaultText18B.copyWith(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              'https://bms.haduong.com.vn/images/${widget.postModel.img}',
              height: 180.w,
              width: 343.h,
              fit: BoxFit.fill,
            ),
            SizedBox(
              height: 10.h,
            ),
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
            Html(
              data: widget.postModel.content,
            )
          ],
        ),
      ),
    );
  }
}

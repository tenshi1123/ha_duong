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
        title: Text(
          'Bảng tin',
          style: defaultText18B.copyWith(
            color: keyBlack,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1), // chiều cao của divider
          child: Container(
            color: Colors.grey.shade200,
            height: 1,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 6.w,
              ),
              child: Text(
                widget.postModel.name,
                style: defaultText16B,
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 6.w,
              ),
              child: Text(widget.postModel.updatedAt,
                  style:
                      defaultText14M.copyWith(color: const Color(0xff8A8A8A))),
            ),
            SizedBox(
              height: 8.h,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(16.r),
                ),
                border: Border.all(
                  color: const Color(0xfff0f0f0),
                ),
              ),
              child: Image.network(
                'https://bms.haduong.com.vn/images/${widget.postModel.img}',
                //height: 180.w,
                width: 343.h,
                fit: BoxFit.fitWidth,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Html(
              data: widget.postModel.content,
              style: {
                ".title": Style(
                  fontSize: FontSize(20.0),
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
                ".body": Style(
                  fontSize: FontSize(16.0),
                  color: Colors.black87,
                ),
              },
            ),
          ],
        ),
      ),
    );
  }
}

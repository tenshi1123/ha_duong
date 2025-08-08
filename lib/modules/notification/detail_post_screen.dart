import 'package:flutter_html/flutter_html.dart';
import 'package:ha_duong/models/info_model.dart';
import 'package:ha_duong/repo/home_repo.dart';
import 'package:ha_duong/utils/constants/color.dart';
import 'package:ha_duong/utils/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailPostScreen extends StatefulWidget {
  const DetailPostScreen({
    super.key,
    //required this.postModel,
    required this.postId,
  });
  //final PostModel postModel;
  final String postId;
  @override
  State<DetailPostScreen> createState() => _DetailPostScreenState();
}

class _DetailPostScreenState extends State<DetailPostScreen>
    with SingleTickerProviderStateMixin {
  late PostModel data;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await HomeRepo().getDetailPostModel(widget.postId);
      setState(() {
        data = response;
        isLoading = false;
      });
    } catch (e) {
      // Xử lý lỗi nếu cần
      debugPrint('Lỗi khi gọi API: $e');
      setState(() {
        isLoading = false;
      });
    }
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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                      ),
                      child: Text(
                        data.name,
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
                      child: Text(data.createAt,
                          style: defaultText14M.copyWith(
                              color: const Color(0xff8A8A8A))),
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
                        'https://bms.haduong.com.vn/images/${data.img}',
                        //height: 180.w,
                        width: 343.h,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SelectionArea(
                      child: Html(
                        data: data.content,
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
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

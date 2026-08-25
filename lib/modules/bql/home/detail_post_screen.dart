import 'package:ha_duong/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html_table/flutter_html_table.dart';
import 'package:ha_duong/bql_model/home_model.dart';
import 'package:ha_duong/utils/constants/color.dart';
import 'package:ha_duong/utils/constants/styles.dart';
import 'package:ha_duong/utils/widget/webview_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

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
          AppLocalizations.of(context)!.bqlBangTin,
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
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
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
                  child: Text(widget.postModel.createAt,
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
                    'https://bms.haduong.com.vn/images/${widget.postModel.img}',
                    //height: 180.w,
                    width: 343.h,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                if (widget.postModel.urlFile != null)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black87,
                      backgroundColor: Colors.grey[300],
                      minimumSize: Size(88, 36),
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                      ),
                    ),
                    onPressed: () {
                      // open WebViewScreen
                      // ignore: use_build_context_synchronously
                      pushWithoutNavBar(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => WebViewScreen(
                                link: widget.postModel.urlFile!,
                                title: 'File đính kèm',
                              )),
                        ),
                      );
                    },
                    child: Text('file đính kèm'),
                  ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context)
                          .size
                          .width, // giới hạn chiều rộng
                    ),
                    child: SelectionArea(
                      child: Html(
                        data: """
                            <style>
                              table {
                                border-collapse: collapse;
                                table-layout: auto;   /* bắt buộc auto layout */
                                width: auto;          /* không ép full width */
                              }
                              th, td {
                                border: 1px solid #999;
                                padding: 6px 10px;
                                white-space: nowrap;  /* không xuống dòng lung tung */
                              }
                            </style>
                            ${widget.postModel.content}
                            """,
                        extensions: const [
                          TableHtmlExtension(),
                        ],
                        style: {
                          "table": Style(
                            padding: HtmlPaddings.all(4),
                          ),
                          "td": Style(
                            padding: HtmlPaddings.all(6),
                            whiteSpace:
                                WhiteSpace.normal, // giữ chữ trên 1 dòng
                          ),
                          "th": Style(
                            padding: HtmlPaddings.all(6),
                            fontWeight: FontWeight.bold,
                            backgroundColor: Colors.black12,
                            whiteSpace: WhiteSpace.normal,
                          ),
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../../utils/constants/color.dart';
import '../../../utils/constants/styles.dart';
import '../../../utils/widget/custom_widget.dart';

class ListConversationScreen extends StatelessWidget {
  const ListConversationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 100.h,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    child: Container(
                      width: 390.w,
                      height: 140.h,
                      color: Colors.white,
                      // decoration: BoxDecoration(gradient: mainGradient),
                    ),
                  ),
                  Positioned(
                    bottom: 30.h,
                    left: 20.w,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.keyboard_arrow_left,
                            size: 30.h,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: 111.w,
                        ),
                        Text('Chat', style: defaultText18B),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const ConversationItem(
              title1: 'Lê Thanh Hải',
              title2: 'Xin chào! Mình là Lê Thanh Hải',
              title3: 'assets/images/avatar2.png',
              title4: '',
            ),
            SizedBox(
              height: 16.h,
            ),
            const ConversationItem(
              title1: 'Nguyễn Thanh Huyền',
              title2:
                  'Xin chào! Mình là Nguyễn Thanh Huyền, rất vui khi được...',
              title3: 'assets/images/avatar3.png',
              title4: '',
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: HtmlWidget(
                '''

              ''',
                textStyle: defaultText14B,
              ),
            ),
            // ListView.builder(
            //     shrinkWrap: true,
            //     padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.w),
            //     physics: const ClampingScrollPhysics(),
            //     itemCount: 4,
            //     itemBuilder: (BuildContext context, int index) {
            //       return Padding(
            //         padding: EdgeInsets.only(bottom: 10.h),
            //         child: ConversationItem(
            //           index: index,
            //         ),
            //       );
            //     }),
          ],
        ),
      ),
    );
  }
}

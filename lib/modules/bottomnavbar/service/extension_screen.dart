import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import '../../../utils/constants/styles.dart';
import 'service_screen.dart';

class ExtensionScreen extends StatelessWidget {
  const ExtensionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          // leading: IconButton(
          //   icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          //   onPressed: () {},
          // ),
          title: Center(
            child: Text(
              'Dịch vụ tiện ích',
              style: defaultText18B.copyWith(
                color: const Color(0xff3C3C3C),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            const Divider(),
            SizedBox(
              height: 16.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 16.w,
                ),
                GestureDetector(
                  onTap: () {
                    pushWithoutNavBar(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => const ServiceScreen(
                              title: 'Dịch vụ thang máy',
                            )),
                      ),
                    );
                  },
                  child: Image.asset(
                    'assets/images/image1.png',
                    width: 164.w,
                    height: 108.h,
                    fit: BoxFit.fill,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    pushWithoutNavBar(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => const ServiceScreen(
                              title: 'Dịch vụ bể bơi',
                            )),
                      ),
                    );
                  },
                  child: Image.asset(
                    'assets/images/image2.png',
                    width: 164.w,
                    height: 108.h,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  width: 16.w,
                ),
              ],
            ),
            SizedBox(
              height: 16.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 16.w,
                ),
                GestureDetector(
                  onTap: () {
                    pushWithoutNavBar(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => const ServiceScreen(
                              title: 'Tìm người giúp việc',
                            )),
                      ),
                    );
                  },
                  child: Image.asset(
                    'assets/images/image3.png',
                    width: 164.w,
                    height: 108.h,
                    fit: BoxFit.fill,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    pushWithoutNavBar(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => const ServiceScreen(
                              title: 'Sinh hoạt cộng đồng',
                            )),
                      ),
                    );
                  },
                  child: Image.asset(
                    'assets/images/image4.png',
                    width: 164.w,
                    height: 108.h,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  width: 16.w,
                ),
              ],
            ),
          ],
        ));
  }
}

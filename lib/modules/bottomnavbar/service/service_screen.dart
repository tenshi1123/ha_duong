import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ha_duong/models/apartment_model.dart';
import 'package:ha_duong/models/info_model.dart';
import 'package:ha_duong/repo/home_repo.dart';
import '../../../utils/constants/styles.dart';
import '../../../utils/widget/custom_dialog.dart';
import 'package:flutter_html/flutter_html.dart';

class ServiceScreen extends StatelessWidget {
  const ServiceScreen(
      {super.key, required this.apartmentId, required this.utilitiesModel});
  final String apartmentId;
  final UtilitiesModel utilitiesModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            utilitiesModel.name,
            style: defaultText18B.copyWith(
              color: const Color(0xff3C3C3C),
            ),
          ),
        ),
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    Image.network(
                      'https://bms.haduong.com.vn/images/${utilitiesModel.img}',
                      width: 343.w,
                      height: 180.h,
                      fit: BoxFit.fill,
                    ),
                  ],
                ),
                SizedBox(
                  height: 16.h,
                ),
                // Padding(
                //   padding: EdgeInsets.only(left: 16.w),
                //   child: Text(
                //     'Mô tả dịch vụ',
                //     style: defaultText14B.copyWith(
                //       color: const Color(0xff3C3C3C),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  child: SelectionArea(
                    child: Html(
                      data: utilitiesModel.content,
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                height: 98.h,
                width: 375.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      spreadRadius: 0,
                      blurRadius: 16,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: GestureDetector(
                  onTap: () async {
                    DangKyModel dangKyModel = await HomeRepo()
                        .showDangKy(utilitiesModel.id.toString(), apartmentId);
                    showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => CustomerInfoForm(
                              dangKyModel: dangKyModel,
                            )
                        // ServiceDialog(
                        //       dangKyModel: dangKyModel,
                        //     )
                        );
                  },
                  child: Container(
                    width: 343.w,
                    height: 50.h,
                    margin: EdgeInsets.only(
                        left: 16.w, bottom: 30.h, top: 16.w, right: 16.w),
                    constraints: BoxConstraints(maxHeight: 120.h),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF25AAE1),
                          Color(0xFF004071),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.0, 1.0],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Center(
                        child: Text(
                      'Đăng ký dịch vụ',
                      style: defaultText14B.copyWith(color: Colors.white),
                    )),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}

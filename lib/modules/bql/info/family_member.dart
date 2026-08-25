import 'package:ha_duong/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ha_duong/utils/constants/styles.dart';
import 'package:ha_duong/utils/widget/custom_dialog_bql.dart';

import 'package:widgets_easier/widgets_easier.dart';
import 'bql_personal_screen.dart';

class FamilyMemberScreen extends StatelessWidget {
  const FamilyMemberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Thành viên trong hộ gia đình',
          style: defaultText18M,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Divider(),
            SizedBox(
              height: 28.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 16.w,
                ),
                Text(
                  AppLocalizations.of(context)!.bqlNguyenThuHuong,
                  style: defaultText16B,
                ),
                const Spacer(),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            infoItem(title: 'Số định danh', info: '0360898908759'),
            Divider(
              color: const Color(0xffE6E6E6),
              thickness: 1,
              endIndent: 16.w,
              indent: 16.w,
              height: 24.h,
            ),
            infoItem(title: AppLocalizations.of(context)!.bqlNgaySinh, info: '02/06/1996'),
            Divider(
              color: const Color(0xffE6E6E6),
              thickness: 1,
              endIndent: 16.w,
              indent: 16.w,
              height: 24.h,
            ),
            infoItem(title: 'Số điện thoại', info: '0971116262'),
            Divider(
              color: const Color(0xffE6E6E6),
              thickness: 1,
              endIndent: 16.w,
              indent: 16.w,
              height: 24.h,
            ),
            infoItem(title: AppLocalizations.of(context)!.bqlEmail, info: AppLocalizations.of(context)!.bqlAbcxyzgmailcom),
            Divider(
              color: const Color(0xffE6E6E6),
              thickness: 1,
              endIndent: 16.w,
              indent: 16.w,
              height: 24.h,
            ),
            infoItem(title: AppLocalizations.of(context)!.bqlQuanHeVoiChuHo, info: AppLocalizations.of(context)!.bqlVo),
            Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 20.h,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 12.h,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xff25AAE1), width: 1),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  // boxShadow: const [
                  //   BoxShadow(
                  //     color: Colors.black12,
                  //     blurRadius: 4,
                  //     offset: Offset(0, 2),
                  //   ),
                  // ],
                ),
                child: GestureDetector(
                  onTap: () {
                    showDialog<String>(
                        context: context,
                        builder: (BuildContext context) =>
                            const ChangeHouseholdInfoForm());
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/edit_info.svg',
                        width: 20.w,
                        height: 20.h,
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Text(
                        AppLocalizations.of(context)!.bqlChinhSuaThongTinThanhVien,
                        style: defaultText14B.copyWith(
                            color: const Color(0xff25AAE1)),
                      ),
                    ],
                  ),
                )),
            AddMemberButton(
              onPressed: () {
                showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => const AddMember());
              },
            )
          ],
        ),
      ),
    );
  }
}

class AddMemberButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddMemberButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 48.h,
        width: 343.w,
        decoration: ShapeDecoration(
          shape: DashedBorder(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xff25AAE1),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/add.svg',
              width: 20.w,
              height: 20.h,
            ),
            SizedBox(
              width: 8.w,
            ),
            Text(
              AppLocalizations.of(context)!.bqlThemThanhVien,
              style: defaultText14B.copyWith(color: const Color(0xff25AAE1)),
            ),
          ],
        ),
      ),
    );
  }
}

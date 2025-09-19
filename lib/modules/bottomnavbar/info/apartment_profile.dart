import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ha_duong/models/apartment_model.dart';
import 'package:ha_duong/models/info_model.dart';
import 'package:ha_duong/repo/personal_repo.dart';

import '../../../utils/constants/styles.dart';
import '../../../utils/widget/custom_dialog.dart';
import 'family_member.dart';
import 'personal_screen.dart';

class ApartmentProfile extends StatelessWidget {
  const ApartmentProfile(
      {super.key, required this.apartmentModel, required this.residentModel});
  final List<ApartmentModel> apartmentModel;
  final ResidentModel residentModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Hồ sơ căn hộ'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
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
            _ApartmentItem(residentModel),
            Divider(
              color: const Color(0xffF0F0F0),
              thickness: 6,
              height: 24.h,
            ),
            SizedBox(
              height: 20.h,
            ),
            Column(
              children: List.generate(apartmentModel.length, (index) {
                return _ApartmentInfo(apartmentModel[index]);
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _ApartmentItem extends StatelessWidget {
  const _ApartmentItem(this.residentModel);
  final ResidentModel residentModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 16.w,
            ),
            Text(
              'Thông tin cư trú',
              style: defaultText16B,
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Chủ hộ',
                    style: defaultText14Re.copyWith(color: Colors.black),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 16.w,
            ),
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
        infoItem(title: 'Họ và tên', info: residentModel.fullName),
        Divider(
          color: const Color(0xffF0F0F0),
          thickness: 1,
          endIndent: 16.w,
          indent: 16.w,
          height: 24.h,
        ),
        infoItem(title: 'Số định danh', info: residentModel.idCard),
        Divider(
          color: const Color(0xffF0F0F0),
          thickness: 1,
          endIndent: 16.w,
          indent: 16.w,
          height: 24.h,
        ),
        infoItem(title: 'Ngày sinh', info: residentModel.dob),
        Divider(
          color: const Color(0xffF0F0F0),
          thickness: 1,
          endIndent: 16.w,
          indent: 16.w,
          height: 24.h,
        ),
        infoItem(title: 'Số điện thoại', info: residentModel.phone),
        Divider(
          color: const Color(0xffF0F0F0),
          thickness: 1,
          endIndent: 16.w,
          indent: 16.w,
          height: 24.h,
        ),
        infoItem(title: 'Email', info: residentModel.email),
        Divider(
          color: const Color(0xffF0F0F0),
          thickness: 1,
          endIndent: 16.w,
          indent: 16.w,
          height: 24.h,
        ),
        GestureDetector(
          onTap: () {
            showDialog<String>(
                context: context,
                builder: (BuildContext context) => ChangeChuHoInfo(
                      model: residentModel,
                    ));
          },
          child: const _EditInfo('Chỉnh sửa thông tin Chủ hộ'),
        ),
      ],
    );
  }
}

class _ApartmentInfo extends StatelessWidget {
  const _ApartmentInfo(this.model);
  final ApartmentModel model;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 16.w,
            ),
            Text(
              'Thông tin căn hộ',
              style: defaultText16B,
            ),
            const Spacer(),
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
        infoItem(title: 'Số nhà ', info: model.name),
        Divider(
          color: const Color(0xffF0F0F0),
          thickness: 1,
          endIndent: 16.w,
          indent: 16.w,
          height: 24.h,
        ),
        infoItem(title: 'Tầng', info: model.numberFloors),
        Divider(
          color: const Color(0xffF0F0F0),
          thickness: 1,
          endIndent: 16.w,
          indent: 16.w,
          height: 24.h,
        ),
        infoItem(title: 'Diện tích mặt sàn', info: '${model.acreage}m2'),
        Divider(
          color: const Color(0xffF0F0F0),
          thickness: 1,
          endIndent: 16.w,
          indent: 16.w,
          height: 24.h,
        ),
        infoItem(title: 'Tình trạng', info: model.statusText),
        Divider(
          color: const Color(0xffF0F0F0),
          thickness: 1,
          endIndent: 16.w,
          indent: 16.w,
          height: 24.h,
        ),
        _FamilyMemberTile(model.id),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }
}

class _FamilyMemberTile extends StatelessWidget {
  const _FamilyMemberTile(this.apartmentId);
  final String apartmentId;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        List<ResidentModel> model =
            await PersonalRepo().getApartmentResident(apartmentId);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => FamilyMemberScreen(
                  apartmentId: apartmentId,
                  model: model,
                )),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 16.w,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 10.h,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffF0F0F0), width: 1),
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
        child: Row(
          children: [
            Text(
              'Thành viên trong hộ gia đình',
              style: defaultText16Re,
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 18),
          ],
        ),
      ),
    );
  }
}

class _EditInfo extends StatelessWidget {
  const _EditInfo(this.title);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(
          horizontal: 16.w,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 10.h,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xff25AAE1), width: 1),
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/edit_info.svg',
              width: 16.w,
              height: 16.h,
            ),
            SizedBox(
              width: 8.w,
            ),
            Text(
              title,
              style: defaultText14B.copyWith(color: const Color(0xff25AAE1)),
            ),
          ],
        ));
  }
}

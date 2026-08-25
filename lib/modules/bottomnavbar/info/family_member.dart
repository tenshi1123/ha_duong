import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ha_duong/models/info_model.dart';
import 'package:ha_duong/modules/bottomnavbar/info/resident_personal_screen.dart';
import 'package:ha_duong/utils/constants/styles.dart';
import 'package:ha_duong/utils/widget/custom_dialog.dart';
import 'package:widgets_easier/widgets_easier.dart';
import 'package:ha_duong/l10n/app_localizations.dart';

class FamilyMemberScreen extends StatelessWidget {
  const FamilyMemberScreen(
      {super.key, required this.apartmentId, required this.model});
  final String apartmentId;
  final List<ResidentModel> model;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          AppLocalizations.of(context)!.familyMembers,
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
            if (model.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: model.length,
                itemBuilder: (context, index) {
                  return FamilyMember(
                    model: model[index],
                    apartmentId: apartmentId,
                  );
                },
              ),
            AddMemberButton(
              onPressed: () {
                showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AddMember(
                          type: 0,
                          apartmentId: apartmentId,
                          residentId: '',
                        ));
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
              AppLocalizations.of(context)!.addMember,
              style: defaultText14B.copyWith(color: const Color(0xff25AAE1)),
            ),
          ],
        ),
      ),
    );
  }
}

class FamilyMember extends StatelessWidget {
  const FamilyMember(
      {super.key, required this.model, required this.apartmentId});
  final ResidentModel model;
  final String apartmentId;
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
              model.fullName,
              style: defaultText16B,
            ),
            const Spacer(),
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
        infoItem(
            context: context,
            title: AppLocalizations.of(context)!.idNumber,
            info: model.idCard),
        Divider(
          color: const Color(0xffF0F0F0),
          thickness: 1,
          endIndent: 16.w,
          indent: 16.w,
          height: 24.h,
        ),
        infoItem(
            context: context,
            title: AppLocalizations.of(context)!.dob,
            info: model.dob),
        Divider(
          color: const Color(0xffF0F0F0),
          thickness: 1,
          endIndent: 16.w,
          indent: 16.w,
          height: 24.h,
        ),
        infoItem(
            context: context,
            title: AppLocalizations.of(context)!.phoneLabel,
            info: model.phone),
        Divider(
          color: const Color(0xffF0F0F0),
          thickness: 1,
          endIndent: 16.w,
          indent: 16.w,
          height: 24.h,
        ),
        infoItem(context: context, title: 'Email', info: model.email),
        Divider(
          color: const Color(0xffF0F0F0),
          thickness: 1,
          endIndent: 16.w,
          indent: 16.w,
          height: 24.h,
        ),
        infoItem(
            context: context,
            title: AppLocalizations.of(context)!.relationToHead,
            info: _convertToLabel(context, model.relationshipType)),
        GestureDetector(
          onTap: () {
            showDialog<String>(
                context: context,
                builder: (BuildContext context) => AddMember(
                      type: 1,
                      apartmentId: apartmentId,
                      residentId: model.id,
                    ));
          },
          child: Container(
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
                    AppLocalizations.of(context)!.editMemberInfo,
                    style:
                        defaultText14B.copyWith(color: const Color(0xff25AAE1)),
                  ),
                ],
              )),
        ),
      ],
    );
  }
}

String _convertToLabel(BuildContext context, String key) {
  switch (key) {
    case 'vo_chong':
      return AppLocalizations.of(context)!.spouse;
    case 'con_cai':
      return AppLocalizations.of(context)!.children;
    case 'bo_me':
      return AppLocalizations.of(context)!.parents;
    case 'anh_chi_em':
      return AppLocalizations.of(context)!.siblings;
    case 'khach_thue':
      return AppLocalizations.of(context)!.tenant;
    default:
      return key;
  }
}

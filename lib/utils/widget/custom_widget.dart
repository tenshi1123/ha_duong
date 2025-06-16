import 'package:ha_duong/models/apartment_model.dart';
import 'package:ha_duong/models/info_model.dart';
import 'package:ha_duong/modules/notification/detail_post_screen.dart';
import 'package:ha_duong/repo/home_repo.dart';
import 'package:ha_duong/utils/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import '../../modules/chat/chat_screen.dart';
import '../constants/color.dart';

Widget homeTab(
    {required String title,
    bool isSeprator = true,
    bool hasNumber = true,
    int count = 0}) {
  return Tab(
    child: Container(
      //width: 70.w,
      height: 50.h,
      decoration: isSeprator
          ? const BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: Colors.grey,
                  width: 1,
                  style: BorderStyle.solid,
                ),
              ),
            )
          : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 3.w,
          ),
          SizedBox(
            width: 77.w,
            child: Center(
              child: Text(
                title,
              ),
            ),
          ),
          hasNumber
              ? Container(
                  decoration: BoxDecoration(
                    color: keyBlack,
                    borderRadius: BorderRadius.all(Radius.circular(10.r)),
                  ),
                  height: 20.h,
                  padding: EdgeInsets.symmetric(horizontal: 4.h),
                  child: Center(
                    child: Text(
                      '10',
                      style: defaultText12B.copyWith(color: Colors.white),
                    ),
                  ),
                )
              : SizedBox(
                  width: 10.w,
                ),
        ],
      ),
    ),
  );
}

class ConversationItem extends StatelessWidget {
  const ConversationItem(
      {super.key,
      required this.title1,
      required this.title2,
      required this.title3,
      required this.title4});

  final String title1;
  final String title2;
  final String title3;
  final String title4;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => ChatScreen(
        //       title: title1,
        //       avatar: title3,
        //     ),
        //   ),
        // );
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image(
            image: AssetImage(title3),
            height: 48.h,
            width: 48.w,
          ),
          SizedBox(
            width: 220.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title1,
                  style: defaultText16B,
                ),
                Text(
                  title2,
                  style: defaultText14M.copyWith(
                    color: const Color(0xff292929).withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '09:03',
                style: defaultText12Re,
              ),
              SizedBox(
                height: 8.h,
              ),
              SvgPicture.asset(
                'assets/icons/seen.svg',
                height: 17.h,
                width: 14.w,
                fit: BoxFit.scaleDown,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PostItem extends StatelessWidget {
  const PostItem({
    super.key,
    required this.postModel,
  });
  final PostModel postModel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        PostModel detailModel =
            await HomeRepo().getDetailPostModel(postModel.id);
        pushWithoutNavBar(
          context,
          MaterialPageRoute(
            builder: ((context) => DetailPostScreen(
                  postModel: detailModel,
                )),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16.r))),
            child: Image.network(
              'https://bms.haduong.com.vn/images/${postModel.img}',
              width: 240.w,
              height: 160.h,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Expanded(
            child: Text(
              postModel.name,
              style: defaultText14B,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final String? initialValue;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;

  const CustomTextFormField({
    super.key,
    required this.labelText,
    required this.hintText,
    this.initialValue,
    this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      controller: controller,
      validator: validator,
      style: defaultText16Re,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: defaultText14M,
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.circular(5.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(5.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    );
  }
}

class ApartmentDropdown extends StatelessWidget {
  final ApartmentModel selectedApartment;
  final List<ApartmentModel> apartmentList;
  final void Function(ApartmentModel?) onChanged;

  const ApartmentDropdown({
    super.key,
    required this.selectedApartment,
    required this.apartmentList,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      width: 343.w,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(56.r)),
        color: Colors.white.withAlpha(30), // 12% of 255 ≈ 30
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<ApartmentModel>(
          isExpanded: true,
          value: selectedApartment,
          icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
          dropdownColor: Colors.white,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
          onChanged: onChanged,
          items: apartmentList
              .map(
                (apartment) => DropdownMenuItem<ApartmentModel>(
                  value: apartment,
                  child: Text(apartment.name),
                ),
              )
              .toList(),
          selectedItemBuilder: (BuildContext context) {
            return apartmentList.map((apartment) {
              return Row(
                children: [
                  Image.asset(
                    'assets/images/location.png',
                    height: 20.5.h,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    apartment.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }).toList();
          },
        ),
      ),
    );
  }
}

class RelationshipDropdown extends StatefulWidget {
  final String? value;
  final Function(String?)? onChanged;
  const RelationshipDropdown({super.key, this.value, this.onChanged});
  @override
  State<RelationshipDropdown> createState() => _RelationshipDropdownState();
}

class _RelationshipDropdownState extends State<RelationshipDropdown> {
  final List<String> _options = [
    'vo_chong',
    'con_cai',
    'bo_me',
    'anh_chi_em',
    'khach_thue',
  ];

  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _selectedValue,
      decoration: InputDecoration(
        labelText: 'Quan hệ với chủ hộ',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Vui lòng nhập Quan hệ với chủ hộ';
        }
        return null;
      },
      items: _options
          .map((relation) => DropdownMenuItem(
                value: relation,
                child: Text(_convertToLabel(relation)),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          _selectedValue = value;
        });
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
      },
    );
  }

  String _convertToLabel(String key) {
    switch (key) {
      case 'vo_chong':
        return 'Vợ/Chồng';
      case 'con_cai':
        return 'Con cái';
      case 'bo_me':
        return 'Bố/Mẹ';
      case 'anh_chi_em':
        return 'Anh/Chị/Em';
      case 'khach_thue':
        return 'Khách thuê';
      default:
        return key;
    }
  }
}

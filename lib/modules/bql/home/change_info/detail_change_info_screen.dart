import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ha_duong/bql_model/info_model_bql.dart';
import 'package:ha_duong/bql_repo/technical_requests_repo.dart';
import 'package:ha_duong/utils/constants/styles.dart';

class DetailChangeInfoScreen extends StatefulWidget {
  const DetailChangeInfoScreen(
      {super.key,
      required this.id,
      required this.title1,
      required this.title2});
  final String id;
  final String title1;
  final String title2;
  @override
  State<DetailChangeInfoScreen> createState() => _DetailChangeInfoScreenState();
}

class _DetailChangeInfoScreenState extends State<DetailChangeInfoScreen> {
  bool isLoading = true;

  late DetailPendingModel detailRequestModel;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    try {
      final response =
          await TechnicalRequestsRepo().getChiTietThayDoi(widget.id);
      setState(() {
        detailRequestModel = response;

        isLoading = false;
      });
    } catch (e) {
      debugPrint('Lỗi khi gọi API: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
      appBar: AppBar(
        title: Text(widget.title1),
        centerTitle: true,
        backgroundColor: const Color(0xFF1CA0DD),
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  height: 20.h,
                  width: double.infinity,
                  color: Colors.lightBlue,
                  child: Container(
                    width: double.infinity,
                    height: 20.h,
                    decoration: BoxDecoration(
                      color: const Color(0xffFAFAFA),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.r),
                        topRight: Radius.circular(24.r),
                      ),
                    ),
                  ),
                ),
                _buildRequestInfoCard(),
                //const SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    children: [
                      ResidentInfoForm(
                        data: detailRequestModel,
                      ),
                    ],
                  ),
                ),
                _buildSaveButton(1),
                _buildSaveButton(2),
              ],
            ),
    );
  }

  Widget _buildRequestInfoCard() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title2,
            style: defaultText16M,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              SvgPicture.asset('assets/icons/person_icon.svg'),
              Text(
                widget.title1,
                style: defaultText16M.copyWith(
                  color: const Color(0xff004071),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildSaveButton(int type) {
    return Padding(
      padding: EdgeInsets.only(
        right: 16.w,
        left: 16.w,
        bottom: 16.h,
      ),
      child: ElevatedButton(
        onPressed: () async {
          {
            await TechnicalRequestsRepo().duyetYc(
              id: widget.id,
              statusId: type,
            );
            setState(() {
              isLoading = false;
            });
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Thành công'),
                content: Text(type == 1
                    ? 'Yêu cầu đã được duyệt!'
                    : 'Yêu cầu đã bị từ chối!'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // đóng dialog
                      Navigator.pop(context); // đóng luôn màn hiện tại
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor:
              type == 1 ? const Color(0xFF1CA0DD) : const Color(0xffE22D2D),
          foregroundColor: Colors.white,
          disabledBackgroundColor: Colors.grey.shade300,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Center(
          child: Text(
            type == 1 ? 'Chấp nhận thay đổi' : 'Từ chối yêu cầu',
            style: defaultText14B.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

// Widget _buildImageContent(String content) {
//   List<String> imageUrls = List<String>.from(json.decode(content));
//   if (imageUrls.isEmpty) {
//     return const SizedBox();
//   } else if (imageUrls.length == 1) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(12),
//       child: Image.network(
//         imageUrls[0],
//         fit: BoxFit.cover,
//         errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
//       ),
//     );
//   }

//   return GridView.builder(
//     shrinkWrap: true,
//     physics: const NeverScrollableScrollPhysics(),
//     itemCount: imageUrls.length,
//     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//       crossAxisCount: 2, // hoặc 3 tùy bố cục bạn muốn
//       crossAxisSpacing: 8,
//       mainAxisSpacing: 8,
//     ),
//     itemBuilder: (context, index) {
//       return ClipRRect(
//         borderRadius: BorderRadius.circular(8),
//         child: Image.network(
//           imageUrls[index],
//           fit: BoxFit.cover,
//           errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
//         ),
//       );
//     },
//   );
// }

class ResidentInfoForm extends StatelessWidget {
  final DetailPendingModel data;

  const ResidentInfoForm({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildField('Họ và tên', data.fullName),
          _buildField('Số định danh', data.cccdCmt),
          _buildField('Ngày sinh', data.dob),
          _buildField('Số điện thoại', data.phone),
          _buildField('Email', data.email),
          _buildField(
              'Quan hệ với chủ hộ', _mapRelationship(data.relationshipType)),
          SizedBox(height: 24.h),
          Row(
            children: [
              const Icon(Icons.image_outlined, color: Colors.blueAccent),
              SizedBox(width: 8.w),
              Text('Ảnh xác minh thông tin',
                  style: defaultText16B.copyWith(color: Colors.blueAccent)),
            ],
          ),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 12.w,
            runSpacing: 12.h,
            children: data.img.map((url) => _buildImageBox(url)).toList(),
          )
        ],
      ),
    );
  }

  Widget _buildField(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: defaultText14M),
          SizedBox(height: 8.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(8.r),
              color: Colors.grey.shade100,
            ),
            child: Text(value.isNotEmpty ? value : '-', style: defaultText14),
          )
        ],
      ),
    );
  }

  Widget _buildImageBox(String url) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.r),
      child: Stack(
        children: [
          Image.network(
            url,
            width: 140.w,
            height: 100.h,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              width: 140.w,
              height: 100.h,
              color: Colors.grey.shade300,
              child: const Icon(Icons.broken_image),
            ),
          ),
          Positioned(
            bottom: 4.h,
            right: 4.w,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.circular(4.r),
              ),
              padding: EdgeInsets.all(4.r),
              child:
                  const Icon(Icons.fullscreen, color: Colors.white, size: 16),
            ),
          )
        ],
      ),
    );
  }

  String _mapRelationship(String code) {
    switch (code) {
      case 'chu_ho':
        return 'Chủ hộ';
      case 'vo':
        return 'Vợ';
      case 'chong':
        return 'Chồng';
      case 'con':
        return 'Con';
      default:
        return code;
    }
  }
}

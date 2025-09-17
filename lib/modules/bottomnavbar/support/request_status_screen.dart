import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ha_duong/models/suport_model.dart';
import 'package:ha_duong/utils/constants/styles.dart';
import 'package:intl/intl.dart';

class RequestStatusScreen extends StatelessWidget {
  final List<RequestStatusModel> requestStatus;
  final String createAt;
  final TechnicalSupportModel technicalSupportModel;

  const RequestStatusScreen({
    super.key,
    required this.requestStatus,
    required this.createAt,
    required this.technicalSupportModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Trạng thái yêu cầu', style: defaultText14M),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoSection(),
              Padding(
                padding: EdgeInsets.only(bottom: 16.h, top: 6.h),
                child: Text('Tiến trình xử lý:', style: defaultText14M),
              ),
              if (requestStatus.isNotEmpty)
                ...List.generate(requestStatus.length, (index) {
                  final step = requestStatus[index];
                  return _buildStepItem(step,
                      isLast: index == requestStatus.length - 1);
                })
              else
                _buildStepItem(
                  RequestStatusModel(
                    name: 'Tạo yêu cầu',
                    createAt: DateTime.parse(createAt),
                    type: '0',
                  ),
                  isLast: true,
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// 👉 Gom phần info (Người gửi, Yêu cầu, Tình trạng, Note, Ảnh)
  Widget _buildInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: 'Người gửi : ',
            style: defaultText14M.copyWith(
              color: const Color(0xff8A8A8A).withValues(alpha: 0.8),
            ),
            children: [
              TextSpan(
                text: technicalSupportModel.fullName,
                style: defaultText14M,
              ),
            ],
          ),
        ),
        SizedBox(height: 6.h),
        RichText(
          text: TextSpan(
            text: 'Yêu cầu : ',
            style: defaultText14M.copyWith(
              color: const Color(0xff8A8A8A).withValues(alpha: 0.8),
            ),
            children: [
              TextSpan(
                text: technicalSupportModel.settingSupportName,
                style: defaultText14M,
              ),
            ],
          ),
        ),
        SizedBox(height: 6.h),
        RichText(
          text: TextSpan(
            text: 'Tình trạng : ',
            style: defaultText14M.copyWith(
              color: const Color(0xff8A8A8A).withValues(alpha: 0.8),
            ),
            children: [
              TextSpan(
                text: technicalSupportModel.settingSupportStateName,
                style: defaultText14M,
              ),
            ],
          ),
        ),
        SizedBox(height: 6.h),
        RichText(
          text: TextSpan(
            text: 'Note : ',
            style: defaultText14M.copyWith(
              color: const Color(0xff8A8A8A).withValues(alpha: 0.8),
            ),
            children: [
              TextSpan(
                text: technicalSupportModel.note,
                style: defaultText14M,
              ),
            ],
          ),
        ),
        SizedBox(height: 6.h),
        _buildImageContent(technicalSupportModel.img),
      ],
    );
  }

  Widget _buildStepItem(RequestStatusModel step, {bool isLast = false}) {
    return SizedBox(
      height: (step.img != null && step.img!.isNotEmpty && step.img != '[]')
          ? 160.h
          : 45.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                DateFormat('dd/MM/yyyy').format(step.createAt),
                style: defaultText12.copyWith(color: const Color(0xff8A8A8A)),
              ),
              const SizedBox(height: 4),
              Text(
                DateFormat('HH:mm').format(step.createAt),
                style: defaultText12.copyWith(color: const Color(0xff8A8A8A)),
              ),
            ],
          ),
          const SizedBox(width: 12),
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 4.h, bottom: 2.h),
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: step.type == '0'
                      ? const Color(0xff004071)
                      : step.type == '1'
                          ? const Color(0xff129F20)
                          : const Color(0xffE80707),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.done, size: 12, color: Colors.white),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 1,
                    color: step.type == '0'
                        ? const Color(0xff004071)
                        : step.type == '1'
                            ? const Color(0xff129F20)
                            : const Color(0xffE80707),
                  ),
                ),
            ],
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(
                    step.name,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: step.type == '0'
                          ? const Color(0xff004071)
                          : step.type == '1'
                              ? const Color(0xff129F20)
                              : const Color(0xffE80707),
                      fontWeight:
                          step.type == '0' ? FontWeight.w500 : FontWeight.bold,
                    ),
                  ),
                  (step.img != null && step.img!.isNotEmpty && step.img != '[]')
                      ? SizedBox(
                          height: 125.h, child: _buildImageContent(step.img!))
                      : SizedBox(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildImageContent(String content) {
  List<String> imageUrls = List<String>.from(json.decode(content));

  if (imageUrls.isEmpty) {
    return const SizedBox();
  } else if (imageUrls.length == 1) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          imageUrls[0],
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
        ),
      ),
    );
  }

  return Padding(
    padding: EdgeInsets.only(top: 8.h),
    child: GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), // 🔑 fix lỗi
      itemCount: imageUrls.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            imageUrls[index],
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.error),
          ),
        );
      },
    ),
  );
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ha_duong/models/suport_model.dart';
import 'package:ha_duong/utils/constants/styles.dart';

class RequestStatusScreen extends StatelessWidget {
  final List<RequestStatusModel> requestStatus;
  final String createAt;
  final TechnicalSupportModel technicalSupportModel;
  const RequestStatusScreen(
      {super.key,
      required this.requestStatus,
      required this.createAt,
      required this.technicalSupportModel});

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
        title: Text(
          'Trạng thái yêu cầu',
          style: defaultText14M,
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
            SizedBox(
              height: 4.h,
            ),
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
            SizedBox(
              height: 4.h,
            ),
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
            SizedBox(
              height: 4.h,
            ),
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
            SizedBox(
              height: 4.h,
            ),
            _buildImageContent(technicalSupportModel.img),
            Padding(
              padding: EdgeInsets.only(bottom: 16.h, top: 6.h),
              child: Text(
                'Tiến trình xử lý:',
                style: defaultText14M,
              ),
            ),
            ...requestStatus.isNotEmpty
                ? List.generate(requestStatus.length, (index) {
                    final step = requestStatus[index];
                    return _buildStepItem(step,
                        isLast: index == requestStatus.length - 1);
                  })
                : [
                    _buildStepItem(
                      RequestStatusModel(
                        name: 'Tạo yêu cầu',
                        createAt: createAt,
                        type: '1',
                      ),
                      isLast: true,
                    ),
                  ],
          ]),
        ),
        //  Column(
        //   children: List.generate(requestStatus.length, (index) {
        //     final step = requestStatus[index];
        //     return _buildStepItem(step,
        //         isLast: index == requestStatus.length - 1);
        //   }),
        // ),
      ),
    );
  }

  Widget _buildStepItem(RequestStatusModel step, {bool isLast = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: 12),
        Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 4),
              width: 16,
              height: 16,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.done, size: 12, color: Colors.white),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                color: Colors.grey.shade300,
              ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step.createAt,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  step.name,
                  style: TextStyle(
                    color: step.type == '0' ? (Colors.black) : Colors.grey,
                    fontWeight:
                        step.type == '0' ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class StatusStep {
  final String title;
  final String time;
  final bool isCurrent;
  final bool isError;

  StatusStep(this.title, this.time,
      {this.isCurrent = false, this.isError = false});
}

Widget _buildImageContent(String content) {
  List<String> imageUrls = List<String>.from(json.decode(content));
  if (imageUrls.isEmpty) {
    return const SizedBox();
  } else if (imageUrls.length == 1) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        imageUrls[0],
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
      ),
    );
  }

  return GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: imageUrls.length,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2, // hoặc 3 tùy bố cục bạn muốn
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
    ),
    itemBuilder: (context, index) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          imageUrls[index],
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
        ),
      );
    },
  );
}

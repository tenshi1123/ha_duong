import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ha_duong/models/suport_model.dart';
import 'package:ha_duong/utils/constants/styles.dart';

class RequestStatusScreen extends StatelessWidget {
  final List<RequestStatusModel> requestStatus;
  const RequestStatusScreen({super.key, required this.requestStatus});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffD9D9D9),
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
        child: Column(
          children: requestStatus.isNotEmpty
              ? List.generate(requestStatus.length, (index) {
                  final step = requestStatus[index];
                  return _buildStepItem(step,
                      isLast: index == requestStatus.length - 1);
                })
              : [
                  _buildStepItem(
                    RequestStatusModel(
                      name: 'Chưa tiếp nhận',
                      createAt: '',
                      type: '1',
                    ),
                    isLast: true,
                  ),
                ],
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
              decoration: BoxDecoration(
                color: step.type == '0' ? (Colors.blue) : Colors.grey.shade300,
                shape: BoxShape.circle,
              ),
              child: step.type == '0'
                  ? const Icon(Icons.done, size: 12, color: Colors.white)
                  : null,
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

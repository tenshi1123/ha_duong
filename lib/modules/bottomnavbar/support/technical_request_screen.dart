import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ha_duong/models/suport_model.dart';
import 'package:ha_duong/repo/support_repo.dart';
import 'package:ha_duong/utils/constants/styles.dart';

class TechnicalRequestScreen extends StatefulWidget {
  const TechnicalRequestScreen({super.key, required this.model});
  final FullRequestModel model;
  @override
  State<TechnicalRequestScreen> createState() => _TechnicalRequestScreenState();
}

class _TechnicalRequestScreenState extends State<TechnicalRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _apartmentController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  SettingSupportState? selectedStatus;

  late List<SettingSupportState> statuses;
  @override
  void initState() {
    super.initState();
    // Initialize selectedStatus with the first item
    _contactController.text = widget.model.request.fullName;
    _phoneController.text = widget.model.request.phone;
    _apartmentController.text = widget.model.request.apartmentName;
    statuses = widget.model.settingSupportStates;
    selectedStatus = statuses[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffD9D9D9),
      appBar: AppBar(
        title: const Text('Yêu cầu kỹ thuật'),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    Expanded(
                      child: Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              buildSection(
                                icon: Icons.sync,
                                title: 'Tình trạng',
                                child: DropdownButtonFormField<
                                    SettingSupportState>(
                                  decoration: const InputDecoration(
                                    labelText: 'Tình trạng',
                                    border: OutlineInputBorder(),
                                  ),
                                  value: selectedStatus,
                                  items: statuses
                                      .map((status) => DropdownMenuItem(
                                            value: status,
                                            child: Text(status.name),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedStatus = value;
                                    });
                                  },
                                  validator: (value) => value == null
                                      ? 'Vui lòng chọn tình trạng'
                                      : null,
                                ),
                              ),
                              const SizedBox(height: 16),
                              buildSection(
                                icon: Icons.person_outline,
                                title: 'Thông tin khách hàng',
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: _contactController,
                                      decoration: const InputDecoration(
                                        labelText: 'Người liên hệ *',
                                        border: OutlineInputBorder(),
                                      ),
                                      validator: (value) =>
                                          value == null || value.isEmpty
                                              ? 'Bắt buộc nhập'
                                              : null,
                                    ),
                                    const SizedBox(height: 12),
                                    TextFormField(
                                      controller: _phoneController,
                                      decoration: const InputDecoration(
                                        labelText: 'Số điện thoại *',
                                        border: OutlineInputBorder(),
                                      ),
                                      keyboardType: TextInputType.phone,
                                      validator: (value) =>
                                          value == null || value.isEmpty
                                              ? 'Bắt buộc nhập'
                                              : null,
                                    ),
                                    const SizedBox(height: 12),
                                    TextFormField(
                                      controller: _apartmentController,
                                      decoration: const InputDecoration(
                                        labelText: 'Căn hộ *',
                                        border: OutlineInputBorder(),
                                      ),
                                      validator: (value) =>
                                          value == null || value.isEmpty
                                              ? 'Bắt buộc nhập'
                                              : null,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              buildSection(
                                icon: Icons.edit_note_outlined,
                                title: 'Ghi chú',
                                child: TextFormField(
                                  controller: _noteController,
                                  maxLines: 4,
                                  decoration: const InputDecoration(
                                    hintText: 'Nhập ghi chú',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Nút Gửi Yêu Cầu
                    Container(
                      width: double.infinity,
                      height: 98.h,
                      padding: EdgeInsets.only(
                        left: 16.w,
                        right: 16.w,
                        bottom: 32.h,
                        top: 16.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, -2),
                          ),
                        ],
                      ),
                      child: GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            // Xử lý gửi yêu cầu
                            bool success = await SupportRepo().createRequest(
                              apartmentId: widget.model.request.apartmentId,
                              settingSupportId:
                                  widget.model.request.settingSupportId,
                              settingSupportStateId:
                                  selectedStatus!.id.toString(),
                              fullName: _contactController.text,
                              phone: _phoneController.text,
                              note: _noteController.text,
                            );
                            if (success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Yêu cầu đã được gửi!')),
                              );
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Gửi yêu cầu thất bại!')),
                              );
                            }
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xff25AAE1),
                                  Color(0xff004071),
                                ]),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text('Gửi yêu cầu',
                                style: defaultText14B.copyWith(
                                  color: Colors.white,
                                )),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildSection(
      {required IconData icon, required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.blue),
              const SizedBox(width: 8),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

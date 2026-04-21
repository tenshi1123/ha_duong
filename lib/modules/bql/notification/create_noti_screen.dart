import 'dart:io';

import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ha_duong/bql_model/home_model.dart';
import 'package:ha_duong/bql_repo/bql_home_repo.dart';
import 'package:ha_duong/bql_repo/notification_repo.dart';
import 'package:ha_duong/modules/bottomnavbar/info/personal_screen.dart';
import 'package:ha_duong/utils/constants/styles.dart';

import 'package:image_picker/image_picker.dart';

class TaoThongBaoScreen extends StatefulWidget {
  const TaoThongBaoScreen(
      {super.key, required this.buildingId, required this.buildingName});
  final String buildingId;
  final String buildingName;
  @override
  _TaoThongBaoScreenState createState() => _TaoThongBaoScreenState();
}

class _TaoThongBaoScreenState extends State<TaoThongBaoScreen> {
  final _formKey = GlobalKey<FormState>();

  String? selectedLoaiThongBao;
  final List<String> loaiThongBaoList = [
    "Ban quản lý",
    "Thanh toán",
    "Xử lý phản ánh",
  ];

  final TextEditingController tieuDeController = TextEditingController();
  final TextEditingController noiDungController = TextEditingController();
  //final List<String> allItems = List.generate(40, (i) => 'Item ${i + 1}');
  final List<ApartmentModel> selected = [];
  final ValueNotifier<String> _sendOption = ValueNotifier('all');
  List<ApartmentModel> apartments = [];
  List<File> photos = <File>[];
  Future<void> getListApartment() async {
    try {
      final response = await HomeRepo().getListApartment(
        page: 1,
        show: 1000,
        buildingId: int.tryParse(widget.buildingId) ?? 0,
        status: null,
        purposeUseId: null,
      );
      setState(() {
        apartments = response;
      });
    } catch (e) {
      debugPrint('Lỗi khi gọi API: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getListApartment();
  }

  void openCamera() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CameraCamera(
          onFile: (file) {
            photos.add(file);

            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CupertinoAlertDialog(
                  title: const Text('Chụp ảnh thành công'),
                  actions: <Widget>[
                    CupertinoDialogAction(
                      isDefaultAction: true,
                      child: Text(
                        'ok',
                        style: defaultText20B,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    )
                  ],
                );
              },
            );
            setState(() {});
          },
        ),
      ),
    );
  }

  // Tải ảnh lên từ thư viện
  Future _pickImageFromGallery() async {
    final returnedImage = await ImagePicker().pickMultiImage();
    photos.addAll(returnedImage.map((e) => File(e.path)));
    //File(returnedImage!.path);
    if (photos.isNotEmpty) {}
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF25AAE1),
        elevation: 0,
        title: const Text(
          'Tạo thông báo mới',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tên tòa nhà
                Text(
                  widget.buildingName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 16.h),
                // Dropdown loại thông báo
                DropdownButtonFormField<String>(
                  decoration: _inputDecoration("Chọn loại thông báo"),
                  value: selectedLoaiThongBao,
                  items: loaiThongBaoList.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedLoaiThongBao = value;
                    });
                  },
                  validator: (value) =>
                      value == null ? "Vui lòng chọn loại thông báo" : null,
                ),
                SizedBox(height: 20.h),
                SendOptionButtons(selectedOption: _sendOption),
                const SizedBox(height: 20),
                //Chọn tòa nhà
                ValueListenableBuilder<String>(
                  valueListenable: _sendOption,
                  builder: (context, value, _) {
                    return Column(
                      children: [
                        if (selected.isNotEmpty && value == 'single') ...[
                          Wrap(
                            spacing: 8,
                            runSpacing: 6,
                            children: selected
                                .map((s) => Chip(
                                      label: Text(s.name),
                                      onDeleted: () {
                                        setState(() => selected.remove(s));
                                      },
                                    ))
                                .toList(),
                          ),
                          const SizedBox(height: 12),
                        ],

                        // The custom widget
                        _sendOption.value == 'all'
                            ? Text(
                                'Gửi đến tất cả căn hộ',
                                style: defaultText16B,
                              )
                            : MultiSelectSearchDropdown<ApartmentModel>(
                                items: apartments,
                                itemLabel: (s) => s.name,
                                initiallySelected: selected,
                                hintText: 'Chọn tòa nhà',
                                onSelectionChanged: (newSelected) {
                                  // Will be called whenever user saves selection from picker
                                  setState(() {
                                    selected
                                      ..clear()
                                      ..addAll(newSelected);
                                  });
                                },
                              ),
                      ],
                    );
                  },
                ),

                SizedBox(height: 20.h),
                // Tiêu đề
                RichText(
                  text: const TextSpan(
                    text: 'Tiêu đề',
                    style: TextStyle(color: Colors.black, fontSize: 14),
                    children: [
                      TextSpan(
                        text: ' *',
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.h),
                TextFormField(
                  controller: tieuDeController,
                  decoration: _inputDecoration("Nhập tiêu đề của thông báo"),
                  validator: (value) => value == null || value.isEmpty
                      ? "Vui lòng nhập tiêu đề"
                      : null,
                ),
                SizedBox(height: 20.h),

                // Nội dung
                RichText(
                  text: const TextSpan(
                    text: 'Nội dung thông báo',
                    style: TextStyle(color: Colors.black, fontSize: 14),
                    children: [
                      TextSpan(
                        text: ' *',
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.h),
                TextFormField(
                  controller: noiDungController,
                  maxLines: 6,
                  decoration: _inputDecoration("Nhập tiêu nội dung"),
                  validator: (value) => value == null || value.isEmpty
                      ? "Vui lòng nhập nội dung"
                      : null,
                ),
                SizedBox(height: 12.h),
                ...photos.asMap().entries.map((entry) {
                  int index = entry.key;
                  File photo = entry.value;

                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            photo,
                            width: double.infinity,
                            height: 200.h,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                photos.removeAt(index);
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.all(4),
                              child: const Icon(
                                Icons.remove,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        side: BorderSide(color: Colors.blue.shade100),
                      ),
                    ),
                    child: const Text('Thêm hình ảnh'),
                    onPressed: () {
                      showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => Dialog(
                                child: Container(
                                  height: 166.h,
                                  width: 343.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20.r),
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // Nút Tải ảnh lên
                                        buildUploadOption(
                                          icon: Icons.image_outlined,
                                          text: "Tải ảnh lên",
                                          onTap: () {
                                            // Xử lý tải ảnh lên
                                            _pickImageFromGallery();
                                          },
                                        ),
                                        SizedBox(
                                            width: 56
                                                .w), // Khoảng cách giữa hai nút
                                        // Nút Chụp ảnh
                                        buildUploadOption(
                                          icon: Icons.camera_alt_outlined,
                                          text: "Chụp ảnh",
                                          onTap: () {
                                            // Xử lý chụp ảnh
                                            openCamera();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ));
                    },
                  ),
                ),
                SizedBox(height: 16.h),
                // Gửi thông báo
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Gửi dữ liệu ở đây
                        NotificationRepo().pushNotification(
                          apartmentIds: _sendOption.value == 'all'
                              ? null
                              : selected
                                  .map((e) => int.tryParse(e.id) ?? 0)
                                  .toList(),
                          buildingId: widget.buildingId,
                          title: tieuDeController.text,
                          content: noiDungController.text,
                          type: loaiThongBaoList
                              .indexOf(selectedLoaiThongBao ?? ''),
                          file: photos.isNotEmpty ? photos.first : null,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Đã gửi thông báo")),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF25AAE1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Gửi thông báo",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF25AAE1)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF25AAE1)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF25AAE1), width: 2),
      ),
    );
  }
}

class MultiSelectSearchDropdown<T> extends StatefulWidget {
  final List<T> items;
  final List<T>? initiallySelected;
  final String hintText;
  final ValueChanged<List<T>>? onSelectionChanged;
  final String Function(T) itemLabel;

  const MultiSelectSearchDropdown({
    super.key,
    required this.items,
    required this.itemLabel,
    this.initiallySelected,
    this.hintText = 'Select...',
    this.onSelectionChanged,
  });

  @override
  State<MultiSelectSearchDropdown<T>> createState() =>
      _MultiSelectSearchDropdownState<T>();
}

class _MultiSelectSearchDropdownState<T>
    extends State<MultiSelectSearchDropdown<T>> {
  late List<T> _selected;
  String _previewText() {
    if (_selected.isEmpty) return widget.hintText;
    if (_selected.length == 1) return widget.itemLabel(_selected.first);
    return '${_selected.length} đã chọn';
  }

  @override
  void initState() {
    super.initState();
    _selected = List<T>.from(widget.initiallySelected ?? []);
  }

  Future<void> _openPicker() async {
    final result = await showDialog<List<T>>(
      context: context,
      builder: (context) {
        return _MultiSelectDialog<T>(
          items: widget.items,
          initiallySelected: _selected,
          itemLabel: widget.itemLabel,
        );
      },
    );

    if (result != null) {
      setState(() => _selected = result);
      widget.onSelectionChanged?.call(_selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _openPicker,
      child: AbsorbPointer(
        child: TextFormField(
          decoration: InputDecoration(
            labelText: widget.hintText,
            hintText: widget.hintText,
            suffixIcon: const Icon(Icons.arrow_drop_down),
            border: const OutlineInputBorder(),
          ),
          controller: TextEditingController(text: _previewText()),
        ),
      ),
    );
  }
}

class _MultiSelectDialog<T> extends StatefulWidget {
  final List<T> items;
  final List<T> initiallySelected;
  final String Function(T) itemLabel;

  const _MultiSelectDialog({
    required this.items,
    required this.initiallySelected,
    required this.itemLabel,
  });

  @override
  State<_MultiSelectDialog<T>> createState() => _MultiSelectDialogState<T>();
}

class _MultiSelectDialogState<T> extends State<_MultiSelectDialog<T>> {
  late List<T> _tempSelected;
  late List<T> _filteredItems;

  @override
  void initState() {
    super.initState();
    _tempSelected = List<T>.from(widget.initiallySelected);
    _filteredItems = List<T>.from(widget.items);
  }

  void _onSearchChanged(String q) {
    setState(() {
      final lower = q.toLowerCase();
      _filteredItems = widget.items
          .where((e) => widget.itemLabel(e).toLowerCase().contains(lower))
          .toList();
    });
  }

  void _toggleItem(T item) {
    setState(() {
      if (_tempSelected.contains(item)) {
        _tempSelected.remove(item);
      } else {
        _tempSelected.add(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Chọn mục'),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Tìm kiếm...',
              ),
              onChanged: _onSearchChanged,
            ),
            const SizedBox(height: 12),
            Expanded(
              child: _filteredItems.isEmpty
                  ? const Center(child: Text('Không có kết quả'))
                  : Scrollbar(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _filteredItems.length,
                        itemBuilder: (context, index) {
                          final item = _filteredItems[index];
                          final label = widget.itemLabel(item);
                          final checked = _tempSelected.contains(item);
                          return CheckboxListTile(
                            value: checked,
                            title: Text(label),
                            controlAffinity: ListTileControlAffinity.leading,
                            onChanged: (_) => _toggleItem(item),
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context), child: const Text('Hủy')),
        TextButton(
          onPressed: () => Navigator.pop(context, _tempSelected),
          child: const Text('Lưu'),
        ),
      ],
    );
  }
}

class SendOptionButtons extends StatelessWidget {
  final ValueNotifier<String> selectedOption; // 'all' hoặc 'single'

  const SendOptionButtons({
    super.key,
    required this.selectedOption,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: selectedOption,
      builder: (context, value, _) {
        return Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => selectedOption.value = 'all',
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      value == 'all' ? Colors.blue : Colors.grey.shade100,
                  foregroundColor:
                      value == 'all' ? Colors.white : Colors.black87,
                ),
                child: const Text('Gửi tất cả'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () => selectedOption.value = 'single',
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      value == 'single' ? Colors.blue : Colors.grey.shade100,
                  foregroundColor:
                      value == 'single' ? Colors.white : Colors.black87,
                ),
                child: const Text('Gửi riêng'),
              ),
            ),
          ],
        );
      },
    );
  }
}

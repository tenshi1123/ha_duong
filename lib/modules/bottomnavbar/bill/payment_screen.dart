import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ha_duong/models/info_model.dart';
import 'package:ha_duong/utils/constants/styles.dart';
import 'package:screenshot/screenshot.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:typed_data'; // Để làm việc với dữ liệu byte
import 'package:gal/gal.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen(
      {super.key,
      required this.paymentInforModel,
      required this.totalFinalFee,
      required this.receiptTime}); // Ví dụ
  final PaymentInforModel paymentInforModel;
  final int totalFinalFee;
  final String receiptTime;
  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  ScreenshotController screenshotController = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    // Encode các thông tin để tránh lỗi URL
    final String encodedApartmentName =
        Uri.encodeComponent(widget.paymentInforModel.apartmentName);
    final String encodedBuildingName =
        Uri.encodeComponent(widget.paymentInforModel.buildingName);
    final String encodedAddInfo =
        '$encodedApartmentName+$encodedBuildingName+${widget.receiptTime}';
    final String encodedAccountName =
        Uri.encodeComponent(widget.paymentInforModel.accName);

    final String qrCodeImageUrl =
        'https://img.vietqr.io/image/${widget.paymentInforModel.bankCode}-${widget.paymentInforModel.accNumber}-compact2.jpg?amount=${widget.totalFinalFee}&addInfo=$encodedAddInfo&accountName=$encodedAccountName';

    final String htmlContent = '''
      <img src="$qrCodeImageUrl" alt="QR Code">
    ''';

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 241, 241),
      appBar: AppBar(
        title: const Text('Thanh toán'),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: const Text(
                'Cư dân vui lòng thanh toán hóa đơn theo mã QR dưới đây:',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Screenshot(
                controller: screenshotController,
                child: Html(
                  data: htmlContent,
                  // Cấu hình thêm nếu cần
                  // onImageTap: (src, _, __) {
                  //   print('Đã click vào hình ảnh: $src');
                  // },
                  // style: {
                  //   "img": Style(
                  //     maxWidth: MediaQuery.of(context).size.width * 0.8,
                  //     height: AutoCSS(), // Hoặc một giá trị cố định
                  //   ),
                  // },
                ),
              ),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              ),
              onPressed: () {
                _captureAndSaveWidget();
              },
              icon: const Icon(
                Icons.download,
                color: Color(0xff004071),
              ),
              label: Text('Chụp và lưu mã QR', style: defaultText14M),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> ShowCapturedWidget(
      BuildContext context, Uint8List capturedImage) {
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text("Mã Qr đã lưu"),
        ),
        body: Center(child: Image.memory(capturedImage)),
      ),
    );
  }

  // Hàm xử lý việc chụp và lưu ảnh widget
  Future<void> _captureAndSaveWidget() async {
    try {
      // 1. Kiểm tra và yêu cầu quyền bằng gal (nếu cần)
      // gal.hasAccess(toAlbum: false) kiểm tra quyền truy cập thư viện
      // gal.requestAccess(toAlbum: false) yêu cầu quyền. gal sẽ tự xử lý trên Android 10+
      // Nếu bạn muốn lưu vào một album cụ thể, toAlbum: true sẽ yêu cầu quyền đó.
      final bool hasPermission = await Gal.hasAccess(toAlbum: false);
      if (!hasPermission) {
        final bool granted = await Gal.requestAccess(toAlbum: false);
        if (!granted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Quyền truy cập thư viện ảnh bị từ chối.')),
          );
          // Tùy chọn: Mở cài đặt ứng dụng để người dùng cấp quyền thủ công
          if (await Permission.photos.isPermanentlyDenied) {
            // Hoặc Permission.storage
            openAppSettings();
          }
          return;
        }
      }

      // 2. Chụp ảnh widget bằng ScreenshotController.capture(...)
      final Uint8List? byteData = await screenshotController.capture(
        delay: const Duration(milliseconds: 10),
        pixelRatio: MediaQuery.of(context).devicePixelRatio,
      );

      if (byteData != null) {
        // 3. Lưu hình ảnh vào thư viện ảnh bằng gal
        // gal.putImageBytes() là cách trực tiếp để lưu dữ liệu byte
        await Gal.putImageBytes(
          byteData,
          name:
              "VietQR_Screenshot_${DateTime.now().millisecondsSinceEpoch}", // Tên file tùy chọn
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Đã lưu ảnh mã QR vào thư viện ảnh!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Không thể chụp ảnh widget.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi: $e')),
      );
      print('Lỗi khi chụp hoặc lưu hình ảnh: $e');
    }
  }
}

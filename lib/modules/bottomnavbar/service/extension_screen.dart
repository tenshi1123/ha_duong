import 'package:flutter/material.dart';
import 'package:ha_duong/models/info_model.dart';
import 'package:ha_duong/repo/home_repo.dart';
import '../../../utils/constants/styles.dart';

class ExtensionScreen extends StatefulWidget {
  const ExtensionScreen({super.key, required this.id});
  final String id;
  @override
  State<ExtensionScreen> createState() => _ExtensionScreenState();
}

class _ExtensionScreenState extends State<ExtensionScreen> {
  bool isLoading = true;
  late List<PostModel> listUtilities;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      // Gọi API ở đây - thay thế bằng logic thật của bạn
      final response = await HomeRepo().getUtilities(widget.id);

      // Cập nhật state sau khi có dữ liệu
      setState(() {
        listUtilities = response;
        isLoading = false;
      });
    } catch (e) {
      // Xử lý lỗi nếu cần
      debugPrint('Lỗi khi gọi API: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        //   onPressed: () {},
        // ),
        title: Center(
          child: Text(
            'Dịch vụ tiện ích',
            style: defaultText18B.copyWith(
              color: const Color(0xff3C3C3C),
            ),
          ),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: listUtilities.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 cột
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.2,
        ),
        itemBuilder: (context, index) {
          final item = listUtilities[index];
          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  'https://bms.haduong.com.vn/images/${item.img}',
                  fit: BoxFit.cover,
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black54],
                    ),
                  ),
                  child: Text(
                    item.name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          );
        },
      ),

      //  Column(
      //   children: [
      //     const Divider(),
      //     SizedBox(
      //       height: 16.h,
      //     ),
      //     Row(
      //       children: [
      //         SizedBox(
      //           width: 16.w,
      //         ),
      //         GestureDetector(
      //           onTap: () {
      //             pushWithoutNavBar(
      //               context,
      //               MaterialPageRoute(
      //                 builder: ((context) => const ServiceScreen(
      //                       title: 'Dịch vụ thang máy',
      //                     )),
      //               ),
      //             );
      //           },
      //           child: Image.asset(
      //             'assets/images/image1.png',
      //             width: 164.w,
      //             height: 108.h,
      //             fit: BoxFit.fill,
      //           ),
      //         ),
      //         const Spacer(),
      //         GestureDetector(
      //           onTap: () {
      //             pushWithoutNavBar(
      //               context,
      //               MaterialPageRoute(
      //                 builder: ((context) => const ServiceScreen(
      //                       title: 'Dịch vụ bể bơi',
      //                     )),
      //               ),
      //             );
      //           },
      //           child: Image.asset(
      //             'assets/images/image2.png',
      //             width: 164.w,
      //             height: 108.h,
      //             fit: BoxFit.fill,
      //           ),
      //         ),
      //         SizedBox(
      //           width: 16.w,
      //         ),
      //       ],
      //     ),
      //     SizedBox(
      //       height: 16.h,
      //     ),
      //     Row(
      //       children: [
      //         SizedBox(
      //           width: 16.w,
      //         ),
      //         GestureDetector(
      //           onTap: () {
      //             pushWithoutNavBar(
      //               context,
      //               MaterialPageRoute(
      //                 builder: ((context) => const ServiceScreen(
      //                       title: 'Tìm người giúp việc',
      //                     )),
      //               ),
      //             );
      //           },
      //           child: Image.asset(
      //             'assets/images/image3.png',
      //             width: 164.w,
      //             height: 108.h,
      //             fit: BoxFit.fill,
      //           ),
      //         ),
      //         const Spacer(),
      //         GestureDetector(
      //           onTap: () {
      //             pushWithoutNavBar(
      //               context,
      //               MaterialPageRoute(
      //                 builder: ((context) => const ServiceScreen(
      //                       title: 'Sinh hoạt cộng đồng',
      //                     )),
      //               ),
      //             );
      //           },
      //           child: Image.asset(
      //             'assets/images/image4.png',
      //             width: 164.w,
      //             height: 108.h,
      //             fit: BoxFit.fill,
      //           ),
      //         ),
      //         SizedBox(
      //           width: 16.w,
      //         ),
      //       ],
      //     ),
      //   ],
      // )
    );
  }
}

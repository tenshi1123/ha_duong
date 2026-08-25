import 'package:flutter/material.dart';
import 'package:ha_duong/models/info_model.dart';
import 'package:ha_duong/modules/bottomnavbar/service/service_screen.dart';
import 'package:ha_duong/repo/home_repo.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import '../../../utils/constants/styles.dart';
import 'package:ha_duong/l10n/app_localizations.dart';

class ExtensionScreen extends StatefulWidget {
  const ExtensionScreen({super.key, required this.id});
  final String id;
  @override
  State<ExtensionScreen> createState() => _ExtensionScreenState();
}

class _ExtensionScreenState extends State<ExtensionScreen> {
  bool isLoading = true;
  List<PostModel> listUtilities = [];
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
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
            AppLocalizations.of(context)!.utilityServices,
            style: defaultText18B.copyWith(
              color: const Color(0xff3C3C3C),
            ),
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : listUtilities.isEmpty
              ? Center(child: Text(AppLocalizations.of(context)!.noData,
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                )
              : GridView.builder(
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
                    return GestureDetector(
                      onTap: () async {
                        UtilitiesModel receiptsDetailModel = await HomeRepo()
                            .getUtilitiesDetail(listUtilities[index].id);
                        pushWithoutNavBar(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => ServiceScreen(
                                  apartmentId: widget.id,
                                  utilitiesModel: receiptsDetailModel,
                                )),
                          ),
                        );
                      },
                      child: ClipRRect(
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
                      ),
                    );
                  },
                ),
    );
  }
}

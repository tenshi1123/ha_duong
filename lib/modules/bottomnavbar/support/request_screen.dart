import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ha_duong/models/suport_model.dart';
import 'package:ha_duong/modules/bottomnavbar/support/request_status_screen.dart';
import 'package:ha_duong/repo/support_repo.dart';
import 'package:ha_duong/utils/constants/styles.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key, required this.id});
  final String id;
  @override
  _RequestScreenState createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ListTechnicalSupportModel data;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetchData(widget.id);
    _tabController = TabController(length: 2, vsync: this);
  }

  Future<void> fetchData(String id) async {
    try {
      // Gọi API ở đây - thay thế bằng logic thật của bạn
      final response = await SupportRepo().getListSupport(id);

      // Cập nhật state sau khi có dữ liệu
      setState(() {
        data = response;
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
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffD9D9D9),
      appBar: AppBar(
        title: const Text('Yêu cầu'),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Đang xử lý'),
            Tab(text: 'Hoàn tất'),
          ],
        ),
      ),
      body: (isLoading)
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                ListView.builder(
                  itemCount: data.listDangXuly.length,
                  itemBuilder: (context, index) {
                    return _buildRequestCard(model: data.listDangXuly[index]);
                  },
                ),
                data.listHoanTat.isEmpty
                    ? const Center(child: Text('Không có yêu cầu đã hoàn tất'))
                    : ListView.builder(
                        itemCount: data.listDangXuly.length,
                        itemBuilder: (context, index) {
                          return _buildRequestCard(
                              model: data.listDangXuly[index]);
                        },
                      ),
              ],
            ),
    );
  }

  Widget _buildRequestCard({
    required TechnicalSupportModel model,
  }) {
    return Container(
      width: 343.w,
      height: 198.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      margin: EdgeInsets.only(top: 16.h, right: 16.w, left: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      //height: index == 0 ? 76.h : 60.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Text('Yêu cầu ${model.settingSupportName}',
                  style: defaultText14M),
              const Spacer(),
              Text(model.createAt,
                  style: defaultText14Re.copyWith(
                    color: const Color(0xff8A8A8A),
                  )),
            ],
          ),
          const Divider(
            color: Color(0xffD9D9D9),
            thickness: 1,
          ),
          Text('Tình trạng',
              style: defaultText14M.copyWith(color: const Color(0xff8A8A8A))),
          Text(
            model.settingSupportStateName,
            style: defaultText14M,
          ),
          const Divider(
            color: Color(0xffD9D9D9),
            thickness: 1,
          ),
          InkWell(
            onTap: () async {
              List<RequestStatusModel> requestStatus =
                  await SupportRepo().getRequestStatus(model.id);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => RequestStatusScreen(
                        requestStatus: requestStatus,
                        createAt: model.createAt,
                        technicalSupportModel: model,
                      )),
                ),
              );
            },
            child: Row(
              children: [
                Column(
                  children: [
                    Text('Trạng thái',
                        style: defaultText14M.copyWith(
                            color: const Color(0xff8A8A8A))),
                    Container(
                      // width: 20.w,
                      // height: 20.h,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        // common color
                        color: const Color(0xff005DA4),

                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                          model.latestStatusName ??
                              model.settingSupportStateName,
                          style: defaultText14M.copyWith(
                            color: Colors.white,
                          )),
                    ),
                  ],
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: const Color(0xff383838),
                  size: 16.w,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

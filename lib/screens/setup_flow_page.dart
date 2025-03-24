import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import 'setup_page_content.dart';
import 'crops_setup_content.dart';
import 'sensors_setup_content.dart';
import 'review_farm_content.dart';
import 'dashboard.dart';

class SetupFlowPage extends StatefulWidget {
  const SetupFlowPage({super.key});

  // 静态方法用于外部调用
  static void resetToFirstPage(BuildContext context, {Map<String, dynamic>? farmData}) {
    print("SetupFlowPage.resetToFirstPage被调用，farmData: $farmData");
    final state = context.findAncestorStateOfType<_SetupFlowPageState>();
    if (state != null) {
      print("找到了SetupFlowPageState");
      state._resetToFirstPage(farmData: farmData);
    } else {
      print("没有找到SetupFlowPageState");
    }
  }

  @override
  State<SetupFlowPage> createState() => _SetupFlowPageState();
}

class _SetupFlowPageState extends State<SetupFlowPage> {
  final PageController _pageController = PageController(initialPage: 0);
  double _progress = 0.25; // 默认第一页，进度为1/4
  int _currentPage = 0;
  Map<String, dynamic>? _currentFarmData;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _updateProgress(double progress) {
    setState(() {
      _progress = progress;
    });
  }

  void _goToNextPage() {
    if (_currentPage < 3) { // 0-3，共4页
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // 完成设置，导航到主页
      Navigator.pushNamedAndRemoveUntil(
        context, 
        '/home', 
        (route) => false
      );
    }
  }

  void _goToPreviousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _handleComplete() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const Dashboard(),
      ),
      (route) => false, // 这会清除导航堆栈中的所有路由
    );
  }

  // 提供一个内部方法供静态方法调用
  void _resetToFirstPage({Map<String, dynamic>? farmData}) {
    setState(() {
      _currentFarmData = farmData;
    });
    
    // 返回到第一页
    _pageController.animateToPage(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    
    return WillPopScope(
      onWillPop: () async {
        if (_currentPage > 0) {
          _goToPreviousPage();
          return false;
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        appBar: const CustomAppBar(title: 'Farm Setup'),
        body: SafeArea(
          child: Column(
            children: [
              // 主要内容区域
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(), // 禁止滑动翻页
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                      _updateProgress((page + 1) / 4); // 更新进度
                    });
                  },
                  children: [
                    // 将农场数据传递给SetupPageContent
                    SetupPageContent(farmData: _currentFarmData),
                    const CropsSetupContent(),
                    const SensorsSetupContent(),
                    const ReviewFarmContent(),
                  ],
                ),
              ),
              
              // 底部固定区域 - 包含进度条和按钮
              Container(
                padding: EdgeInsets.fromLTRB(
                  deviceSize.width * 0.06, 
                  12, 
                  deviceSize.width * 0.06, 
                  16
                ),
                decoration: const BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x0F000000),
                      blurRadius: 4,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 进度条
                    Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE2E8F0),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Row(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                            width: MediaQuery.of(context).size.width * _progress * 0.88,
                            decoration: BoxDecoration(
                              color: const Color(0xFF4ADE80),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // 按钮区域 - 根据页面显示不同按钮
                    if (_currentPage == 0)
                      // 第一页: 只有继续按钮
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _goToNextPage,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4ADE80),
                            foregroundColor: Colors.black,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text(
                            'Continue',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )
                    else if (_currentPage < 3)
                      // 中间页面: 返回和继续按钮
                      Row(
                        children: [
                          // 返回按钮
                          Expanded(
                            flex: 1,
                            child: OutlinedButton(
                              onPressed: _goToPreviousPage,
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.black,
                                side: const BorderSide(color: Color(0xFFE2E8F0)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 16),
                              ),
                              child: const Text(
                                'Back',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF718096),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          // 继续按钮
                          Expanded(
                            flex: 2,
                            child: ElevatedButton(
                              onPressed: _goToNextPage,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4ADE80),
                                foregroundColor: Colors.black,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 16),
                              ),
                              child: const Text(
                                'Continue',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    else
                      // 最后一页: 返回和完成按钮
                      Row(
                        children: [
                          // 返回按钮
                          Expanded(
                            flex: 1,
                            child: OutlinedButton(
                              onPressed: _goToPreviousPage,
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.black,
                                side: const BorderSide(color: Color(0xFFE2E8F0)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 16),
                              ),
                              child: const Text(
                                'Back',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF718096),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          // 完成按钮
                          Expanded(
                            flex: 2,
                            child: ElevatedButton(
                              onPressed: _handleComplete,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4ADE80),
                                foregroundColor: Colors.black,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 16),
                              ),
                              child: const Text(
                                'Complete',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 
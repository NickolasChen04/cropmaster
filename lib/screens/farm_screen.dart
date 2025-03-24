import 'package:flutter/material.dart';
import '../widgets/farm_details_card.dart';
import '../widgets/soil_dashboard.dart';
import '../widgets/task_card.dart';
import '../widgets/ai_recommendations_card.dart';

class FarmScreen extends StatefulWidget {
  const FarmScreen({super.key});

  @override
  State<FarmScreen> createState() => _FarmScreenState();
}

class _FarmScreenState extends State<FarmScreen> {
  // 添加状态变量以跟踪所选任务类型
  String _selectedTaskType = 'Harvest';
  IconData _selectedTaskIcon = Icons.grass;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FARM C"),
      ),
      body: Stack(
        children: [
          // 背景图片
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/farm_background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // 半透明白色覆盖层
          Container(
            color: Colors.white.withOpacity(0.5), 
          ),
          // 主要内容
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 农场详情卡片
                    const FarmDetailsCard(),
                    const SizedBox(height: 20),
                    
                    // 土壤仪表板部分
                    const SoilDashboard(),
                    const SizedBox(height: 20),
                    
                    // 今日任务卡片
                    TaskCard(
                      selectedTaskType: _selectedTaskType,
                      selectedTaskIcon: _selectedTaskIcon,
                      onTaskTypeSelected: (String type, IconData icon) {
                        setState(() {
                          _selectedTaskType = type;
                          _selectedTaskIcon = icon;
                        });
                      },
                    ),
                    const SizedBox(height: 20),

                    // AI推荐卡片
                    const AIRecommendationsCard(),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
} 
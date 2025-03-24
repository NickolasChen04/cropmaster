import 'package:flutter/material.dart';
import 'setup_flow_page.dart'; // 导入SetupFlowPage

class ReviewFarmContent extends StatefulWidget {
  const ReviewFarmContent({super.key});

  @override
  State<ReviewFarmContent> createState() => _ReviewFarmContentState();
}

class _ReviewFarmContentState extends State<ReviewFarmContent> {
  // 添加作物图标和颜色映射
  final Map<String, Map<String, dynamic>> cropIcons = {
    'corn': {
      'icon': Icons.grass,
      'color': Colors.amber,
      'image': 'assets/images/corn.png'
    },
    'wheat': {
      'icon': Icons.agriculture,
      'color': Colors.orange,
      'image': 'assets/images/wheat.png'
    },
    'apple': {
      'icon': Icons.spa,
      'color': Colors.red,
      'image': 'assets/images/apple.png'
    },
    'soybeans': {
      'icon': Icons.eco,
      'color': Colors.green,
      'image': 'assets/images/soybeans.png'
    },
  };

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: deviceSize.width * 0.06),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          // 标题和进度指示器
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Review your farms',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3748),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDF8F1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  '4/4',
                  style: TextStyle(
                    color: Color(0xFF4ADE80),
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text(
            'Add if you have multiple farms',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF718096),
            ),
          ),
          const SizedBox(height: 24),
          
          // 农场卡片 - 点击进行编辑
          GestureDetector(
            onTap: () => _editFarm(context, 'FARM A'),
            child: _buildFarmCard(
              farmName: 'FARM A',
              crop: 'corn',
              acres: '20 acres',
            ),
          ),
          
          const SizedBox(height: 16),
          
          // 农场卡片 - 点击进行编辑
          GestureDetector(
            onTap: () => _editFarm(context, 'FARM B'),
            child: _buildFarmCard(
              farmName: 'FARM B',
              crop: 'apple',
              acres: '',
            ),
          ),
          
          const SizedBox(height: 16),
          
          // 添加按钮 - 点击添加新农场
          GestureDetector(
            onTap: () => _addNewFarm(context),
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: const Center(
                child: Icon(
                  Icons.add,
                  color: Color(0xFFCBD5E0),
                  size: 32,
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 40),
        ],
      ),
    );
  }
  
  // 编辑现有农场
  void _editFarm(BuildContext context, String farmName) {
    // 显示确认对话框
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('Edit $farmName'),
        content: const Text('Are you sure you want to edit this farm? This will navigate to the setup page.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              
              // 显示SnackBar提示
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Editing $farmName')),
              );
              
              // 调用SetupFlowPage的静态方法，重置到第一页
              SetupFlowPage.resetToFirstPage(context);
            },
            child: const Text('Edit'),
          ),
        ],
      ),
    );
  }
  
  // 添加新农场
  void _addNewFarm(BuildContext context) {
    // 显示确认对话框
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Add New Farm'),
        content: const Text('Are you sure you want to add a new farm? This will navigate to the setup page.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              
              // 显示SnackBar提示
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Adding new farm')),
              );
              
              // 调用SetupFlowPage的静态方法，重置到第一页
              SetupFlowPage.resetToFirstPage(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
  
  // 构建农场卡片
  Widget _buildFarmCard({
    required String farmName,
    required String crop,
    required String acres,
  }) {
    Map<String, dynamic> cropInfo = cropIcons[crop] ?? {
      'icon': Icons.grass, 
      'color': Colors.grey,
      'image': 'assets/images/other_crop.png'
    };
    
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          // 作物图片或图标
          Container(
            width: 56,
            height: 56,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: cropInfo['color'].withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: _buildCropImage(cropInfo),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  farmName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF2D3748),
                  ),
                ),
                Text(
                  crop,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF718096),
                  ),
                ),
              ],
            ),
          ),
          if (acres.isNotEmpty)
            Text(
              acres,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF718096),
              ),
            ),
          // 添加一个编辑图标
          const SizedBox(width: 8),
          const Icon(
            Icons.edit_outlined,
            size: 18,
            color: Color(0xFFA0AEC0),
          ),
        ],
      ),
    );
  }
  
  // 构建作物图片或图标
  Widget _buildCropImage(Map<String, dynamic> cropInfo) {
    try {
      // 尝试加载图片
      return Image.asset(
        cropInfo['image'],
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          // 如果图片加载失败，显示图标
          return Icon(
            cropInfo['icon'],
            color: cropInfo['color'],
            size: 32,
          );
        },
      );
    } catch (e) {
      // 如果出现异常，显示图标
      return Icon(
        cropInfo['icon'],
        color: cropInfo['color'],
        size: 32,
      );
    }
  }
} 
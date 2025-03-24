import 'package:flutter/material.dart';

class CropsSetupContent extends StatefulWidget {
  const CropsSetupContent({super.key});

  @override
  State<CropsSetupContent> createState() => _CropsSetupContentState();
}

class _CropsSetupContentState extends State<CropsSetupContent> {
  final TextEditingController _plantingDateController = TextEditingController();
  String? selectedCrop;
  
  // 添加作物图片映射
  final Map<String, Map<String, dynamic>> cropData = {
    'Corn': {
      'icon': Icons.grass,
      'color': Colors.amber,
      'image': 'assets/images/corn.png'
    },
    'Wheat': {
      'icon': Icons.agriculture,
      'color': Colors.orange,
      'image': 'assets/images/wheat.png'
    },
    'Soybeans': {
      'icon': Icons.eco,
      'color': Colors.green,
      'image': 'assets/images/soybeans.png'
    },
    'Cotton': {
      'icon': Icons.spa,
      'color': Colors.lightBlue,
      'image': 'assets/images/cotton.png'
    },
    'Rice': {
      'icon': Icons.grain,
      'color': Colors.brown,
      'image': 'assets/images/rice.png'
    },
    'Other': {
      'icon': Icons.more_horiz,
      'color': Colors.grey,
      'image': 'assets/images/other_crop.png'
    },
  };
  
  List<String> get crops => cropData.keys.toList();
  
  @override
  void dispose() {
    _plantingDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: deviceSize.width * 0.06),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'What are you growing?',
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
                  '2/4',
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
            'Select your primary crops',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF718096),
            ),
          ),
          const SizedBox(height: 24),
          
          // 修改作物网格布局 - 调整大小和比例
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,  // 改为每行3个，而不是2个
            childAspectRatio: 0.85,  // 调整宽高比
            crossAxisSpacing: 10,  // 减小间距
            mainAxisSpacing: 10,  // 减小间距
            children: crops.map((crop) {
              bool isSelected = selectedCrop == crop;
              final cropInfo = cropData[crop]!;
              
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedCrop = crop;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFFEDF8F1) : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected 
                          ? const Color(0xFF4ADE80) 
                          : const Color(0xFFE2E8F0),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 缩小图标区域
                      Expanded(
                        flex: 3,  // 占比调整
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _buildCropImage(cropInfo),
                        ),
                      ),
                      
                      // 底部文字区域
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: isSelected ? cropInfo['color'].withOpacity(0.15) : Colors.transparent,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(11),
                            bottomRight: Radius.circular(11),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 6),  // 减小内边距
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (isSelected)
                              Padding(
                                padding: const EdgeInsets.only(right: 4.0),  // 减小图标间距
                                child: Icon(
                                  Icons.check_circle,
                                  color: const Color(0xFF4ADE80),
                                  size: 12,  // 减小图标大小
                                ),
                              ),
                            Text(
                              crop,
                              style: TextStyle(
                                fontSize: 12,  // 减小字体大小
                                color: isSelected 
                                    ? const Color(0xFF2D3748) 
                                    : const Color(0xFF718096),
                                fontWeight: isSelected 
                                    ? FontWeight.w500 
                                    : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          
          const SizedBox(height: 24),
          
          const Text(
            'Planting date',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF4A5568),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _plantingDateController,
            decoration: InputDecoration(
              hintText: 'dd/mm/yyyy',
              hintStyle: const TextStyle(color: Color(0xFFA0AEC0)),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              suffixIcon: const Icon(
                Icons.calendar_today,
                color: Color(0xFFA0AEC0),
                size: 18,
              ),
            ),
            readOnly: true,
            onTap: () async {
              // 日期选择逻辑
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (picked != null) {
                setState(() {
                  _plantingDateController.text = "${picked.day}/${picked.month}/${picked.year}";
                });
              }
            },
          ),
          
          const SizedBox(height: 40),
        ],
      ),
    );
  }
  
  // 构建作物图片或图标
  Widget _buildCropImage(Map<String, dynamic> cropInfo) {
    try {
      // 尝试加载图片，在实际应用中，使用AssetImage或NetworkImage
      return Icon(
        cropInfo['icon'],
        color: cropInfo['color'],
        size: 32,  // 减小图标大小
      );
      // 注释掉图片加载代码，因为我们还没有实际的图片
      // return Container(
      //   padding: const EdgeInsets.all(4.0),  // 减小内边距
      //   child: Image.asset(
      //     cropInfo['image'],
      //     fit: BoxFit.contain,
      //     errorBuilder: (context, error, stackTrace) {
      //       // 如果图片加载失败，显示图标
      //       return Icon(
      //         cropInfo['icon'],
      //         color: cropInfo['color'],
      //         size: 32,  // 减小图标大小
      //       );
      //     },
      //   ),
      // );
    } catch (e) {
      // 如果出现异常，显示图标
      return Icon(
        cropInfo['icon'],
        color: cropInfo['color'],
        size: 32,  // 减小图标大小
      );
    }
  }
} 
import 'package:flutter/material.dart';
import 'add_farm_page.dart';

class SetupPageContent extends StatefulWidget {
  final Map<String, dynamic>? farmData;
  
  const SetupPageContent({
    super.key,
    this.farmData,
  });

  @override
  State<SetupPageContent> createState() => _SetupPageContentState();
}

class _SetupPageContentState extends State<SetupPageContent> {
  final TextEditingController _farmNameController = TextEditingController();
  final TextEditingController _farmSizeController = TextEditingController();
  final TextEditingController _farmLocationController = TextEditingController();
  bool _isEditing = false;
  String _pageTitle = 'Let\'s set up your farm';
  String _pageSubtitle = 'We need some basic information to get started';

  @override
  void initState() {
    super.initState();
    
    // 检查是否有传入的农场数据
    if (widget.farmData != null) {
      _farmNameController.text = widget.farmData!['name'] ?? '';
      _farmSizeController.text = widget.farmData!['size'] ?? '';
      _isEditing = widget.farmData!['isEditing'] ?? false;
      
      // 如果是编辑模式，更新标题和副标题
      if (_isEditing) {
        _pageTitle = 'Edit your farm';
        _pageSubtitle = 'Update your farm information';
      }
    }
  }

  @override
  void dispose() {
    _farmNameController.dispose();
    _farmSizeController.dispose();
    _farmLocationController.dispose();
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
          // 标题和进度指示器
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _pageTitle,
                style: const TextStyle(
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
                child: Text(
                  '1/4',
                  style: const TextStyle(
                    color: Color(0xFF4ADE80),
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            _pageSubtitle,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF718096),
            ),
          ),
          const SizedBox(height: 24),
          
          // 农场名称输入
          const Text(
            'Farm name',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF4A5568),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _farmNameController,
            decoration: InputDecoration(
              hintText: 'e.g. Farm A',
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
            ),
          ),
          const SizedBox(height: 16),
          
          // 农场大小输入
          const Text(
            'Farm size (acres)',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF4A5568),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _farmSizeController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'e.g. 20',
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
            ),
          ),
          const SizedBox(height: 16),
          
          // 农场位置输入
          const Text(
            'Farm location',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF4A5568),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _farmLocationController,
            decoration: InputDecoration(
              hintText: 'search location or use current',
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
              suffixIcon: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddFarmPage()),
                  );
                },
                child: const Icon(
                  Icons.my_location_outlined,
                  color: Color(0xFFA0AEC0),
                ),
              ),
            ),
          ),
          
          // 添加底部空间，以免内容被底部区域遮挡
          const SizedBox(height: 40),
        ],
      ),
    );
  }
} 
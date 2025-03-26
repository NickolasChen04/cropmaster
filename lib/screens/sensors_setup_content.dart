import 'package:flutter/material.dart';

class SensorsSetupContent extends StatefulWidget {
  const SensorsSetupContent({super.key});

  @override
  State<SensorsSetupContent> createState() => _SensorsSetupContentState();
}

class _SensorsSetupContentState extends State<SensorsSetupContent> {
  // 更新传感器状态为Connected和Connecting
  final List<Map<String, dynamic>> _connectedSensors = [
    {
      'type': 'Soil Moisture Sensor',
      'icon': Icons.opacity,
      'iconColor': Colors.blue,
      'location': 'Farm A - East Area',
      'status': 'Connected',
      'statusColor': Colors.green,
    },
    {
      'type': 'Soil Moisture Sensor',
      'icon': Icons.opacity,
      'iconColor': Colors.blue,
      'location': 'Farm A - West Area',
      'status': 'Connected',
      'statusColor': Colors.green,
    },
    {
      'type': 'Soil Moisture Sensor',
      'icon': Icons.opacity,
      'iconColor': Colors.blue,
      'location': 'Farm B - South Area',
      'status': 'Connecting',
      'statusColor': Colors.orange,
    },
  ];

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
                'Connect your sensors',
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
                  '3/4',
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
            'Add soil sensors to get real-time data',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF718096),
            ),
          ),
          const SizedBox(height: 24),
          
          // 不知道需要多少传感器？
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF7FAFC),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Don\'t know how many sensors are needed?',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF4A5568),
                  ),
                ),
                const SizedBox(height: 4),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'tap here',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF4299E1),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
          // 已连接传感器标题
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Connected Sensors',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
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
                    '${_connectedSensors.length}',
                    style: const TextStyle(
                      color: Color(0xFF4ADE80),
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // 已连接传感器列表
          ..._connectedSensors.map((sensor) => Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: _buildConnectedSensorCard(
              icon: sensor['icon'],
              iconColor: sensor['iconColor'],
              type: sensor['type'],
              location: sensor['location'],
              status: sensor['status'],
              statusColor: sensor['statusColor'],
            ),
          )).toList(),
          
          const SizedBox(height: 20),
          
          // 添加新传感器标题
          const Padding(
            padding: EdgeInsets.only(bottom: 12.0),
            child: Text(
              'Add More Sensors',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF2D3748),
              ),
            ),
          ),
          
          // 传感器列表
          _buildSensorCard(
            icon: Icons.opacity,
            iconColor: Colors.blue,
            title: 'Soil Moisture Sensor',
            description: 'Measures water content in soil',
          ),
          
          const SizedBox(height: 16),
          
          _buildSensorCard(
            icon: Icons.thermostat,
            iconColor: Colors.orange,
            title: 'Temperature Sensor',
            description: 'Monitors soil temperature',
          ),
          
          const SizedBox(height: 16),
          
          _buildSensorCard(
            icon: Icons.science,
            iconColor: Colors.purple,
            title: 'pH Sensor',
            description: 'Measures soil acidity/alkalinity',
          ),
          
          const SizedBox(height: 24),
          
          // 没有传感器？
          const Text(
            'Don\'t have sensors? No problem! You can still use CropMaster with satellite and weather data.',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF718096),
            ),
          ),
          
          const SizedBox(height: 40),
        ],
      ),
    );
  }
  
  // 已连接传感器卡片
  Widget _buildConnectedSensorCard({
    required IconData icon,
    required Color iconColor,
    required String type,
    required String location,
    required String status,
    required Color statusColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  type,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF2D3748),
                  ),
                ),
                Text(
                  location,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF718096),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: statusColor,
              ),
            ),
          ),
          const SizedBox(width: 8),
          PopupMenuButton(
            icon: const Icon(
              Icons.more_vert,
              color: Color(0xFF718096),
              size: 20,
            ),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'edit',
                child: Text('Edit'),
              ),
              const PopupMenuItem(
                value: 'calibrate',
                child: Text('Calibrate'),
              ),
              const PopupMenuItem(
                value: 'remove',
                child: Text('Remove'),
              ),
            ],
            onSelected: (value) {
              if (value == 'remove') {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Sensor removed')),
                );
              } else if (value == 'calibrate') {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Calibrating sensor...')),
                );
              } else if (value == 'edit') {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Edit sensor information')),
                );
              }
            },
          ),
        ],
      ),
    );
  }
  
  // 添加新传感器卡片
  Widget _buildSensorCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF2D3748),
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF718096),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Adding $title...')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4ADE80),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              minimumSize: const Size(0, 0),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            ),
            child: const Text(
              'Add',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
} 
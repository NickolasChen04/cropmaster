import 'package:flutter/material.dart';

class FarmDetailsCard extends StatelessWidget {
  const FarmDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 带农场图片的头部
          Container(
            height: 50,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              color: Colors.white,
            ),
            child: const Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  child: Row(
                    children: [
                      Icon(Icons.eco_outlined, 
                      color: Colors.black, size: 24),
                      SizedBox(width: 8),
                      Text(
                        'FARM C',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // 农场信息内容
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Farm Details',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                
                // 农场详情第一行
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildDetailTile(
                      icon: Icons.landscape,
                      iconColor: Colors.green.shade700,
                      label: 'Farm Type',
                      value: 'Rice Paddy',
                    ),
                    _buildDetailTile(
                      icon: Icons.grass,
                      iconColor: Colors.green,
                      label: 'Crop Type',
                      value: 'Rice (MR219 variety)',
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                
                // 农场详情第二行
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildDetailTile(
                      icon: Icons.area_chart,
                      iconColor: Colors.amber.shade700,
                      label: 'Total Area',
                      value: '15 hectares',
                    ),
                    _buildDetailTile(
                      icon: Icons.calendar_month,
                      iconColor: Colors.red,
                      label: 'Planting Date',
                      value: 'January 10, 2025',
                      showWarning: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 构建详情块的辅助方法
  Widget _buildDetailTile({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
    bool showWarning = false,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
        margin: const EdgeInsets.symmetric(horizontal: 2.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(icon, size: 16, color: iconColor),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    value,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                if (showWarning)
                  const Icon(
                    Icons.warning_amber_rounded,
                    size: 14,
                    color: Colors.red,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 
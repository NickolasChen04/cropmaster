import 'package:flutter/material.dart';

class AIRecommendationsCard extends StatelessWidget {
  const AIRecommendationsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // 头部
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.lightbulb_outline,
                        color: Colors.teal.shade700,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'AI Insights',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.teal.shade700,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // 内容
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              children: [
                // 灌溉优化建议
                _buildDetailedRecommendationItem(
                  icon: Icons.water_drop,
                  iconBgColor: Colors.blue.shade100,
                  iconColor: Colors.blue.shade700,
                  title: 'Irrigation Optimization',
                  description: 'Based on soil moisture data and weather forecast, we recommend reducing irrigation by 15% in the north field to save water while maintaining optimal crop health.',
                  actionText: 'Apply Recommendation',
                  actionColor: Colors.blue,
                ),
                const SizedBox(height: 16),
                
                // 施肥建议
                _buildDetailedRecommendationItem(
                  icon: Icons.check_circle_outline,
                  iconBgColor: Colors.green.shade100,
                  iconColor: Colors.green.shade700,
                  title: 'Fertilizer Application',
                  description: 'Soil analysis indicates nitrogen deficiency in the east section. We recommend targeted application of nitrogen-rich fertilizer to improve crop yield.',
                  actionText: 'Apply Recommendation',
                  actionColor: Colors.green,
                ),
                const SizedBox(height: 16),
                
                // 虫害管理建议
                _buildDetailedRecommendationItem(
                  icon: Icons.warning_amber_outlined,
                  iconBgColor: Colors.amber.shade100,
                  iconColor: Colors.amber.shade700,
                  title: 'Pest Management',
                  description: 'Early signs of corn borer detected. We recommend targeted biological control methods rather than broad-spectrum pesticides to preserve beneficial insects.',
                  actionText: 'Apply Recommendation',
                  actionColor: Colors.amber,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedRecommendationItem({
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String title,
    required String description,
    required String actionText,
    required Color actionColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: actionColor.withOpacity(0.5),
            width: 4,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 0, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 带图标的标题行
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // 描述
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(height: 8),
            // 操作按钮
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: actionColor,
                  padding: EdgeInsets.zero,
                  alignment: Alignment.centerLeft,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  minimumSize: Size.zero,
                ),
                child: Text(
                  actionText,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: actionColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 
import 'package:flutter/material.dart';

class SoilDashboard extends StatelessWidget {
  const SoilDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Soil Dashboard',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        
        // 环境条件卡片
        _buildSoilHealthCard(
          title: 'Environment Conditions',
          icon: Icons.thermostat,
          iconBgColor: Colors.green.shade800,
          statusText: 'Optimal',
          isWarning: false,
          usePoppinsWithIconColor: true,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCircularIndicator(
                value: 18.0,
                unit: '°C',
                progressColor: Colors.green,
                progressValue: 0.7,
                idealRange: 'Ideal: 15-20°C',
              ),
              _buildCircularIndicator(
                value: 6.2,
                unit: 'pH',
                progressColor: Colors.green,
                progressValue: 0.6,
                idealRange: 'Ideal: 5.5-6.5',
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        
        // 土壤湿度卡片（带警告）
        _buildSoilHealthCard(
          title: 'Soil Moisture',
          icon: Icons.water_drop,
          iconBgColor: Colors.blue.shade700,
          statusText: 'Warning',
          isWarning: true,
          usePoppinsWithIconColor: true,
          child: Column(
            children: [
              _buildCircularIndicator(
                value: 14,
                unit: '%',
                progressColor: Colors.red,
                progressValue: 0.14,
                idealRange: 'Ideal: 15-25%',
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Moisture level below recommended range. Consider irrigation soon.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.red.shade700,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        
        // 土壤氮元素卡片
        _buildSoilHealthCard(
          title: 'Soil Nitrogen',
          icon: Icons.eco,
          iconBgColor: Colors.purple.shade700,
          statusText: 'Optimal',
          isWarning: false,
          usePoppinsWithIconColor: true,
          child: _buildCircularIndicator(
            value: 42,
            unit: 'mg/kg',
            progressColor: Colors.green,
            progressValue: 0.42,
            idealRange: 'Ideal: 40-60 mg/kg',
          ),
        ),
        const SizedBox(height: 8),

        // 更新时间戳
        const Align(
          alignment: Alignment.centerRight,
          child: Text(
            'Updated: 10 mins ago',
            style: TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
        ),
      ],
    );
  }

  // 土壤健康卡片的辅助方法
  Widget _buildSoilHealthCard({
    required String title,
    required IconData icon,
    required Color iconBgColor,
    required String? statusText,
    required bool isWarning,
    required Widget child,
    bool usePoppinsWithIconColor = false,
  }) {
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
                        icon,
                        color: iconBgColor,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: usePoppinsWithIconColor ? FontWeight.w600 : FontWeight.w500,
                        color: usePoppinsWithIconColor ? iconBgColor : Colors.black87,
                        fontFamily: usePoppinsWithIconColor ? 'Poppins' : null,
                      ),
                    ),
                  ],
                ),
                if (statusText != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: isWarning ? Colors.red.shade50 : Colors.green.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      statusText,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isWarning ? Colors.red.shade600 : Colors.green.shade600,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          // 内容
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
            child: child,
          ),
        ],
      ),
    );
  }
    
  // 圆形指标的辅助方法
  Widget _buildCircularIndicator({
    required num value,
    required String unit,
    required Color progressColor,
    required double progressValue,
    required String idealRange,
    bool showDownArrow = false,
  }) {
    return Column(
      children: [
        SizedBox(
          width: 110,
          height: 110,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(
                  value: progressValue,
                  strokeWidth: 7,
                  strokeCap: StrokeCap.round,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: value.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: unit,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (showDownArrow) 
                    const SizedBox(height: 4),
                  if (showDownArrow)
                    const Icon(
                      Icons.arrow_downward,
                      color: Colors.red,
                      size: 16,
                    ),
                ],
              ),
            ],
          ),
        ),
        Text(
          idealRange,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
} 
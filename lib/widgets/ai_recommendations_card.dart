import 'package:flutter/material.dart';

class AIRecommendationsCard extends StatelessWidget {
  final String farmId;
  
  const AIRecommendationsCard({super.key, required this.farmId});

  @override
  Widget build(BuildContext context) {
    final recommendations = _getRecommendationsForFarm(farmId);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'AI Insights',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        
        // AI insights card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.purple.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.lightbulb_outline,
                      color: Colors.purple.shade800,
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Smart Recommendations',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // Build each recommendation card
              ...recommendations.map((rec) => _buildRecommendationItem(
                title: rec['title'],
                icon: rec['icon'],
                iconColor: rec['iconColor'],
                iconBgColor: rec['iconBgColor'],
                description: rec['description'],
                actionText: rec['actionText'],
                actionColor: rec['actionColor'],
              )).toList(),
            ],
          ),
        ),
      ],
    );
  }

  List<Map<String, dynamic>> _getRecommendationsForFarm(String farmId) {
    switch (farmId) {
      case 'A':
        return [
          {
            'title': 'Irrigation Optimization',
            'icon': Icons.water_drop,
            'iconColor': Colors.blue.shade700,
            'iconBgColor': Colors.blue.shade100,
            'description': 'Based on predicted rainfall patterns, we recommend delaying irrigation for 2 days to conserve water and prevent over-saturation.',
            'actionText': 'Apply Recommendation',
            'actionColor': Colors.blue,
          },
          {
            'title': 'Corn Pest Alert',
            'icon': Icons.bug_report,
            'iconColor': Colors.amber.shade700,
            'iconBgColor': Colors.amber.shade100,
            'description': 'Early detection of corn earworm. Consider introducing natural predators like ladybugs or applying organic pest control within 3 days.',
            'actionText': 'View Control Options',
            'actionColor': Colors.amber.shade800,
          },
        ];
      case 'B':
        return [
          {
            'title': 'Disease Prevention',
            'icon': Icons.health_and_safety,
            'iconColor': Colors.purple.shade700,
            'iconBgColor': Colors.purple.shade100,
            'description': 'Early signs of apple scab detected. Apply organic fungicides within 48 hours to prevent spread and crop loss.',
            'actionText': 'Apply Recommendation',
            'actionColor': Colors.purple,
          },
          {
            'title': 'pH Balancing Required',
            'icon': Icons.science,
            'iconColor': Colors.red.shade700,
            'iconBgColor': Colors.red.shade100,
            'description': 'Soil pH is above ideal range for apple trees. Apply sulfur amendments to reduce pH gradually over the next month.',
            'actionText': 'Schedule Treatment',
            'actionColor': Colors.red,
          },
        ];
      case 'C':
      default:
        return [
          {
            'title': 'Water Conservation',
            'icon': Icons.water_drop,
            'iconColor': Colors.blue.shade700,
            'iconBgColor': Colors.blue.shade100,
            'description': 'Based on current soil moisture and forecasted rain, we recommend reducing irrigation by 15% this week to conserve water while maintaining optimal growing conditions.',
            'actionText': 'Apply Recommendation',
            'actionColor': Colors.blue,
          },
          {
            'title': 'Nitrogen Management',
            'icon': Icons.science,
            'iconColor': Colors.green.shade700,
            'iconBgColor': Colors.green.shade100,
            'description': 'Soil tests indicate optimal nitrogen levels. Delay next fertilizer application by 7 days to prevent nutrient runoff.',
            'actionText': 'Update Schedule',
            'actionColor': Colors.green,
          },
        ];
    }
  }

  Widget _buildRecommendationItem({
    required String title,
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String description,
    required String actionText,
    required Color actionColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconBgColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 16,
                  color: iconColor,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade700,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: actionColor,
                  side: BorderSide(color: actionColor),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  actionText,
                  style: TextStyle(
                    fontSize: 12,
                    color: actionColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../widgets/farm_details_card.dart';
import '../widgets/soil_dashboard.dart';
import '../widgets/task_card.dart';
import '../widgets/ai_recommendations_card.dart';
import '../models/farm_data.dart';

class FarmScreen extends StatefulWidget {
  final String farmId;
  final String farmName;
  final String farmType;

  const FarmScreen({
    super.key, 
    required this.farmId,
    required this.farmName,
    required this.farmType,
  });

  @override
  State<FarmScreen> createState() => _FarmScreenState();
}

class _FarmScreenState extends State<FarmScreen> {
  // Task type state variables
  String _selectedTaskType = 'Harvest';
  IconData _selectedTaskIcon = Icons.grass;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.farmName),
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/farm_background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Semi-transparent white overlay
          Container(
            color: Colors.white.withOpacity(0.5), 
          ),
          // Main content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Farm details card
                    FarmDetailsCard(
                      farmName: widget.farmName,
                      farmType: _getFarmType(widget.farmId),
                      cropType: _getCropType(widget.farmId),
                      totalArea: _getTotalArea(widget.farmId),
                      plantingDate: _getPlantingDate(widget.farmId),
                      showPlantingWarning: _shouldShowPlantingWarning(widget.farmId),
                    ),
                    const SizedBox(height: 20),
                    
                    // Soil dashboard section
                    SoilDashboard(farmId: widget.farmId),
                    const SizedBox(height: 20),
                    
                    // Today's task card
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

                    // AI recommendations card
                    AIRecommendationsCard(farmId: widget.farmId),
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

  // Helper methods for farm-specific data
  String _getFarmType(String farmId) {
    switch (farmId) {
      case 'A':
        return 'Corn Field';
      case 'B':
        return 'Apple Orchard';
      case 'C':
      default:
        return 'Rice Paddy';
    }
  }

  String _getCropType(String farmId) {
    switch (farmId) {
      case 'A':
        return 'Corn (Hybrid 2024)';
      case 'B':
        return 'Apple (Fuji)';
      case 'C':
      default:
        return 'Rice (MR219 variety)';
    }
  }

  String _getTotalArea(String farmId) {
    switch (farmId) {
      case 'A':
        return '20 acres';
      case 'B':
        return '15 acres';
      case 'C':
      default:
        return '30 acres';
    }
  }

  String _getPlantingDate(String farmId) {
    switch (farmId) {
      case 'A':
        return 'Mar 10, 2025';
      case 'B':
        return 'Feb 28, 2025';
      case 'C':
      default:
        return 'Apr 5, 2025';
    }
  }

  bool _shouldShowPlantingWarning(String farmId) {
    switch (farmId) {
      case 'A':
        return false;
      case 'B':
        return true;  // Warning for Farm B's planting date
      case 'C':
      default:
        return false;
    }
  }
}
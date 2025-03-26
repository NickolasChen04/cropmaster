import 'package:flutter/material.dart';

class SoilDashboard extends StatelessWidget {
  final String farmId;
  
  const SoilDashboard({super.key, required this.farmId});

  @override
  Widget build(BuildContext context) {
    // Get farm-specific soil data
    final soilData = _getSoilDataForFarm(farmId);
    
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
        
        // Environment conditions card
        _buildSoilHealthCard(
          title: 'Environment Conditions',
          icon: Icons.thermostat,
          iconBgColor: Colors.green.shade800,
          statusText: soilData['tempStatus'],
          isWarning: soilData['tempWarning'],
          usePoppinsWithIconColor: true,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCircularIndicator(
                value: soilData['temperature'],
                unit: '°C',
                progressColor: soilData['tempWarning'] ? Colors.orange : Colors.green,
                progressValue: soilData['temperature'] / 30.0, // assuming 30°C is max
                idealRange: 'Ideal: 15-20°C',
              ),
              _buildCircularIndicator(
                value: soilData['pH'],
                unit: 'pH',
                progressColor: soilData['pHWarning'] ? Colors.orange : Colors.green,
                progressValue: soilData['pH'] / 14.0, // pH scale 0-14
                idealRange: 'Ideal: 5.5-6.5',
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        
        // Soil moisture card (with warning for some farms)
        _buildSoilHealthCard(
          title: 'Soil Moisture',
          icon: Icons.water_drop,
          iconBgColor: Colors.blue.shade700,
          statusText: soilData['moistureStatus'],
          isWarning: soilData['moistureWarning'],
          usePoppinsWithIconColor: true,
          child: Column(
            children: [
              _buildCircularIndicator(
                value: soilData['moisture'],
                unit: '%',
                progressColor: soilData['moistureWarning'] ? Colors.red : Colors.blue,
                progressValue: soilData['moisture'] / 100.0,
                idealRange: 'Ideal: 15-25%',
              ),
              
              // Show warning message for low moisture
              if (soilData['moistureWarning'])
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.warning_rounded,
                        color: Colors.red.shade700,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _getMoistureWarningMessage(farmId),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.red.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Map<String, dynamic> _getSoilDataForFarm(String farmId) {
    switch (farmId) {
      case 'A':
        return {
          'temperature': 22.5,
          'tempStatus': 'Good',
          'tempWarning': false,
          'pH': 5.8,
          'pHStatus': 'Optimal',
          'pHWarning': false,
          'moisture': 18.0,  // Changed to double
          'moistureStatus': 'Optimal',
          'moistureWarning': false,
        };
      case 'B':
        return {
          'temperature': 24.0,
          'tempStatus': 'Warning',
          'tempWarning': true,
          'pH': 7.1,
          'pHStatus': 'Warning',
          'pHWarning': true,
          'moisture': 12.0,  // Changed to double
          'moistureStatus': 'Warning',
          'moistureWarning': true,
        };
      case 'C':
      default:
        return {
          'temperature': 18.0,
          'tempStatus': 'Optimal',
          'tempWarning': false,
          'pH': 6.2,
          'pHStatus': 'Optimal',
          'pHWarning': false,
          'moisture': 14.0,  // Changed to double
          'moistureStatus': 'Warning',
          'moistureWarning': true,
        };
    }
  }
  
  String _getMoistureWarningMessage(String farmId) {
    switch (farmId) {
      case 'A':
        return 'No warning, moisture levels optimal.';
      case 'B':
        return 'Moisture level too low! Schedule irrigation within 24 hours to prevent crop stress.';
      case 'C':
      default:
        return 'Soil moisture below recommended level. Consider irrigation in the next 48 hours.';
    }
  }

  Widget _buildSoilHealthCard({
    required String title,
    required IconData icon,
    required Color iconBgColor,
    required String statusText,
    required bool isWarning,
    required Widget child,
    bool usePoppinsWithIconColor = false,
  }) {
    return Container(
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: iconBgColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      color: iconBgColor,
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isWarning ? Colors.red.shade50 : Colors.green.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(
                      isWarning ? Icons.warning_rounded : Icons.check_circle,
                      size: 12,
                      color: isWarning ? Colors.red : Colors.green,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      statusText,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: isWarning ? Colors.red : Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildCircularIndicator({
    required double value,
    required String unit,
    required Color progressColor,
    required double progressValue,
    required String idealRange,
  }) {
    return Column(
      children: [
        SizedBox(
          height: 100,
          width: 100,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 90,
                width: 90,
                child: CircularProgressIndicator(
                  value: progressValue,
                  backgroundColor: Colors.grey.shade200,
                  strokeWidth: 8,
                  valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    value.toString(),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    unit,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          idealRange,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'notifications_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../providers/navigation_provider.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DateTime selectedDate = DateTime.now();
  final List<bool> _taskCompletionStatus = List.generate(4, (_) => false);

  String _getDayOfWeek(DateTime date) {
    return DateFormat('EEEE').format(date);
  }

  String _getFormattedDate(DateTime date) {
    return DateFormat('MMM d').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF90EE90), // Light green background
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.logout, color: Colors.black),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Logout'),
                            content: const Text('Are you sure you want to logout?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context); // Close dialog
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context); // Close dialog
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginPage(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Logout',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  const Text(
                    'Dashboard',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NotificationsPage(),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: const Icon(
                            Icons.notifications_none,
                            color: Colors.black,
                            size: 24,
                          ),
                        ),
                      ),
                      // Notification dot
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Weather Card
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              const Color(0xFF98DDB6),  // Light pastel green
                              const Color(0xFF7BC5A3),  // Slightly darker pastel green
                            ],
                          ),
                          borderRadius: BorderRadius.circular(25.0),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF98DDB6).withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 4),
                                    const Text(
                                      'Penang',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        _getDayOfWeek(selectedDate),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Container(
                                        width: 1,
                                        height: 12,
                                        color: Colors.white.withOpacity(0.5),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        _getFormattedDate(selectedDate),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      '24°',
                                      style: TextStyle(
                                        fontSize: 60,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Text(
                                        'Sunny Day',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.wb_sunny,
                                  color: Colors.yellow[300],
                                  size: 80,
                                ),
                              ],
                            ),
                            const SizedBox(height: 25),
                            Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  _buildWeatherDetail('27 km/h', 'Wind', Icons.air),
                                  Container(
                                    width: 1,
                                    height: 30,
                                    color: Colors.white.withOpacity(0.5),
                                  ),
                                  _buildWeatherDetail('74%', 'Humidity', Icons.water_drop),
                                  Container(
                                    width: 1,
                                    height: 30,
                                    color: Colors.white.withOpacity(0.5),
                                  ),
                                  _buildWeatherDetail('0%', 'Rain', Icons.umbrella),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Today's Date
                      Row(
                        children: [
                          const Text(
                            'Today',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            _getFormattedDate(selectedDate),
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Hourly Weather
                      SizedBox(
                        height: 120,
                        width: MediaQuery.of(context).size.width,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            _buildHourlyWeather('9:00', '23°', Icons.wb_sunny),
                            _buildHourlyWeather('10:00', '24°', Icons.wb_sunny),
                            _buildHourlyWeather('11:00', '25°', Icons.cloud),
                            _buildHourlyWeather('12:00', '24°', Icons.cloud),
                            _buildHourlyWeather('13:00', '23°', Icons.thunderstorm),
                            _buildHourlyWeather('14:00', '22°', Icons.thunderstorm),
                            _buildHourlyWeather('15:00', '21°', Icons.cloud),
                            _buildHourlyWeather('16:00', '22°', Icons.cloud),
                            _buildHourlyWeather('17:00', '23°', Icons.wb_sunny),
                            _buildHourlyWeather('18:00', '21°', Icons.wb_twilight),
                            _buildHourlyWeather('19:00', '20°', Icons.nights_stay),
                            _buildHourlyWeather('20:00', '19°', Icons.nights_stay),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Your Farm Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Your Farm',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Switch to Farms tab
                              context.read<NavigationProvider>().setIndex(1);
                            },
                            child: Row(
                              children: [
                                const Text(
                                  'Go to farm',
                                  style: TextStyle(
                                    color: Color(0xFF4ADE80),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Icon(
                                  Icons.arrow_forward,
                                  size: 16,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Stack(
                            children: [
                              Image.asset(
                                'assets/images/farm_satellite.png',  // Updated to use .png extension
                                width: double.infinity,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                              // Farm markers with labels
                              Positioned(
                                left: MediaQuery.of(context).size.width * 0.15,
                                top: 20,
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.red.withOpacity(0.9),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.bug_report, color: Colors.white, size: 16),
                                          SizedBox(width: 4),
                                          Text(
                                            'Pest Alert',
                                            style: TextStyle(color: Colors.white, fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Icon(
                                      Icons.location_on,
                                      color: Colors.red,
                                      size: 24,
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                left: MediaQuery.of(context).size.width * 0.35,
                                top: 40,
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.yellow.withOpacity(0.9),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.landscape, color: Colors.black, size: 16),
                                          SizedBox(width: 4),
                                          Text(
                                            'Soil Degradation Alert',
                                            style: TextStyle(color: Colors.black, fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Icon(
                                      Icons.location_on,
                                      color: Colors.yellow,
                                      size: 24,
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                right: MediaQuery.of(context).size.width * 0.15,
                                top: 30,
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.lightBlue.withOpacity(0.9),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.water_drop, color: Colors.white, size: 16),
                                          SizedBox(width: 4),
                                          Text(
                                            'Irrigation',
                                            style: TextStyle(color: Colors.white, fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Icon(
                                      Icons.location_on,
                                      color: Colors.lightBlue,
                                      size: 24,
                                    ),
                                  ],
                                ),
                              ),
                              // Location button
                              Positioned(
                                right: 16,
                                bottom: 16,
                                child: GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          insetPadding: EdgeInsets.zero,
                                          child: Stack(
                                            children: [
                                              // Full screen image with markers
                                              InteractiveViewer(
                                                panEnabled: true,
                                                minScale: 0.5,
                                                maxScale: 4,
                                                child: Stack(
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/farm_satellite.png',
                                                      width: MediaQuery.of(context).size.width,
                                                      height: MediaQuery.of(context).size.height,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    // Farm markers in full screen
                                                    Positioned(
                                                      left: MediaQuery.of(context).size.width * 0.15,
                                                      top: MediaQuery.of(context).size.height * 0.15,
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                                            decoration: BoxDecoration(
                                                              color: Colors.red.withOpacity(0.9),
                                                              borderRadius: BorderRadius.circular(6),
                                                            ),
                                                            child: const Row(
                                                              mainAxisSize: MainAxisSize.min,
                                                              children: [
                                                                Icon(Icons.bug_report, color: Colors.white, size: 20),
                                                                SizedBox(width: 6),
                                                                Text(
                                                                  'Pest Alert',
                                                                  style: TextStyle(color: Colors.white, fontSize: 14),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          const Icon(
                                                            Icons.location_on,
                                                            color: Colors.red,
                                                            size: 32,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    // Soil Degradation Alert marker
                                                    Positioned(
                                                      left: MediaQuery.of(context).size.width * 0.35,
                                                      top: MediaQuery.of(context).size.height * 0.2,
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                                            decoration: BoxDecoration(
                                                              color: Colors.yellow.withOpacity(0.9),
                                                              borderRadius: BorderRadius.circular(6),
                                                            ),
                                                            child: const Row(
                                                              mainAxisSize: MainAxisSize.min,
                                                              children: [
                                                                Icon(Icons.landscape, color: Colors.black, size: 20),
                                                                SizedBox(width: 6),
                                                                Text(
                                                                  'Soil Degradation Alert',
                                                                  style: TextStyle(color: Colors.black, fontSize: 14),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          const Icon(
                                                            Icons.location_on,
                                                            color: Colors.yellow,
                                                            size: 32,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    // Irrigation marker
                                                    Positioned(
                                                      right: MediaQuery.of(context).size.width * 0.15,
                                                      top: MediaQuery.of(context).size.height * 0.18,
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                                            decoration: BoxDecoration(
                                                              color: Colors.lightBlue.withOpacity(0.9),
                                                              borderRadius: BorderRadius.circular(6),
                                                            ),
                                                            child: const Row(
                                                              mainAxisSize: MainAxisSize.min,
                                                              children: [
                                                                Icon(Icons.water_drop, color: Colors.white, size: 20),
                                                                SizedBox(width: 6),
                                                                Text(
                                                                  'Irrigation',
                                                                  style: TextStyle(color: Colors.white, fontSize: 14),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          const Icon(
                                                            Icons.location_on,
                                                            color: Colors.lightBlue,
                                                            size: 32,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              // Close button (outside InteractiveViewer)
                                              Positioned(
                                                right: 16,
                                                top: 16,
                                                child: GestureDetector(
                                                  onTap: () => Navigator.pop(context),
                                                  child: Container(
                                                    padding: const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      shape: BoxShape.circle,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black.withOpacity(0.2),
                                                          spreadRadius: 1,
                                                          blurRadius: 3,
                                                        ),
                                                      ],
                                                    ),
                                                    child: const Icon(
                                                      Icons.close,
                                                      color: Colors.black,
                                                      size: 24,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 4,
                                        ),
                                      ],
                                    ),
                                    child: const Icon(
                                      Icons.fullscreen,  // Changed to fullscreen icon
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Today's Tasks
                      const Text(
                        'Today\'s Task',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildTaskItem(
                        'Irrigation Check - Farm A',
                        '10:00 AM',
                        Icons.water,
                        Colors.blue,
                        0,
                      ),
                      const SizedBox(height: 12),
                      _buildTaskItem(
                        'Apply Fertilizer - Farm B',
                        '2:00 PM',
                        Icons.eco,
                        Colors.green,
                        1,
                      ),
                      const SizedBox(height: 12),
                      _buildTaskItem(
                        'Pest Inspection - Farm A',
                        '4:30 PM',
                        Icons.bug_report,
                        Colors.orange,
                        2,
                      ),
                      const SizedBox(height: 12),
                      _buildTaskItem(
                        'Harvest Crops - Farm C',
                        '5:00 PM',
                        Icons.agriculture,
                        Colors.pink,
                        3,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherDetail(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white.withOpacity(0.8),
          size: 20,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildHourlyWeather(String time, String temp, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            time,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Icon(
            icon, 
            color: icon == Icons.wb_sunny 
                ? Colors.orange 
                : icon == Icons.nights_stay 
                    ? Colors.indigo
                    : icon == Icons.thunderstorm
                        ? Colors.blueGrey
                        : Colors.grey[400],
            size: 28
          ),
          const SizedBox(height: 10),
          Text(
            temp,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskItem(String title, String time, IconData icon, Color color, int index) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(
              icon,
              color: color,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    decoration: _taskCompletionStatus[index] 
                        ? TextDecoration.lineThrough 
                        : TextDecoration.none,
                  ),
                ),
                Text(
                  time,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Checkbox(
            value: _taskCompletionStatus[index],
            onChanged: (bool? value) {
              setState(() {
                _taskCompletionStatus[index] = value ?? false;
              });
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }
} 
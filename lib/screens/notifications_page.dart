import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> with SingleTickerProviderStateMixin {
  String selectedTab = 'All';
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Widget> _getFilteredNotifications() {
    List<Widget> notifications = [];
    
    void addNotification(Widget notification) {
      notifications.add(notification);
      notifications.add(const SizedBox(height: 16));
    }

    if (selectedTab == 'All' || selectedTab == 'Alerts') {
      // Alerts
      addNotification(_buildNotificationCard(
        icon: Icons.bug_report,
        iconBackgroundColor: Colors.red.shade50,
        iconColor: Colors.red,
        title: 'Pest Alert: Corn Borer Detected',
        subtitle: 'in Farm A',
        time: '30 minutes ago',
        actionText: 'View Details',
        backgroundColor: Colors.white,
      ));
      
      addNotification(_buildNotificationCard(
        icon: Icons.cloudy_snowing,
        iconBackgroundColor: Colors.amber.shade50,
        iconColor: Colors.amber,
        title: 'Weather Warning: Heavy Rain',
        subtitle: 'Affecting Farm A, B, and C',
        time: '2 hours ago',
        actionText: 'View Forecast',
        backgroundColor: Colors.white,
      ));
      
      addNotification(_buildNotificationCard(
        icon: Icons.water_drop,
        iconBackgroundColor: Colors.blue.shade50,
        iconColor: Colors.blue,
        title: 'Soil Moisture Alert',
        subtitle: 'in Farm B',
        time: 'Yesterday',
        actionText: 'View Details',
        backgroundColor: Colors.white,
      ));
    }

    if (selectedTab == 'All' || selectedTab == 'Tasks') {
      // Tasks
      addNotification(_buildNotificationCard(
        icon: Icons.water,
        iconBackgroundColor: Colors.blue.shade50,
        iconColor: Colors.blue,
        title: 'Irrigation Check Due',
        subtitle: 'Farm A - 10:00 AM',
        time: '1 hour ago',
        actionText: 'Mark Complete',
        backgroundColor: Colors.white,
      ));
      
      addNotification(_buildNotificationCard(
        icon: Icons.eco,
        iconBackgroundColor: Colors.green.shade50,
        iconColor: Colors.green,
        title: 'Apply Fertilizer',
        subtitle: 'Farm B - 2:00 PM',
        time: '30 minutes ago',
        actionText: 'Mark Complete',
        backgroundColor: Colors.white,
      ));
      
      addNotification(_buildNotificationCard(
        icon: Icons.agriculture,
        iconBackgroundColor: Colors.pink.shade50,
        iconColor: Colors.pink,
        title: 'Harvest Crops',
        subtitle: 'Farm C - 5:00 PM',
        time: '15 minutes ago',
        actionText: 'Mark Complete',
        backgroundColor: Colors.white,
      ));
    }

    if (selectedTab == 'All' || selectedTab == 'Updates') {
      // Updates
      addNotification(_buildNotificationCard(
        icon: Icons.update,
        iconBackgroundColor: Colors.purple.shade50,
        iconColor: Colors.purple,
        title: 'Crop Growth Update',
        subtitle: 'Farm A crops are growing well',
        time: '3 hours ago',
        actionText: 'View Report',
        backgroundColor: Colors.white,
      ));
      
      addNotification(_buildNotificationCard(
        icon: Icons.analytics,
        iconBackgroundColor: Colors.indigo.shade50,
        iconColor: Colors.indigo,
        title: 'Weekly Farm Analysis',
        subtitle: 'Performance report for all farms',
        time: '1 day ago',
        actionText: 'View Analysis',
        backgroundColor: Colors.white,
      ));
    }

    // Remove the last SizedBox if it exists
    if (notifications.isNotEmpty) {
      notifications.removeLast();
    }

    return notifications;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Tab Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                _buildTab('All'),
                const SizedBox(width: 16),
                _buildTab('Alerts'),
                const SizedBox(width: 16),
                _buildTab('Tasks'),
                const SizedBox(width: 16),
                _buildTab('Updates'),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Notifications List
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: ListView(
                key: ValueKey<String>(selectedTab),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: _getFilteredNotifications(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String text) {
    bool isSelected = selectedTab == text;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = text;
          _controller.reset();
          _controller.forward();
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationCard({
    required IconData icon,
    required Color iconBackgroundColor,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String time,
    required String actionText,
    required Color backgroundColor,
  }) {
    return FadeTransition(
      opacity: _animation,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconBackgroundColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: iconColor),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (subtitle.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        actionText,
                        style: TextStyle(
                          color: Colors.blue[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        time,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 
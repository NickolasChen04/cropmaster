import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final String selectedTaskType;
  final IconData selectedTaskIcon;
  final Function(String, IconData) onTaskTypeSelected;

  const TaskCard({
    super.key,
    required this.selectedTaskType,
    required this.selectedTaskIcon,
    required this.onTaskTypeSelected,
  });

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
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 页眉行
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.description_outlined,
                        color: Colors.black54,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Today Task',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          '1 of 10 task ready',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // 更新的PopupMenuButton，带状态管理
                PopupMenuButton<String>(
                  offset: const Offset(0, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: Colors.white, 
                  elevation: 4,
                  onSelected: (String value) {
                    // 更新基于选定任务的图标
                    IconData icon;
                    switch (value) {
                      case 'Water':
                        icon = Icons.water_drop;
                        break;
                      case 'Fertilize':
                        icon = Icons.spa;
                        break;
                      case 'Monitor':
                        icon = Icons.visibility;
                        break;
                      default: // Harvest
                        icon = Icons.grass;
                        break;
                    }
                    onTaskTypeSelected(value, icon);
                  },
                  itemBuilder: (context) => [
                    _buildPopupMenuItem('Harvest', Icons.grass, selectedTaskType == 'Harvest'),
                    _buildPopupMenuItem('Water', Icons.water_drop, selectedTaskType == 'Water'),
                    _buildPopupMenuItem('Fertilize', Icons.spa, selectedTaskType == 'Fertilize'),
                    _buildPopupMenuItem('Monitor', Icons.visibility, selectedTaskType == 'Monitor'),
                  ],
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          selectedTaskIcon,
                          size: 16,
                          color: const Color(0xFF22C55E).withOpacity(0.7),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          selectedTaskType,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          size: 16,
                          color: Colors.black54,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // 任务容器
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  // 时间指示
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Text(
                            'Waiting at 09.00AM',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            const Text(
                              'Done',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.check,
                                  size: 16,
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  // 任务描述
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Plant for wheat seed and harvest the second layer of the wheat field only',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  
                  // 进度条和状态
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        // 进度条
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              value: 0.25,
                              minHeight: 8,
                              backgroundColor: Colors.grey.shade200,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                const Color(0xFF22C55E).withOpacity(0.7), 
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // 状态文本
                        const Text(
                          '02/08 Done',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 弹出菜单项辅助方法
  PopupMenuItem<String> _buildPopupMenuItem(String value, IconData icon, bool isSelected) {
    final Color customGreen = const Color(0xFF22C55E).withOpacity(0.7);
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Icon(
            icon,
            color: isSelected ? customGreen : Colors.grey,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            value,
            style: TextStyle(
              color: isSelected ? customGreen : Colors.black87,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
} 
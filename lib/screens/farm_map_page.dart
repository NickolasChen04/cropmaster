import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'setup_flow_page.dart';
import 'farm_screen.dart';

class FarmMapPage extends StatefulWidget {
  const FarmMapPage({super.key});

  @override
  State<FarmMapPage> createState() => _FarmMapPageState();
}

class _FarmMapPageState extends State<FarmMapPage> {
  final List<Farm> farms = [
    Farm(id: 'A', name: 'FARM A', type: 'Corn farm', position: const Offset(0.3, 0.4)),
    Farm(id: 'B', name: 'FARM B', type: 'Apple farm', position: const Offset(0.5, 0.6)),
    Farm(id: 'C', name: 'FARM C', type: 'Rice farm', position: const Offset(0.7, 0.3)),
  ];

  Farm? selectedFarm;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Farm> get filteredFarms => farms.where((farm) {
    final query = _searchQuery.toLowerCase();
    return farm.name.toLowerCase().contains(query) ||
           farm.type.toLowerCase().contains(query) ||
           farm.id.toLowerCase().contains(query);
  }).toList();

  void _navigateToFarmScreen(Farm farm) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FarmScreen(
          farmId: farm.id,
          farmName: farm.name,
          farmType: farm.type,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Interactive Map
          PhotoView(
            imageProvider: const AssetImage('assets/images/map.png'),
            minScale: PhotoViewComputedScale.covered,
            maxScale: PhotoViewComputedScale.covered * 4.0,
            initialScale: PhotoViewComputedScale.covered * 1.5,
            backgroundDecoration: const BoxDecoration(color: Colors.transparent),
            basePosition: Alignment.center,
            filterQuality: FilterQuality.high,
            tightMode: false,
            enableRotation: false,
            scaleStateController: PhotoViewScaleStateController(),
            enablePanAlways: true,
          ),

          // Search Bar
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 16,
            right: 16,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search farms',
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: Colors.grey),
                          onPressed: () {
                            setState(() {
                              _searchController.clear();
                              _searchQuery = '';
                            });
                          },
                        )
                      : null,
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
            ),
          ),

          // Farm Markers section removed completely

          // Bottom Sheet
          DraggableScrollableSheet(
            initialChildSize: 0.2,
            minChildSize: 0.1,
            maxChildSize: 0.7,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        controller: scrollController,
                        padding: const EdgeInsets.all(16),
                        children: [
                          ...filteredFarms.map((farm) => ListTile(
                            leading: CircleAvatar(
                              backgroundColor: const Color(0xFF22C55E).withOpacity(0.7),
                              child: Text(
                                farm.id,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            title: Text(farm.name),
                            subtitle: Text(farm.type),
                            trailing: farm.id == 'B' 
                              ? const Icon(Icons.warning, color: Colors.orange)
                              : (farm.id == 'C' 
                                ? const Icon(Icons.warning, color: Colors.red)
                                : null),
                            onTap: () {
                              setState(() {
                                selectedFarm = farm;
                              });
                              
                              // Navigate to appropriate farm screen
                              _navigateToFarmScreen(farm);
                            },
                          )),
                          if (filteredFarms.isEmpty)
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  'No farms found',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          if (filteredFarms.isNotEmpty) ...[
                            const SizedBox(height: 20),
                            const Divider(),
                            const SizedBox(height: 20),
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const SetupFlowPage(),
                                    ),
                                  );
                                },
                                child: const Icon(Icons.add_circle_outline, size: 30),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class Farm {
  final String id;
  final String name;
  final String type;
  final Offset position;

  Farm({
    required this.id,
    required this.name,
    required this.type,
    required this.position,
  });
}
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
    Farm(id: 'B', name: 'FARM B', type: 'Rice farm', position: const Offset(0.5, 0.6)),
    Farm(id: 'C', name: 'FARM C', type: 'Cabbage farm', position: const Offset(0.7, 0.3)),
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
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: 'Search farms...',
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _searchQuery = '';
                            _searchController.clear();
                          });
                        },
                      )
                    : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  isDense: true,
                ),
              ),
            ),
          ),

          // Draggable Bottom Sheet
          DraggableScrollableSheet(
            initialChildSize: 0.3,
            minChildSize: 0.1,
            maxChildSize: 0.8,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Drag Handle
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
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
                              child: Text(farm.id),
                            ),
                            title: Text(farm.name),
                            subtitle: Text(farm.type),
                            trailing: farm.id == 'C' 
                              ? const Icon(Icons.warning, color: Colors.red)
                              : null,
                            onTap: () {
                              setState(() {
                                selectedFarm = farm;
                              });
                              
                              if (farm.id == 'C') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const FarmScreen(),
                                  ),
                                );
                              }
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
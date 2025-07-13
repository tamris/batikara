import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:latlong2/latlong.dart';
import 'batik_place_detail_sheet.dart';
import '../controllers/mapping_controller.dart';
import 'package:flutter_map/flutter_map.dart' as fmap;

class MappingView extends GetView<MappingController> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Peta Lokasi Batik",
        style: TextStyle(fontFamily: "Poppins"),
      )),
      body: Obx(() {
        final location = controller.currentLocation.value;

        if (location == null) {
          return Center(
            child: SizedBox(
              width: 200,
              height: 200,
              child: Lottie.asset('assets/animations/location.json'),
            ),
          );
        }

        final markers = <fmap.Marker>[];

        // 🔴 Marker lokasi user
        if (controller.locationLoaded.value) {
          markers.add(
            fmap.Marker(
              point: location,
              width: 80,
              height: 80,
              child: const Icon(
                Icons.location_pin,
                color: Colors.red,
                size: 40,
              ),
            ),
          );
        }

        // 🔵 Marker batik interaktif
        markers.addAll(controller.batikPlaces.map((place) {
          return fmap.Marker(
            point: LatLng(place.latitude, place.longitude),
            width: 60,
            height: 60,
            child: GestureDetector(
              onTap: () => showBatikPlaceDetailBottomSheet(context, place),
              child: const Icon(
                Icons.location_pin,
                color: Colors.blueAccent,
                size: 36,
              ),
            ),
          );
        }));

        return Stack(
          children: [
            fmap.FlutterMap(
              mapController: controller.mapController,
              options: fmap.MapOptions(
                initialCenter: location,
                initialZoom: controller.zoom.value,
              ),
              children: [
                fmap.TileLayer(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                  userAgentPackageName:
                      'com.example.app',
                ),
                fmap.MarkerLayer(markers: markers),
              ],
            ),

            // 🔍 Search bar
            Positioned(
              top: 20,
              left: 16,
              right: 16,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  controller: searchController,
                  onChanged: (value) {
                    final result = controller.batikPlaces.firstWhereOrNull(
                      (place) =>
                          place.name
                              .toLowerCase()
                              .contains(value.toLowerCase()) ||
                          place.address
                              .toLowerCase()
                              .contains(value.toLowerCase()),
                    );

                    if (result != null) {
                      controller.mapController.move(
                        LatLng(result.latitude, result.longitude),
                        controller.zoom.value,
                      );
                    }
                  },
                  decoration: InputDecoration(
                    hintText: "Cari tempat batik",
                    hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontFamily: "Poppins"),
                    prefixIcon:
                        const Icon(Icons.search, size: 20, color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                  ),
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),

            // 🔍 Tombol Zoom In / Out
            Positioned(
              bottom: 90,
              right: 16,
              child: Column(
                children: [
                  FloatingActionButton(
                    heroTag: "zoom_in",
                    mini: true,
                    onPressed: controller.zoomIn,
                    child: const Icon(Icons.add),
                  ),
                  const SizedBox(height: 8),
                  FloatingActionButton(
                    heroTag: "zoom_out",
                    mini: true,
                    onPressed: controller.zoomOut,
                    child: const Icon(Icons.remove),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.getUserLocation(),
        child: const Icon(Icons.my_location),
      ),
    );
  }
}

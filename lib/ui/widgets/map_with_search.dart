import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';

import '../../blocs/localization/localization_cubit.dart';

class MapWithSearch extends StatefulWidget {
  @override
  _MapWithSearchState createState() => _MapWithSearchState();
}

class _MapWithSearchState extends State<MapWithSearch> {
  late final MapController _mapController;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  Future<void> _searchTextLocation() async {
    List<Location> locations =
        await locationFromAddress(_searchController.text);
    if (locations.isNotEmpty) {
      context.read<LocalizationCubit>().changeLocalizationLagLog(
            locations.first.latitude,
            locations.first.longitude,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocalizationCubit, LocalizationState>(
      listener: (context, state) {
        if (state is LocalizationLoaded) {
          _mapController.move(
            LatLng(state.position.latitude, state.position.longitude),
            15.0,
          );
        }
      },
      builder: (context, state) {
        LatLng? userLocation;
        if (state is LocalizationLoaded) {
          userLocation =
              LatLng(state.position.latitude, state.position.longitude);
        }

        return Card(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          hintText: 'Buscar endereço...',
                          border: OutlineInputBorder(),
                        ),
                        onEditingComplete: () {
                          _searchTextLocation();
                          FocusScope.of(context).unfocus();
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: _searchTextLocation,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: userLocation ?? const LatLng(0, 0),
                    initialZoom: 15.0,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c'],
                    ),
                    if (userLocation != null)
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: userLocation,
                            width: 80,
                            height: 80,
                            child: const Icon(
                              Icons.location_on,
                              color: Colors.red,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:here_sdk/mapview.dart';

import '../widgets/map_maker.dart';
import '../model/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;
  MapScreen({
    this.initialLocation = const PlaceLocation(
        latitude: 26.449, longitude: 80.3319, address: null),
    this.isSelecting = false,
  });
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  var _selectedLatitude;
  var _selectedLongitude;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _selectedLatitude = widget.initialLocation.latitude;
    _selectedLongitude = widget.initialLocation.longitude;
  }

  void _setLatLong(double latitude, double longitude) {
    _selectedLatitude = latitude;
    _selectedLongitude = longitude;
    // print(latitude);
    // print(longitude);
  }

  void _onMapCreated(HereMapController hereMapController) {
    hereMapController.mapScene.loadSceneForMapScheme(MapScheme.normalDay,
        (MapError error) {
      if (error == null) {
        MapMaker(hereMapController, widget.initialLocation.latitude,
            widget.initialLocation.longitude, widget.isSelecting, _setLatLong);
      } else {
        print("Map scene not loaded. MapError: " + error.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Map'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              Navigator.of(context)
                  .pop([_selectedLatitude, _selectedLongitude]);
            },
            color: Colors.white,
          ),
        ],
      ),
      body: HereMap(
        onMapCreated: _onMapCreated,
      ),
    );
  }
}

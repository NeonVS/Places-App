import 'package:flutter/material.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/mapview.dart';

import '../widgets/map_marker_example.dart';
import '../widgets/gesture_example.dart';
import '../model/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;

  MapScreen({
    this.initialLocation = const PlaceLocation(
        latitude: 26.4499, longitude: 80.3319, address: null),
    this.isSelecting = false,
  });
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  var _context;
  MapMarkerExample _mapMarkerExample;
  //
  void _onMapCreated(HereMapController hereMapController) {
    hereMapController.mapScene.loadSceneForMapScheme(MapScheme.normalDay,
        (MapError error) {
      if (error == null) {
        _mapMarkerExample = MapMarkerExample(_context, hereMapController);
        //GesturesExample(_context, hereMapController);
      } else {
        print("Map scene not loaded. MapError: " + error.toString());
      }
    });
  }

  void _anchoredMapMarkersButtonClicked() {
    _mapMarkerExample.showAnchoredMapMarkers();
  }

  void _centeredMapMarkersButtonClicked() {
    _mapMarkerExample.showCenteredMapMarkers();
  }

  void _clearButtonClicked() {
    _mapMarkerExample.clearMap();
  }

  // A helper method to add a button on top of the HERE map.
  Align button(String buttonLabel, Function callbackFunction) {
    return Align(
      alignment: Alignment.topCenter,
      child: RaisedButton(
        color: Colors.lightBlueAccent,
        textColor: Colors.white,
        onPressed: () => callbackFunction(),
        child: Text(buttonLabel, style: TextStyle(fontSize: 20)),
      ),
    );
  }

  //
  // void _onMapCreated(HereMapController hereMapController) {
  //   hereMapController.mapScene.loadSceneForMapScheme(MapScheme.normalDay,
  //       (MapError error) {
  //     if (error != null) {
  //       print('Map scene not loaded. MapError: ${error.toString()}');
  //       return;
  //     }

  //     const double distanceToEarthInMeters = 8000;
  //     hereMapController.camera.lookAtPointWithDistance(
  //         GeoCoordinates(widget.initialLocation.latitude,
  //             widget.initialLocation.longitude),
  //         distanceToEarthInMeters);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Map',
        ),
      ),
      //body: HereMap(onMapCreated: _onMapCreated),
      body: Stack(
        children: [
          HereMap(onMapCreated: _onMapCreated),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              button('Anchored', _anchoredMapMarkersButtonClicked),
              button('Centered', _centeredMapMarkersButtonClicked),
              button('Clear', _clearButtonClicked),
            ],
          ),
        ],
      ),
    );
  }
}

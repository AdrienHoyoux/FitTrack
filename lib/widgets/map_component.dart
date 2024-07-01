import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';


class map_component extends StatefulWidget {

  @override
  _map_componentState createState() => _map_componentState();
}

class _map_componentState extends State<map_component> {


  @override
  Widget build(BuildContext context) {
    return Container(
      child:
      FlutterMap(
        options: MapOptions(
          center: LatLng(51.5, -0.09),
          zoom: 13.0,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c']
          ),
          MarkerLayer(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(51.5, -0.09),
                builder: (ctx) =>
                Container(
                  child: Icon(Icons.location_on),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
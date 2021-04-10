import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import './Side_pannel.dart';
import 'package:dropdownfield/dropdownfield.dart';
import './map_screen.dart';

class HomeScreen extends StatefulWidget {
  static final routeName = '/HomeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String hospital_input = '';
  @override
  List<String> hospitals = ['orion', 'cigma'];

  Map hospitalsPos = {
    'orion': {'Lat': 30.88873400275054, 'Long': 75.7903493245303},
    'cigma': {'Lat': 19.876838649268407, 'Long': 75.34805409866875},
    // 'ghati': '19.87695128006629, 75.34426534284552',
    // 'Krishna': '19.8763530530642, 75.33659847286289',
    // 'govt hospital': '19.8763530530642, 75.33659847286289'
  };

  @override
  Widget build(BuildContext context) {
    // Future _getCurrentLocation() async {
    //   Position position = await Geolocator()
    //       .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    //   return position;
    // }

    Future everything() async {
      var position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      var a = {
        "initialPos": position,
        'destinationPos': hospitalsPos[hospital_input]
      };
      return a;
    }

    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text('Hey Ambulance!!'),
      ),
      drawer: SidePanel(),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Container(
            width: screenSize.width / 1.1,
            child: DropDownField(
              onValueChanged: (value) {
                setState(() {
                  hospital_input = value;
                });
              },
              value: hospital_input,
              required: false,
              hintText: 'Choose Hospital',
              items: hospitals,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Text(hospital_input),
          ),
          Expanded(
            child: Container(
              height: 150,
              width: 150,
              child: RaisedButton(
                onPressed: () async {
                  var a = await everything();
                  await Navigator.of(context)
                      .pushNamed(MapScreen.routeName, arguments: a);
                },
                color: Colors.deepOrange,
                textColor: Colors.white,
                shape: CircleBorder(side: BorderSide.none),
                child: Text(
                  'Call Ambulance',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

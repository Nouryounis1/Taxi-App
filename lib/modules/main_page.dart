import 'dart:io';
import 'dart:ui';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxi_app/cubit/cubit.dart';
import 'package:taxi_app/cubit/states.dart';
import 'package:taxi_app/modules/search_screen/search_screen.dart';
import 'package:taxi_app/shared/components.dart';
import 'dart:async';

import 'package:taxi_app/style/colors.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);
  static const String id = 'mainpage';
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Completer<GoogleMapController> _controller = Completer();
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  GoogleMapController? mapController;
  double searchSheetHeight = Platform.isIOS ? 300 : 275;

  var geoLocator = Geolocator();
  bool? serviceEnabled;
  LocationPermission? permission;
  List<dynamic> addresss = [];
  String? address;
  double? lat;
  double? long;
  Position? currentPosition;
  getCurrentLocation() async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled!) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    currentPosition = position;

    LatLng pos = LatLng(position.latitude, position.longitude);

    CameraPosition cp = CameraPosition(target: pos, zoom: 14);
    mapController!.animateCamera(CameraUpdate.newCameraPosition(cp));

    TaxiCubit.get(context)
        .getAdress(position.latitude, position.longitude)
        .then((value) {
      if (mounted) {
        if (TaxiCubit.get(context).addresses.isNotEmpty) {
          setState(() {
            addresss = TaxiCubit.get(context).addresses;
          });
          print('eee${addresss[0]['street']}');
        }
      }
    });
  }

  double mapPadding = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaxiCubit, TaxiStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              key: scaffoldKey,
              drawer: Container(
                  width: 250.0,
                  color: Colors.white,
                  child: Drawer(
                    child: ListView(
                      padding: EdgeInsets.all(0),
                      children: [
                        Container(
                          child: DrawerHeader(
                              child: Container(
                            height: 160.0,
                            decoration: BoxDecoration(color: Colors.white),
                            child: Row(
                              children: [
                                Image.asset(
                                  'images/user_icon.png',
                                  height: 60,
                                  width: 60,
                                ),
                                SizedBox(
                                  width: 15.0,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Username',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'Brand-Bold'),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text('View Profile'),
                                  ],
                                )
                              ],
                            ),
                          )),
                        ),
                        BrandDivider(),
                        const SizedBox(
                          height: 10,
                        ),
                        const ListTile(
                          leading: Icon(EvaIcons.giftOutline),
                          title: Text('Free Rides',
                              style: TextStyle(fontSize: 16)),
                        ),
                        const ListTile(
                          leading: Icon(EvaIcons.creditCardOutline),
                          title:
                              Text('Payments', style: TextStyle(fontSize: 16)),
                        ),
                        const ListTile(
                          leading: Icon(EvaIcons.clockOutline),
                          title: Text('Ride History',
                              style: TextStyle(fontSize: 16)),
                        ),
                        const ListTile(
                          leading: Icon(EvaIcons.questionMarkCircleOutline),
                          title:
                              Text('Support', style: TextStyle(fontSize: 16)),
                        ),
                        const ListTile(
                          leading: Icon(EvaIcons.infoOutline),
                          title: Text('About', style: TextStyle(fontSize: 16)),
                        ),
                      ],
                    ),
                  )),
              body: Stack(
                children: [
                  GoogleMap(
                    padding: EdgeInsets.only(
                      bottom: mapPadding,
                    ),
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    zoomGesturesEnabled: true,
                    zoomControlsEnabled: true,
                    mapType: MapType.normal,
                    initialCameraPosition: MainPage._kGooglePlex,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                      mapController = controller;

                      setState(() {
                        mapPadding = Platform.isAndroid ? 280 : 270;
                      });

                      getCurrentLocation();
                    },
                  ),
                  Positioned(
                    top: 70,
                    left: 20,
                    child: GestureDetector(
                      onTap: () {
                        scaffoldKey.currentState!.openDrawer();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 5.0,
                                  spreadRadius: 0.5,
                                  offset: Offset(0.7, 0.7))
                            ]),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 20,
                          child: Icon(Icons.menu),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: searchSheetHeight,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26,
                                blurRadius: 15.0,
                                spreadRadius: 0.5,
                                offset: Offset(0.7, 0.7))
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'Nice to see you!',
                              style: TextStyle(fontSize: 10),
                            ),
                            const Text(
                              'Where are you going?',
                              style: TextStyle(
                                  fontSize: 18, fontFamily: 'Brand-Bold'),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SearchScreen(
                                              currentLoation: addresss[0]
                                                  ['street'],
                                            )));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 5.0,
                                          spreadRadius: 0.5,
                                          offset: Offset(0.7, 0.7))
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    children: const [
                                      Icon(
                                        Icons.search,
                                        color: Colors.blueAccent,
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Text('Search Destination')
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 22.0,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  EvaIcons.homeOutline,
                                  color: BrandColors.colorDimText,
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    addresss.isNotEmpty
                                        ? Text('${addresss[0]['street']}')
                                        : Text('Add Home'),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      'Your residental address',
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: BrandColors.colorDimText),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            BrandDivider(),
                            const SizedBox(
                              height: 16.0,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  EvaIcons.briefcaseOutline,
                                  color: BrandColors.colorDimText,
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Add Work'),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      'Your office address',
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: BrandColors.colorDimText),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ));
        });
  }
}

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:taxi_app/cubit/cubit.dart';
import 'package:taxi_app/cubit/states.dart';
import 'package:taxi_app/shared/components.dart';
import 'package:taxi_app/style/colors.dart';

class SearchScreen extends StatefulWidget {
  final String currentLoation;
  SearchScreen({Key? key, required this.currentLoation}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var pickupController = TextEditingController();
  Position? _currentPosition;

  var destiontationController = TextEditingController();

  var foucsDestination = FocusNode();

  bool focused = false;

  void setFocus() {
    if (!focused) {
      FocusScope.of(context).requestFocus(foucsDestination);
      focused = true;
    }
  }

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    setFocus();
    _getCurrentLocation();
    pickupController.text =
        widget.currentLoation.isNotEmpty ? widget.currentLoation : '';
    return BlocConsumer<TaxiCubit, TaxiStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    height: 210,
                    decoration:
                        const BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5.0,
                          spreadRadius: 0.5,
                          offset: Offset(0.7, 0.7))
                    ]),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 24, top: 48, right: 24, bottom: 20),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Stack(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Icon(Icons.arrow_back)),
                              const Center(
                                child: Text(
                                  'Set Destination',
                                  style: TextStyle(
                                      fontSize: 20, fontFamily: 'Brand-Bold'),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          Row(
                            children: [
                              Image.asset(
                                'images/pickicon.png',
                                height: 16,
                                width: 16,
                              ),
                              SizedBox(
                                width: 18,
                              ),
                              Expanded(
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: BrandColors.colorLightGrayFair,
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: TextField(
                                          controller: pickupController,
                                          decoration: InputDecoration(
                                              hintText: 'Pickup location',
                                              fillColor: BrandColors
                                                  .colorLightGrayFair,
                                              filled: true,
                                              border: InputBorder.none,
                                              isDense: true,
                                              contentPadding: EdgeInsets.only(
                                                  left: 10, top: 8, bottom: 8)),
                                        ),
                                      )))
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: [
                              Image.asset(
                                'images/desticon.png',
                                height: 16,
                                width: 16,
                              ),
                              SizedBox(
                                width: 18,
                              ),
                              Expanded(
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: BrandColors.colorLightGrayFair,
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: TextField(
                                          onChanged: (value) {
                                            print(_currentPosition?.latitude);
                                            TaxiCubit.get(context)
                                                .getPlaceAddress(
                                                    _currentPosition!.latitude,
                                                    _currentPosition!.longitude,
                                                    value);
                                          },
                                          controller: destiontationController,
                                          focusNode: foucsDestination,
                                          decoration: InputDecoration(
                                              hintText: 'Where to?',
                                              fillColor: BrandColors
                                                  .colorLightGrayFair,
                                              filled: true,
                                              border: InputBorder.none,
                                              isDense: true,
                                              contentPadding: EdgeInsets.only(
                                                  left: 10, top: 8, bottom: 8)),
                                        ),
                                      )))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  TaxiCubit.get(context).placeAdresses.isEmpty
                      ? Container(
                          height: 0,
                          width: 0,
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          child: ListView.separated(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Container(
                                  child: Row(
                                    children: [
                                      Icon(
                                        EvaIcons.map,
                                        color: BrandColors.colorDimText,
                                      ),
                                      SizedBox(
                                        width: 12.0,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 8.0,
                                          ),
                                          Container(
                                            width: 120.0,
                                            child: Text(
                                              TaxiCubit.get(context)
                                                  .placeAdresses[index]['name'],
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                              maxLines: 1,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Container(
                                            width: 120.0,
                                            child: Text(
                                              TaxiCubit.get(context)
                                                      .placeAdresses[index]
                                                  ['displayString'],
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  color:
                                                      BrandColors.colorDimText),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8.0,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return BrandDivider();
                              },
                              itemCount: 6),
                        )
                ],
              ),
            ),
          );
        });
  }
}

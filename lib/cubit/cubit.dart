import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_app/API/api_constants.dart';
import 'package:taxi_app/cubit/states.dart';
import 'package:taxi_app/models/address_model.dart';
import 'package:taxi_app/models/place_address_model.dart';
import 'package:taxi_app/shared/dio_logs/logs.dart';
import 'package:geolocator/geolocator.dart';

class TaxiCubit extends Cubit<TaxiStates> {
  TaxiCubit() : super(TaxiInitalState());
  static TaxiCubit get(context) => BlocProvider.of(context);

  List<dynamic> addresses = [];
  List<dynamic> placeAdresses = [];
  String address = '';

  void changeAddress(String newAdress) {
    address = newAdress;
    emit(TaxiChangeAddressState());
  }

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: API_BASE_URL,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    ),
  )..interceptors.add(Logging());

  Future<Address?> getAdress(
    double lan,
    double long,
  ) async {
    Address? adreess;

    try {
      Response userData = await _dio.get(
          'https://www.mapquestapi.com/geocoding/v1/reverse?key=${API_KEY}&location=${lan},${long}&includeRoadMetadata=true&includeNearestIntersection=true');

      addresses = userData.data['results'][0]['locations'];
      print(adreess);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    }

    return adreess;
  }

  Future<PlaceAddress?> getPlaceAddress(
      double lan, double long, String? query) async {
    PlaceAddress? adreesas;

    try {
      Response userData = await _dio.get(
          'https://www.mapquestapi.com/search/v4/place?location=${lan},${long}&sort=distance&feedback=false&key=rgNgEgseA8ROD4taoM3vwwt374lBj0iu&pageSize=20&q=${query}');

      placeAdresses = userData.data['results'];
      print(placeAdresses);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    }

    return adreesas;
  }
}

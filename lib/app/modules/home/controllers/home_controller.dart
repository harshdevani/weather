import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:getx_weather/app/data/keys.dart';
import 'package:getx_weather/app/data/urls.dart';
import 'package:getx_weather/app/routes/app_pages.dart';

import '../../../data/models/whether_data_model.dart';

enum Status { initial, loading, success, error }

class HomeController extends GetxController {
  TextEditingController city = TextEditingController();
  // Map? data;

  final _data = Rx<Weather?>(null);
  Weather? get data => _data.value;
  set data(Weather? value) => _data.value = value;

  final _enum1 = Rx<Status>(Status.initial);
  Status get enum1 => _enum1.value;
  set enum1(Status value) => _enum1.value = value;

//   Future getdata() async {
//     try {
//       Get.dialog(const Center(
//         child: CircularProgressIndicator(),
//       ));
//       var dio = Dio();
//       dio.interceptors.add(LogInterceptor(
//         error: true,
//         request: true,
//         requestBody: true,
//         requestHeader: true,
//         responseBody: true,
//         responseHeader: true,
//       ));
//       var response = await dio.get(URLs.urls, queryParameters: {
//         "q": city.text,
//         "units": "metric",
//         "appid": Keys.keys,
//       });
//       data = Weather.fromJson(response.data);
//       debugPrint(response.data.toString());
//       Get.back();
//       city.clear();
//       Get.toNamed(Routes.RESULT);
//     } catch (e) {
//       Get.back();
//       var err = e as DioError;
//       Get.rawSnackbar(title: "ERROR", message: err.response?.data["message"]);
//       city.clear();
//       debugPrint(e.toString());
//     }
//   }

//   Future<Future<Object>> _determinePosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();

//     if (!serviceEnabled) {
//       return Future.error('Location services are disabled.');
//     }

//     permission = await Geolocator.checkPermission();

//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }

//     return await Geolocator.getCurrentPosition();
//   }

//   Future<void> getWeatherDataByLatLong() async {
//     try {
//       enum1 = Status.loading;
//       final position = await _determinePosition();
//       final response = await Dio().get(
//         URLs.urls,
//         queryParameters: {
//           "lat": position.latitude,
//           "lon": position.longitude,
//           "units": "metric",
//           "appid": Keys.keys,
//         },
//       );
//       enum1 = Weather.fromJson(response.data);
//       city.clear();
//       enum1 = Status.success;
//       Get.toNamed(Routes.RESULT);
//     } on DioError catch (err) {
//       city.clear();
//       Get.rawSnackbar(title: "Error", message: err.response?.data["message"]);
//       enum1 = Status.error;
//     } on MissingPluginException catch (e) {
//       Get.rawSnackbar(title: "Error", message: e.message);
//       enum1 = Status.error;
//     } catch (e) {
//       city.clear();
//       Get.rawSnackbar(title: "Error", message: e.toString());
//       enum1 = Status.error;
//     }
//   }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
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
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
  
    Future<void> getWeatherDataByLatLong() async {
      try {
        enum1 = Status.loading;
        final position = await _determinePosition();
        final response = await Dio().get(
          URLs.urls,
          queryParameters: {
            "lat": position.latitude,
            "lon": position.longitude,
            "units": "metric",
            "appid": Keys.keys,
          },
        );
        data = Weather.fromJson(response.data);
        city.clear();
        enum1 = Status.success;
        Get.toNamed(Routes.RESULT);
      } on DioError catch (err) {
        city.clear();
        Get.rawSnackbar(title: "Error", message: err.response?.data["message"]);
        enum1 = Status.error;
      } on MissingPluginException catch (e) {
        Get.rawSnackbar(title: "Error", message: e.message);
        enum1 = Status.error;
      } catch (e) {
        city.clear();
        Get.rawSnackbar(title: "Error", message: e.toString());
        enum1 = Status.error;
      }
    }

}

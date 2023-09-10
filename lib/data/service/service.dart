import 'package:get/get.dart';
import 'package:maiporarisu/data/app_constants/app_constants.dart';

class DataService extends GetConnect implements GetxService {
  Future<Response> getData(String uri) async {
    Response response = await get(
      AppConstants.baseUrl + uri,
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );

    return response;
  }

  Future<Response> postData(String uri, dynamic body) async {
    Response response = await post(
      AppConstants.baseUrl + uri,
      body,
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );

    return response;
  }
}

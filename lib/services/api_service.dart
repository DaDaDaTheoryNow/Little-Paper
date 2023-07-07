import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiService {
  Dio dio = Dio();
  CancelToken cancelToken = CancelToken();

  Future<String> fetchData(int limit, String tags, int page) async {
    String baseUrl = "safebooru.org";

    final url =
        'https://$baseUrl?page=dapi&s=post&q=index&limit=$limit&tags=$tags&pid=$page';

    final response = await dio.get(
      url,
      cancelToken: cancelToken,
    );

    debugPrint(url.toString());

    if (response.statusCode == 200) {
      return response.data;
    } else {
      debugPrint('Ошибка: ${response.statusCode}');
      return 'Ошибка: ${response.statusCode}';
    }
  }

  void cancelFetchingData() {
    cancelToken.cancel("Request Cancelled");
    cancelToken = CancelToken();
  }
}

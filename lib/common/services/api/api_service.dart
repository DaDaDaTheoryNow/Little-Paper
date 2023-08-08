import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiService {
  final Dio dio;

  ApiService() : dio = Dio();

  Future<String> fetchData(int limit, String tags, int page) async {
    try {
      final url = _buildUrl(limit, tags, page);

      final response = await _getResponse(url);

      if (response.statusCode == 200) {
        return response.data;
      } else {
        debugPrint('Error: ${response.statusCode}');
        return 'Error: ${response.statusCode}';
      }
    } catch (error) {
      debugPrint('Error: $error');
      return 'Error: $error';
    }
  }

  void cancelFetchingData() {
    _getCancelToken().cancel("Request Cancelled");
  }

  Future<Response<dynamic>> _getResponse(String url) async {
    return await dio.get(
      url,
      cancelToken: _getCancelToken(),
    );
  }

  String _buildUrl(int limit, String tags, int page) {
    const baseUrl = "safebooru.org";

    return 'https://$baseUrl?page=dapi&s=post&q=index&limit=$limit&tags=$tags&pid=$page';
  }

  CancelToken _getCancelToken() {
    return CancelToken();
  }
}

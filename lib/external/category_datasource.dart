import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cashflow/core/settings.dart';
import 'package:cashflow/domain/domain.dart';

class CategoryDatasource implements ICategoryDatasource {
  final ISettings settings;
  http.Client client = http.Client();

  CategoryDatasource({required this.settings});

  List<CategoryEntity> mapFromResponse(http.Response response) {
    final categories = jsonDecode(utf8.decode(response.bodyBytes)) as List;
    return categories
        .map<CategoryEntity>((category) => CategoryEntity.fromJson(category))
        .toList();
  }

  @override
  Future<List<CategoryEntity>> read() async {
    final endpoint = settings.endpointByName(EndpointConstants.getCategories);
    try {
      final response = await client.get(Uri.parse(endpoint));
      return mapFromResponse(response);
    } catch (e) {
      print(e);
    }

    return [];
  }

  @override
  Future<List<CategoryEntity>> update(List<CategoryEntity> categories) async {
    try {
      final body = categories.map((item) => item.toJson()).toList();
      final response = await client.put(
          Uri.parse(settings.endpointByName(EndpointConstants.saveCategories)),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8'
          },
          body: jsonEncode(body));

      return mapFromResponse(response);
    } catch (e) {
      print(e);
      // TODO: tratar erro e code <> 200
    }
    return [];
  }

  @override
  Future<bool> deleteById(String id) async {
    try {
      await client.delete(
          Uri.parse(settings.endpointByName(
              EndpointConstants.deleteCategory).replaceAll('{id}', id)),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8'
          });
      return true;
    } catch (e) {
      return false;
    }
  }
}

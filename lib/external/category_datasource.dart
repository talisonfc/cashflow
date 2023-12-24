import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cashflow/core/settings.dart';
import 'package:cashflow/domain/_exports.dart';

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
      final response = await client.get(Uri.parse(endpoint), headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.accessControlAllowOriginHeader: '*'
      });
      return mapFromResponse(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<CategoryEntity> create(CategoryEntity category) async {
    try {
      final response = await client.post(
          Uri.parse(settings.endpointByName(EndpointConstants.saveCategory)),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8'
          },
          body: jsonEncode(category.toJson()));

      return CategoryEntity.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw e;
    }
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
          Uri.parse(settings
              .endpointByName(EndpointConstants.deleteCategory)
              .replaceAll('{id}', id)),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8'
          });
      return true;
    } catch (e) {
      return false;
    }
  }
}

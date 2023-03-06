import 'dart:convert';

import 'package:cashflow/core/settings.dart';
import 'package:http/http.dart' as http;
import 'package:cashflow/domain/domain.dart';

class OriginDatasource extends IOriginDatasource {
  final http.Client client = http.Client();
  final ISettings settings;

  OriginDatasource({required this.settings});

  List<OriginEntity> mapContextsFromResponse(http.Response response) {
    if (response.bodyBytes.isEmpty) return [];
    final contexts = jsonDecode(utf8.decode(response.bodyBytes)) as List;
    return contexts
        .map<OriginEntity>((context) => OriginEntity.fromJson(context))
        .toList();
  }

  @override
  Future<List<OriginEntity>> getOrigins() async {
    try {
      final result = await client.get(
          Uri.parse(settings.endpointByName(EndpointConstants.getOrigins)));
      return mapContextsFromResponse(result);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<bool> deleteOriginById(String id) async {
    try {
      final endpoint =
          settings.endpointByName(EndpointConstants.deleteOrigin).replaceAll(
                '{id}',
                id,
              );
      final result = await client.delete(Uri.parse(endpoint));
      return jsonDecode(utf8.decode(result.bodyBytes));
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<OriginEntity>> updateOrigins(List<OriginEntity> origins) async {
    try {
      final body = origins.map((origin) => origin.toJson()).toList();
      final endpoint = settings.endpointByName(EndpointConstants.saveOrigin);
      final result = await client.put(
        Uri.parse(endpoint),
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'},
      );
      return mapContextsFromResponse(result);
    } catch (e) {
      throw Exception(e);
    }
  }
}

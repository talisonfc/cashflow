import 'dart:convert';
import 'dart:io';
import 'package:cashflow/core/core.dart';
import 'package:http/http.dart' as http;

import 'package:cashflow/domain/domain.dart';

class ContextDatasource implements IContextDatasource {
  final http.Client client = http.Client();
  final ISettings settings;

  ContextDatasource({required this.settings});

  List<ContextEntity> mapContextsFromResponse(http.Response response) {
    final contexts = jsonDecode(utf8.decode(response.bodyBytes)) as List;
    return contexts
        .map<ContextEntity>((context) => ContextEntity.fromJson(context))
        .toList();
  }

  @override
  Future<List<ContextEntity>> read() async {
    final response = await client.get(
        Uri.parse(settings.endpointByName(EndpointConstants.getContexts)));
    return mapContextsFromResponse(response);
  }

  @override
  Future<List<ContextEntity>> update(List<ContextEntity> contexts) async {
    final response = await client.put(
        Uri.parse(settings.endpointByName(EndpointConstants.saveContexts)),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8'
        },
        body: jsonEncode(contexts.map((ctx) => ctx.toJson()).toList()));
    return mapContextsFromResponse(response);
  }

  @override
  Future<bool> deleteById(String id) async {
    final response = await client.delete(Uri.parse(settings
        .endpointByName(EndpointConstants.deleteContext)
        .replaceAll('{id}', id)));
    return response.statusCode == HttpStatus.ok;
  }
}

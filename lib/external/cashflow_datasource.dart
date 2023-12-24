import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cashflow/core/settings.dart';
import 'package:cashflow/domain/_exports.dart';

class CashflowDatasource implements ICashflowDatasource {
  final ISettings settings;
  http.Client client = http.Client();

  CashflowDatasource({required this.settings});

  @override
  Future<CashflowDefinitionEntity> create(
      CashflowDefinitionEntity cashflowDefinition) async {
    final endpoint = settings.endpointByName(EndpointConstants.saveCashflow);
    try {
      final response = await client.post(Uri.parse(endpoint),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8'
          },
          body: jsonEncode(cashflowDefinition.toJson()));

      if (response.statusCode != 200) throw Exception(response.body);
      return CashflowDefinitionEntity.fromJson(jsonDecode(response.body));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<CashflowDefinitionEntity>> readByUser({String? userId}) async {
    final endpoint = settings.endpointByName(EndpointConstants.getCashflows) +
        '?userId=$userId';
    try {
      final response = await client.get(Uri.parse(endpoint), headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.accessControlAllowOriginHeader: '*'
      });
      if (response.statusCode != 200) throw Exception(response.body);
      return mapFromResponse(response);
    } catch (e) {
      rethrow;
    }
  }

  List<CashflowDefinitionEntity> mapFromResponse(http.Response response) {
    final cashflows = jsonDecode(utf8.decode(response.bodyBytes));
    return cashflows
        .map<CashflowDefinitionEntity>(
            (category) => CashflowDefinitionEntity.fromJson(category))
        .toList();
  }
}

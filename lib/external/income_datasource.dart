import 'dart:convert';
import 'dart:io';

import 'package:cashflow/core/settings.dart';
import 'package:http/http.dart' as http;
import 'package:cashflow/domain/_exports.dart';

class IncomeDatasource implements IIncomeDatasource {
  final client = http.Client();
  final ISettings settings;

  IncomeDatasource({required this.settings});

  @override
  Future<List<IncomeEntity>> readByCashflow(
      {required String cashflowId,
      DateTime? startDate,
      DateTime? endDate}) async {
    try {
      final params = {
        "CashflowId": cashflowId,
        if (startDate != null) "StartDate": startDate.toUtc().toIso8601String(),
        if (endDate != null) "EndDate": endDate.toUtc().toIso8601String()
      };

      final queries = params.entries
          .map((entry) => '${entry.key}=${entry.value}')
          .join('&');

      final endpoint =
          '${settings.endpointByName(EndpointConstants.getIncomes)}?$queries';
      final result = await client.get(Uri.parse(endpoint));
      final incomes = jsonDecode(utf8.decode(result.bodyBytes)) as List;
      return incomes.map((incomes) => IncomeEntity.fromJson(incomes)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<IncomeEntity> save(IncomeEntity incomeEntity) async {
    try {
      final body = incomeEntity.toJson();
      final endpoint = settings.endpointByName(EndpointConstants.saveIncome);
      final result = await client.post(Uri.parse(endpoint),
          body: jsonEncode(body),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8'
          });
      return IncomeEntity.fromJson(jsonDecode(utf8.decode(result.bodyBytes)));
    } catch (e) {
      throw Exception(e);
    }
  }
}

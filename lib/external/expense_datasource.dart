import 'dart:convert';
import 'dart:io';

import 'package:cashflow/core/settings.dart';
import 'package:http/http.dart' as http;

import 'package:cashflow/domain/domain.dart';

class ExpenseDatasource implements IExpenseDatasource {
  final http.Client client = http.Client();
  final ISettings settings;

  ExpenseDatasource({required this.settings});

  @override
  Future<List<ExpenseEntity>> read(
      {DateTime? startDate, DateTime? endDate}) async {
    try {
      final params = {
        if (startDate != null) "StartDate": startDate.toUtc().toIso8601String(),
        if (endDate != null) "EndDate": endDate.toUtc().toIso8601String()
      };

      final queries = params.entries
          .map((entry) => '${entry.key}=${entry.value}')
          .join('&');

      final response = await client.get(Uri.parse(
          '${settings.endpointByName(EndpointConstants.getExpenses)}?$queries'));
      final expenses = jsonDecode(utf8.decode(response.bodyBytes)) as List;
      return expenses
          .map<ExpenseEntity>((expense) => ExpenseEntity.fromJson(expense))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ExpenseEntity> save(ExpenseEntity expense) async {
    try {
      final body = expense.toJson();
      final response = await client.post(
          Uri.parse(settings.endpointByName(EndpointConstants.saveExpense)),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8'
          },
          body: jsonEncode(body));
      return ExpenseEntity.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ExpenseEntity> update(ExpenseEntity expense) async {
    try {
      final response = await client.put(
          Uri.parse(settings.endpointByName(EndpointConstants.saveExpense)),
          body: jsonEncode(expense.toJson()));
      return ExpenseEntity.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));
    } catch (e) {
      throw Exception(e);
    }
  }
}

import 'package:cashflow/domain/_exports.dart';

class IncomeEntity extends TransactionEntity {
  final String? id;
  final String name;
  final String? originId;
  final double value;
  final DateTime? when;
  final String? cashflowId;

  IncomeEntity(
      {required this.name,
      this.id,
      this.cashflowId,
      this.originId,
      this.when,
      this.value = 0.0});

  factory IncomeEntity.fromJson(Map<String, dynamic> json) {
    return IncomeEntity(
        id: json['id'],
        name: json['name'],
        originId: json['originId'],
        cashflowId: json['cashflowId'],
        when: DateTime.parse(json['when']),
        value: json['value'] is int
            ? (json['value'] as int).toDouble()
            : json['value']);
  }

  factory IncomeEntity.fromFormGroup(Map<String, dynamic> formGroup) {
    return IncomeEntity(
        name: formGroup['name'],
        originId: formGroup['originId'],
        when: formGroup['when'],
        value: formGroup['value']);
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null && id!.isNotEmpty) 'id': id,
      'name': name,
      'originId': originId,
      'cashflowId': cashflowId,
      'when': when?.toUtc().toIso8601String(),
      'value': value
    };
  }

  IncomeEntity copyWith(
      {String? id,
      String? name,
      String? originId,
      String? cashflowId,
      DateTime? when,
      double? value}) {
    return IncomeEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        originId: originId ?? this.originId,
        cashflowId: cashflowId ?? this.cashflowId,
        when: when ?? this.when,
        value: value ?? this.value);
  }
}

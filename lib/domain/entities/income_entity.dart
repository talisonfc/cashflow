class IncomeEntity {
  final String? id;
  final String name;
  final String? originId;
  final double value;
  final DateTime? when;

  IncomeEntity(
      {required this.name,
      this.id,
      this.originId,
      this.when,
      this.value = 0.0});

  factory IncomeEntity.fromJson(Map<String, dynamic> json) {
    return IncomeEntity(
        id: json['id'],
        name: json['name'],
        originId: json['originId'],
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
      'when': when?.toUtc().toIso8601String(),
      'value': value
    };
  }
}

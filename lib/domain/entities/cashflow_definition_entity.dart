class CashflowDefinitionEntity {
  CashflowDefinitionEntity({
    this.id,
    this.name,
    this.userId,
  });

  factory CashflowDefinitionEntity.fromJson(Map<String, dynamic> json) =>
      CashflowDefinitionEntity(id: json['id'], name: json['name']);

  final String? id;
  final String? name;
  final String? userId;

  CashflowDefinitionEntity copyWith({
    String? id,
    String? name,
    String? userId,
  }) =>
      CashflowDefinitionEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        userId: userId ?? this.userId,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'userId': userId,
      };
}

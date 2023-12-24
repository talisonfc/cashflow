import '_exports.dart';

class ExpenseEntity extends TransactionEntity {
  final String? id;
  final String description;
  final double value;
  late DateTime when;
  final SellerEntity seller;
  final String? categoryId, contextId, cashflowId;
  final List<TagEntity> tags;

  ExpenseEntity(
      {this.id,
      this.description = '',
      this.cashflowId,
      this.value = 0.0,
      DateTime? when,
      this.seller = const SellerEntity(),
      this.categoryId,
      this.contextId,
      this.tags = const <TagEntity>[]}) {
    this.when = when ?? DateTime.now();
  }

  factory ExpenseEntity.fromJson(Map<String, dynamic> json) {
    return ExpenseEntity(
      id: json['id'],
      description: json['description'],
      value: json['value'] is int ? json['value'].toDouble() : json['value'],
      when: DateTime.parse(json['when']),
      cashflowId: json['cashflowId'],
      // seller: SellerEntity.fromJson(json['seller']),
      categoryId: json['categoryId'],
      contextId: json['contextId'],
      // tags: (json['tags'] as List).map((tag) => TagEntity.fromJson(tag)).toList()
    );
  }

  factory ExpenseEntity.fromFormGroup(Map<String, dynamic> form) {
    return ExpenseEntity(
      id: form['id'],
      description: form['description'],
      value: form['value'],
      when: form['when'],
      // seller: SellerEntity.fromJson(json['seller']),
      categoryId: form['categoryId'],
      contextId: form['contextId'],
      // tags: (json['tags'] as List).map((tag) => TagEntity.fromJson(tag)).toList()
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'description': description,
      'value': value,
      'when': when.toUtc().toIso8601String(),
      // 'seller': seller.toJson(),
      'categoryId': categoryId,
      'contextId': contextId,
      'cashflowId': cashflowId,
      // 'tags': tags.map((tag) => tag.toJson()).toList()
    };
  }

  ExpenseEntity copyWith(
      {String? id,
      String? description,
      double? value,
      DateTime? when,
      String? categoryId,
      String? contextId,
      String? cashflowId}) {
    return ExpenseEntity(
      id: id ?? this.id,
      description: description ?? this.description,
      value: value ?? this.value,
      when: when ?? this.when,
      categoryId: categoryId ?? this.categoryId,
      contextId: contextId ?? this.contextId,
      cashflowId: cashflowId ?? this.cashflowId,
    );
  }

  // String toUtc(){
  //   2023-02-25T08:01:00

  // }
}

import 'entites.dart';

class ExpenseEntity {
  final String description;
  final double value;
  late DateTime when;
  final SellerEntity seller;
  final String? categoryId, contextId;
  final List<TagEntity> tags;

  ExpenseEntity(
      {this.description = '',
      this.value = 0.0,
      DateTime? when,
      this.seller = const SellerEntity(),
      this.categoryId,
      this.contextId,
      this.tags = const <TagEntity>[]}) {
    this.when = when ?? DateTime.now();
  }

  factory ExpenseEntity.fromJson(Map<String, dynamic> json){
    return ExpenseEntity(
      description: json['description'],
      value: json['value'] is int ? json['value'].toDouble() : json['value'],
      when: DateTime.parse(json['when']),
      // seller: SellerEntity.fromJson(json['seller']),
      categoryId: json['categoryId'],
      contextId: json['contextId'],
      // tags: (json['tags'] as List).map((tag) => TagEntity.fromJson(tag)).toList()
    );
  }

  factory ExpenseEntity.fromFormGroup(Map<String, dynamic> form){
    return ExpenseEntity(
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
      'description': description,
      'value': value,
      'when': when.toUtc().toIso8601String(),
      // 'seller': seller.toJson(),
      'categoryId': categoryId,
      'contextId': contextId,
      // 'tags': tags.map((tag) => tag.toJson()).toList()
    };
  }

  // String toUtc(){
  //   2023-02-25T08:01:00

  // }
}



class SellerEntity {
  final String? id;
  final String name;

  const SellerEntity({this.id, this.name = ''});

  factory SellerEntity.fromJson(Map<String, dynamic> json) {
    return SellerEntity(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
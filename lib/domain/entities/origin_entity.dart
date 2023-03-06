class OriginEntity {
  final String? id;
  final String name;

  const OriginEntity({this.id, this.name = ''});

  factory OriginEntity.fromJson(Map<String, dynamic> json) {
    return OriginEntity(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null && id!.isNotEmpty) 'id': id,
      'name': name,
    };
  }
}

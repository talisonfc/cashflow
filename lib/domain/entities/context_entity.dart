class ContextEntity {
  final String? id;
  final String name;

  const ContextEntity({this.id, this.name = ''});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContextEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  ContextEntity copyWith({String? id, String? name}) {
    return ContextEntity(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  factory ContextEntity.fromJson(Map<String, dynamic> json) {
    return ContextEntity(
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

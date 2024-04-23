class category {
  String? id;
  final String name;
  final String? parentCategoryId;

  category({
    required this.name,
    this.id,
    this.parentCategoryId,
  });

  factory category.fromJson(Map<String, dynamic> json) {
    category a = category(
      name: json['name'],
      parentCategoryId: json['parentCategoryId'],
    );
    a.id = json['id'];
    return a;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'parentCategoryId': parentCategoryId,
    };
  }
}

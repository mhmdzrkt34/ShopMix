class category {
  late String? id;
  final String name;
  final String? parentCategoryId;

  category({
    required this.name,
    this.id,
    this.parentCategoryId,
  });

  factory category.fromJson(Map<String, dynamic> json, String idd) {
    category a = category(
      id: idd,
      name: json['name'],
      parentCategoryId: json['parentCategoryId'],
    );
    return a;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'parentCategoryId': parentCategoryId,
    };
  }
}

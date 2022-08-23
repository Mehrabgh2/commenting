class Product {
  Product({
    required this.id,
    required this.title,
    required this.link,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      link: json['link'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['link'] = link;
    return data;
  }

  factory Product.fromServerJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title']['rendered'],
      link: json['link'],
    );
  }

  int id;
  String title;
  String link;
}

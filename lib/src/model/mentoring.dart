class Mentoring {

  final String description;
  final String image;
  final String name;
  final String detail;
  final int price;

  Mentoring({
 
    required this.name,
    required this.description,
    required this.image,
    required this.detail,
    required this.price

  });

  factory Mentoring.fromJson(Map<String, dynamic> json) {
    return Mentoring(
      name: json['name'],
      description: json['description'],
      image: json['image'],
      detail: json['detail'],
      price: json['price']
    );
  }
}
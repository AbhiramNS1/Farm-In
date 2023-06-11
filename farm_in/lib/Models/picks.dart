class Picks {
  int id;
  String name;
  int price;
  int? quantity;
  int? holdingsId;
  int? timePeroid;
  String? category;

  Picks({
    required this.id,
    required this.name,
    required this.price,
    this.quantity,
    this.holdingsId,
    this.category,
    this.timePeroid,
  });

  int get totalInvested {
    if (quantity == null) {
      return price;
    } else {
      return price * quantity!;
    }
  }

  factory Picks.fromJson(Map<String, dynamic> json) {
    return Picks(
        id: json['id'],
        name: json['name'],
        category: json['category'],
        quantity: json['qty'],
        price: json['price']);
  }
  factory Picks.holdingsFromJson(Map<String, dynamic> json) {
    return Picks(
      id: json['id'],
      name: json['name'],
      price: double.parse(json['market_price'].toString()).toInt(),
      quantity: json["qty"],
      timePeroid: json["time_peroid"],
      holdingsId: json["h_id"],
    );
  }
}

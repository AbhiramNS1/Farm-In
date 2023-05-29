class Picks {
  int id;
  String name;
  String symbol;
  int todaysPrice;
  int timeperoid;
  String todaysChange;
  int? quantity;
  int? holdingsId;
  int? contractAddress;
  int? timePeroid;
  int? totalProfit;

  Picks(
      {required this.id,
      required this.name,
      required this.symbol,
      required this.timeperoid,
      required this.todaysPrice,
      required this.todaysChange,
      this.quantity,
      this.holdingsId,
      this.timePeroid,
      this.totalProfit});

  int get totalInvested {
    if (quantity == null) {
      return todaysPrice;
    } else {
      return todaysPrice * quantity!;
    }
  }

  factory Picks.fromJson(Map<String, dynamic> json) {
    return Picks(
        id: json['id'],
        name: json['name'],
        symbol: json['symbol'],
        timeperoid: json['time_peroid'],
        todaysChange: json["todays_change"],
        todaysPrice: json["todays_price"]);
  }
  factory Picks.holdingsFromJson(Map<String, dynamic> json) {
    return Picks(
        id: json['id'],
        name: json['name'],
        symbol: json['symbol'],
        timeperoid: json['time_peroid'],
        todaysChange: json["todays_change"],
        todaysPrice: json["todays_price"],
        quantity: json["qty"],
        timePeroid: json["time_peroid"],
        totalProfit: json["profit"]);
  }
}

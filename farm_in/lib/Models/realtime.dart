class RealTimeValues {
  final String attribute;
  final String value;
  const RealTimeValues({required this.value, required this.attribute});
  static List values = [
    RealTimeValues(value: "30°C", attribute: "Temperature"),
    RealTimeValues(value: "10%", attribute: "Humidity"),
    RealTimeValues(value: "1atm", attribute: "Pressure"),
    RealTimeValues(value: "10%", attribute: "Soil Moisture")
  ];
}

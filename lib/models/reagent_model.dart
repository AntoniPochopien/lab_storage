class ReagentModel {
  int id;
  String reagentName; //nazwa odczynnika
  double mass; //gramatura
  String
      measurement; //oznaczenie miary do gramatury ^ Litry gramy kilogramy itp
  DateTime date;
  String financing;
  double price;
  String name; //imie kogos?

  ReagentModel({
    required this.id,
    required this.reagentName,
    required this.mass,
    required this.measurement,
    required this.date,
    required this.financing,
    required this.price,
    required this.name,
  });
}

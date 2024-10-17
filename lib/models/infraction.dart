class Infraction {
  int id;
  String falta;
  String infraccion;
  String calificacion;
  String monto;
  String conDescuento;
  String sancion;
  String puntos;
  String medidaPreventiva;
  String solidario;

  Infraction({
    required this.id,
    required this.falta,
    required this.infraccion,
    required this.calificacion,
    required this.monto,
    required this.conDescuento,
    required this.sancion,
    required this.puntos,
    required this.medidaPreventiva,
    required this.solidario,
  });

  Map<String, dynamic> toMap() => {
        "id": id,
        "falta": falta,
        "infraccion": infraccion,
        "calificacion": calificacion,
        "monto": monto,
        "conDescuento": conDescuento,
        "sancion": sancion,
        "puntos": puntos,
        "medidaPreventiva": medidaPreventiva,
        "solidario": solidario,
      };

  factory Infraction.fromMap(Map<String, dynamic> map) => Infraction(
        id: map['id'],
        falta: map['falta'],
        infraccion: map['infraccion'],
        calificacion: map['calificacion'],
        monto: map['monto'],
        conDescuento: map['conDescuento'],
        sancion: map['sancion'],
        puntos: map['puntos'],
        medidaPreventiva: map['medidaPreventiva'],
        solidario: map['solidario'],
      );
}

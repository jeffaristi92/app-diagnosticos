class Diagnosticos {
  List<Diagnostico> items = new List();

  Diagnosticos();

  Diagnosticos.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final diagnostico = new Diagnostico.fromJsonMap(item);
      items.add(diagnostico);
    }
  }
}

class Diagnostico {
  int testId;
  DateTime fecha;
  int sexo;
  int edad;
  int etnia;
  int grupoPoblacional;
  int comorbilidad;
  bool malnutricion;
  int contactos;
  int contactosSR;
  int contactosSRExaminadosconBK;
  int contactosMenores5Anios;
  int vihConfirmado;
  int recibeTar;
  int recibeTrimetoprim;
  int rDOBKDX;
  int pacienteId;
  bool resultado;
  bool aprobadoPorMedico;
  String paciente;

  Diagnostico(
      {this.testId,
      this.fecha,
      this.sexo,
      this.edad,
      this.etnia,
      this.grupoPoblacional,
      this.comorbilidad,
      this.malnutricion,
      this.contactos,
      this.contactosSR,
      this.contactosSRExaminadosconBK,
      this.contactosMenores5Anios,
      this.vihConfirmado,
      this.recibeTar,
      this.recibeTrimetoprim,
      this.rDOBKDX,
      this.pacienteId,
      this.resultado,
      this.aprobadoPorMedico,
      this.paciente});

  Diagnostico.fromJsonMap(Map<String, dynamic> json) {
    testId = json['testId'];
    fecha = DateTime.parse(json['fecha']);
    sexo = json['sexo'];
    edad = json['edad'];
    etnia = json['etnia'];
    grupoPoblacional = json['grupoPoblacional'];
    comorbilidad = json['comorbilidad'];
    malnutricion = json['malnutricion'];
    contactos = json['contactos'];
    contactosSR = json['contactosSR'];
    contactosSRExaminadosconBK = json['contactosSRExaminadosconBK'];
    contactosMenores5Anios = json['contactosMenores5Anios'];
    vihConfirmado = json['vihConfirmado'];
    recibeTar = json['recibeTar'];
    recibeTrimetoprim = json['recibeTrimetoprim'];
    rDOBKDX = json['rDOBKDX'];
    pacienteId = json['pacienteId'];
    resultado = json['resultado'];
    aprobadoPorMedico = json['aprobadoPorMedico'];
    paciente = json['paciente'];
  }
}

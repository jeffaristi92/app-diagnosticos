import 'package:app_diagnosticos/src/models/diagnostico_model.dart';
import 'package:app_diagnosticos/src/providers/diagnosticos_provider.dart';
import 'package:flutter/material.dart';
import 'package:app_diagnosticos/src/utils/utils.dart' as utils;
import 'package:intl/intl.dart';

class ExamenPage extends StatefulWidget {
  @override
  _ExamenPageState createState() => _ExamenPageState();
}

class _ExamenPageState extends State<ExamenPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final diagnosticoProvider = new DiagnosticosProvider();
  bool _obteniendoPrediccion = false;
  bool guardarDiagnostico = false;
  bool aprobadoPorMedico = true;

  DateTime _fechaNacimiento;
  String _fechaNacimientoString = '';
  String _tipoSexo = 'Femenino';
  String _edad = "0";
  String _etnia = 'Otro';
  String _grupoPoblacional = 'Ninguno';
  String _coomorbilidad = 'Ninguna';
  bool _malnutricion = false;
  String _contactos = "";
  String _contactosSR = "";
  String _contactosSRExaminadosconBK = "";
  String _contactosMenores5Anios = "";
  String _vihConfirmado = 'Negativo';
  String _recibeTar = 'No Aplica';
  String _recibeTrimetoprim = 'No Aplica';
  String _rdobxdx = '-';

  List<String> _tiposSexo = ['Femenino', 'Masculino'];
  List<String> _tiposVihConfirmado = ['No realizado', 'Positivo', 'Negativo'];
  List<String> _tiposEtnia = ['Indigena', 'Afro descendiente', 'Otro'];
  List<String> _tiposGrupoPoblacional = [
    'Trabajador de la salud',
    'Habitante de calle',
    'Trastorno del consumo de sustancias psicoactivas',
    'Población carcelaria',
    'Ninguno'
  ];
  List<String> _tiposComorbilidad = [
    'Enfermedad Renal',
    'Otras Inmunosupresiones',
    'Hipertension',
    'Diabetes',
    'Otra enfermedad pulmonar',
    'Ninguna'
  ];
  List<String> _tiposRecibeTar = [];
  List<String> _tiposRecibeTrimetoprim = [];
  List<String> _tiposRdoBkDx = [
    'No Realizado',
    'Positivo1a9Baar',
    '+++',
    '++',
    '+',
    '-'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Diagnostico Tuberculosis'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15.0),
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  _crearListaTipoSexo(),
                  Divider(),
                  _getCampoEdad(context),
                  Divider(),
                  _getListaTipoEtnia(),
                  Divider(),
                  _getListaGrupoPoblacional(),
                  Divider(),
                  _getListaCoomorbilidad(),
                  Divider(),
                  _getCampoMalnutricion(),
                  Divider(),
                  _getCampoContactos(),
                  Divider(),
                  _getCampoContactosSR(),
                  Divider(),
                  _getCampoContactosSRExaminadosconBK(),
                  Divider(),
                  _getCampoContactosMenores5Anios(),
                  Divider(),
                  _getCampoVihConfirmado(),
                  Divider(),
                  _getCampoRecibeTar(),
                  Divider(),
                  _getCampoRecibeTrimetoprim(),
                  Divider(),
                  _getCampoRdoBkDx(),
                  Divider(),
                  _crearBoton()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearBoton() {
    return RaisedButton.icon(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        color: Colors.blue,
        textColor: Colors.white,
        label: Text('Obtener Diagnóstico'),
        icon: Icon(Icons.save),
        onPressed: (_obteniendoPrediccion) ? null : _submit);
  }

  void _submit() async {
    if (!formKey.currentState.validate()) {
      return;
    }

    if (_fechaNacimientoString.isEmpty) {
      displayDialog('Error', 'Ingrese la fecha de naciemiento');
      return;
    }

    setState(() {
      _obteniendoPrediccion = true;
    });

    Diagnostico diagnostico = getDiagnosticoModel();

    DiagnosticoResponse response =
        await diagnosticoProvider.getPrediction(diagnostico);
    diagnostico.resultado = response.result;

    var guardarDiagnostico = await displayPredictionDialog(
        "Resultado: ${response.result ? 'Positivo' : 'Negativo'}",
        '¿Desea guardar el diagnostico');

    if (guardarDiagnostico) {
      var aprobadoPorMedico = await displayPredictionDialog(
          '¿Aprueba el diagnostico?',
          'Nota: Esta información servirá para mejorar el modelo de predicción');
      diagnostico.aprobadoPorMedico = aprobadoPorMedico;

      var result = await diagnosticoProvider.guardarDiagnostico(diagnostico);

      mostrarSnackbar(
          "${result ? 'Diagnostico guardado exitosamente' : 'Ha ocurrido un error'}");
    }

    setState(() {
      _obteniendoPrediccion = false;
    });
  }

  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  void displayDialog(title, text) => showDialog(
        context: scaffoldKey.currentContext,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );

  Future<bool> displayPredictionDialog(String title, String content) async {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text('No'),
      onPressed: () {
        setState(() {
          Navigator.pop(scaffoldKey.currentContext, false);
        });
      },
    );
    Widget continueButton = FlatButton(
      child: Text('Si'),
      onPressed: () {
        setState(() {
          Navigator.pop(scaffoldKey.currentContext, true);
        });
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    return showDialog(
        barrierDismissible: false,
        context: scaffoldKey.currentContext,
        builder: (context) {
          return alert;
        });
  }

  Widget _getCampoEdad(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text('Fecha de nacimiento:',
                style: TextStyle(fontSize: 16, color: Colors.grey)),
            SizedBox(
              width: 10.0,
            ),
            Text(
                _fechaNacimiento == null
                    ? ''
                    : DateFormat('dd-MM-yyyy').format(_fechaNacimiento),
                style: TextStyle(fontSize: 17)),
          ],
        ),
        Divider(),
        RaisedButton(
          child: Text('Seleccionar fecha'),
          onPressed: () {
            showDatePicker(
                    context: context,
                    initialDate: _fechaNacimiento == null
                        ? DateTime.now()
                        : _fechaNacimiento,
                    firstDate: DateTime(1930),
                    lastDate: DateTime(2021))
                .then((date) {
              setState(() {
                _fechaNacimiento = date;
                _fechaNacimientoString = date.toString();
              });
            });
          },
        ),
      ],
    );
  }

  Widget _crearListaTipoSexo() {
    // return Row(
    //   children: <Widget>[
    //     Text('Sexo'),
    //     SizedBox(
    //       width: 30.0,
    //     ),
    //     Expanded(
    //       child: DropdownButtonFormField(
    //         decoration: InputDecoration(labelText: 'Sexo'),
    //         value: _tipoSexo,
    //         items: getOpcionesDropdown(_tiposSexo),
    //         onChanged: (opt) {
    //           setState(() {
    //             _tipoSexo = opt;
    //           });
    //         },
    //       ),
    //     )
    //   ],
    // );

    return DropdownButtonFormField(
      decoration: InputDecoration(labelText: 'Sexo'),
      value: _tipoSexo,
      items: getOpcionesDropdown(_tiposSexo),
      onChanged: (opt) {
        setState(() {
          _tipoSexo = opt;
        });
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo requerido';
        } else {
          return null;
        }
      },
    );
  }

  Widget _getListaTipoEtnia() {
    return Row(
      children: <Widget>[
        // Text('Etnia'),
        // SizedBox(
        //   width: 30.0,
        // ),
        Expanded(
          child: DropdownButtonFormField(
            decoration: InputDecoration(labelText: 'Etnia'),
            value: _etnia,
            items: getOpcionesDropdown(_tiposEtnia),
            onChanged: (opt) {
              setState(() {
                _etnia = opt;
              });
            },
            validator: (value) {
              if (value.isEmpty) {
                return 'Campo requerido';
              } else {
                return null;
              }
            },
          ),
        )
      ],
    );
  }

  Widget _getListaGrupoPoblacional() {
    return Row(
      children: <Widget>[
        // Text('Grupo Poblacional'),
        // SizedBox(
        //   width: 30.0,
        // ),
        Expanded(
          child: DropdownButtonFormField(
            decoration: InputDecoration(labelText: 'Grupo Poblacional'),
            value: _grupoPoblacional,
            items: getOpcionesDropdown(_tiposGrupoPoblacional),
            onChanged: (opt) {
              setState(() {
                _grupoPoblacional = opt;
              });
            },
            validator: (value) {
              if (value.isEmpty) {
                return 'Campo requerido';
              } else {
                return null;
              }
            },
          ),
        )
      ],
    );
  }

  Widget _getListaCoomorbilidad() {
    return Row(
      children: <Widget>[
        // Text('Coomorbilidad'),
        // SizedBox(
        //   width: 30.0,
        // ),
        Expanded(
          child: DropdownButtonFormField(
            decoration: InputDecoration(labelText: 'Comorbilidad'),
            value: _coomorbilidad,
            items: getOpcionesDropdown(_tiposComorbilidad),
            onChanged: (opt) {
              setState(() {
                _coomorbilidad = opt;
              });
            },
            validator: (value) {
              if (value.isEmpty) {
                return 'Campo requerido';
              } else {
                return null;
              }
            },
          ),
        )
      ],
    );
  }

  Widget _getCampoMalnutricion() {
    return CheckboxListTile(
      title: Text('Malnutrición'),
      value: _malnutricion,
      onChanged: (value) => setState(() {
        _malnutricion = value;
      }),
    );
  }

  Widget _getCampoContactos() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration:
          InputDecoration(labelText: 'Contactos', icon: Icon(Icons.contacts)),
      onChanged: (valor) {
        setState(() {
          _contactos = valor;
        });
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo requerido';
        }

        if (utils.isNmeric(value)) {
          return null;
        } else {
          return 'Ingrese un valor numerico';
        }
      },
    );
  }

  Widget _getCampoContactosSR() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          labelText: 'Nro de Contactos sintomáticos respiratorios',
          icon: Icon(Icons.contacts)),
      onChanged: (valor) {
        setState(() {
          _contactosSR = valor;
        });
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo requerido';
        }

        if (utils.isNmeric(value)) {
          return null;
        } else {
          return 'Ingrese un valor numerico';
        }
      },
    );
  }

  Widget _getCampoContactosSRExaminadosconBK() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          labelText:
              'Nro Contactos sintomáticos respiratorios con baciloscopia positiva',
          icon: Icon(Icons.contacts)),
      onChanged: (valor) {
        setState(() {
          _contactosSRExaminadosconBK = valor;
        });
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo requerido';
        }

        if (utils.isNmeric(value)) {
          return null;
        } else {
          return 'Ingrese un valor numerico';
        }
      },
    );
  }

  Widget _getCampoContactosMenores5Anios() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          labelText: 'Nro de Contactos menores de 5 años',
          icon: Icon(Icons.contacts)),
      onChanged: (valor) {
        setState(() {
          _contactosMenores5Anios = valor;
        });
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo requerido';
        }

        if (utils.isNmeric(value)) {
          return null;
        } else {
          return 'Ingrese un valor numerico';
        }
      },
    );
  }

  Widget _getCampoVihConfirmado() {
    // return CheckboxListTile(
    //   title: Text('VIH Confirmado'),
    //   value: _vihConfirmado,
    //   onChanged: (value) => setState(() {
    //     _vihConfirmado = value;
    //   }),
    // );

    return DropdownButtonFormField(
      decoration: InputDecoration(labelText: 'VIH Confirmado'),
      value: _vihConfirmado,
      items: getOpcionesDropdown(_tiposVihConfirmado),
      onChanged: (opt) {
        setState(() {
          if (opt == 'Negativo') {
            _tiposRecibeTar = [];
            _tiposRecibeTrimetoprim = [];
          } else {
            _tiposRecibeTar = ['No', 'Si', 'No Aplica'];
            _tiposRecibeTrimetoprim = ['No', 'Si', 'No Aplica'];
          }
          _vihConfirmado = opt;
        });
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo requerido';
        } else {
          return null;
        }
      },
    );
  }

  Widget _getCampoRecibeTar() {
    return Row(
      children: <Widget>[
        // Text('Recibe Tar'),
        // SizedBox(
        //   width: 30.0,
        // ),
        Expanded(
          child: DropdownButtonFormField(
            disabledHint: Text('No Aplica'),
            decoration:
                InputDecoration(labelText: 'Recibe Terapia Antiretroviral'),
            value: _recibeTar,
            items: getOpcionesDropdown(_tiposRecibeTar),
            onChanged: (opt) {
              setState(() {
                _recibeTar = opt;
              });
            },
            validator: (value) {
              if (value.isEmpty) {
                return 'Campo requerido';
              } else {
                return null;
              }
            },
          ),
        )
      ],
    );
  }

  Widget _getCampoRecibeTrimetoprim() {
    return Row(
      children: <Widget>[
        // Text('Recibe Trimetoprim'),
        // SizedBox(
        //   width: 30.0,
        // ),
        Expanded(
          child: DropdownButtonFormField(
            disabledHint: Text('No Aplica'),
            decoration: InputDecoration(labelText: 'Recibe Trimetoprim'),
            value: _recibeTrimetoprim,
            items: getOpcionesDropdown(_tiposRecibeTrimetoprim),
            onChanged: (opt) {
              setState(() {
                _recibeTrimetoprim = opt;
              });
            },
            validator: (value) {
              if (value.isEmpty) {
                return 'Campo requerido';
              } else {
                return null;
              }
            },
          ),
        )
      ],
    );
  }

  Widget _getCampoRdoBkDx() {
    return Row(
      children: <Widget>[
        // Text('Resultado de Baciloscopia'),
        // SizedBox(
        //   width: 30.0,
        // ),
        Expanded(
          child: DropdownButtonFormField(
            decoration: InputDecoration(labelText: 'Resultado de Baciloscopia'),
            value: _rdobxdx,
            items: getOpcionesDropdown(_tiposRdoBkDx),
            onChanged: (opt) {
              setState(() {
                _rdobxdx = opt;
              });
            },
            validator: (value) {
              if (value.isEmpty) {
                return 'Campo requerido';
              } else {
                return null;
              }
            },
          ),
        )
      ],
    );
  }

  List<DropdownMenuItem<String>> getOpcionesDropdown(listaOpciones) {
    List<DropdownMenuItem<String>> lista = new List();

    listaOpciones.forEach((option) {
      lista.add(DropdownMenuItem(child: Text(option), value: option));
    });

    return lista;
  }

  int getIndexList(listaOpciones, text) {
    return listaOpciones.indexOf(text);
  }

  Diagnostico getDiagnosticoModel() {
    Diagnostico diagnostico = new Diagnostico();

    diagnostico.fecha = _fechaNacimiento;
    diagnostico.sexo = getIndexList(_tiposSexo, _tipoSexo);
    diagnostico.etnia = getIndexList(_tiposEtnia, _etnia);
    diagnostico.grupoPoblacional =
        getIndexList(_tiposGrupoPoblacional, _grupoPoblacional);
    diagnostico.comorbilidad = getIndexList(_tiposComorbilidad, _coomorbilidad);
    diagnostico.malnutricion = _malnutricion;
    diagnostico.contactos = int.parse(_contactos);
    diagnostico.contactosSR = int.parse(_contactosSR);
    diagnostico.contactosSRExaminadosconBK =
        int.parse(_contactosSRExaminadosconBK);
    diagnostico.contactosMenores5Anios = int.parse(_contactosMenores5Anios);
    diagnostico.vihConfirmado =
        getIndexList(_tiposVihConfirmado, _vihConfirmado);
    diagnostico.recibeTar = getIndexList(['No', 'Si', 'No Aplica'], _recibeTar);
    diagnostico.recibeTrimetoprim =
        getIndexList(['No', 'Si', 'No Aplica'], _recibeTrimetoprim);
    diagnostico.rDOBKDX = getIndexList(_tiposRdoBkDx, _rdobxdx);

    return diagnostico;
  }
}

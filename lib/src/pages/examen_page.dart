import 'package:flutter/material.dart';

class ExamenPage extends StatefulWidget {
  @override
  _ExamenPageState createState() => _ExamenPageState();
}

class _ExamenPageState extends State<ExamenPage> {
  String _tipoSexo = "Femenino";
  String _edad = "0";
  String _etnia = "Otro";
  String _grupoPoblacional = "Ninguno";
  String _coomorbilidad = "Ninguna";
  bool _malnutricion = false;
  String _contactos = "";
  String _contactosSR = "";
  String _contactosSRExaminadosconBK = "";
  String _contactosMenores5Anios = "";
  bool _vihConfirmado = false;
  String _recibeTar = "NoAplica";
  String _recibeTrimetoprim = "NoAplica";
  String _rdobxdx = "Negativo";

  List<String> _tiposSexo = ['Femenino', 'Masculino'];
  List<String> _tiposEtnia = ['Indigena', 'NegroMulato', 'Otro'];
  List<String> _tiposGrupoPoblacional = [
    'TrabajadorSalud',
    'HabitanteCalle',
    'FarmacoDependiente',
    'PoblacionCarcelaria',
    'Ninguno'
  ];
  List<String> _tiposComorbilidad = [
    'EnfermedadRenal',
    'OtrasInmunosupresiones',
    'Hipertension',
    'Diabetes',
    'OtraEnfermedadPulmonar',
    'Ninguna'
  ];
  List<String> _tiposRecibeTar = ['No', 'Si', 'NoAplica'];
  List<String> _tiposRecibeTrimetoprim = ['No', 'Si', 'NoAplica'];
  List<String> _tiposRdoBkDx = [
    'NoRealizado',
    'Positivo1a9Baar',
    'TripleMas',
    'DobleMas',
    'Mas',
    'Negativo'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diagnostico Tuberculosis'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          children: <Widget>[
            _crearListaTipoSexo(),
            Divider(),
            _getCampoEdad(),
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
          ],
        ),
      ),
    );
  }

  Widget _getCampoEdad() {
    return TextField(
      keyboardType: TextInputType.number,
      decoration:
          InputDecoration(labelText: 'Edad', icon: Icon(Icons.calendar_today)),
      onChanged: (valor) {
        setState(() {
          _edad = valor;
        });
      },
    );
  }

  Widget _crearListaTipoSexo() {
    return Row(
      children: <Widget>[
        Text('Sexo'),
        SizedBox(
          width: 30.0,
        ),
        Expanded(
          child: DropdownButton(
            value: _tipoSexo,
            items: getOpcionesDropdown(_tiposSexo),
            onChanged: (opt) {
              setState(() {
                _tipoSexo = opt;
              });
            },
          ),
        )
      ],
    );
  }

  Widget _getListaTipoEtnia() {
    return Row(
      children: <Widget>[
        Text('Etnia'),
        SizedBox(
          width: 30.0,
        ),
        Expanded(
          child: DropdownButton(
            value: _etnia,
            items: getOpcionesDropdown(_tiposEtnia),
            onChanged: (opt) {
              setState(() {
                _etnia = opt;
              });
            },
          ),
        )
      ],
    );
  }

  Widget _getListaGrupoPoblacional() {
    return Row(
      children: <Widget>[
        Text('Grupo Poblacional'),
        SizedBox(
          width: 30.0,
        ),
        Expanded(
          child: DropdownButton(
            value: _grupoPoblacional,
            items: getOpcionesDropdown(_tiposGrupoPoblacional),
            onChanged: (opt) {
              setState(() {
                _grupoPoblacional = opt;
              });
            },
          ),
        )
      ],
    );
  }

  Widget _getListaCoomorbilidad() {
    return Row(
      children: <Widget>[
        Text('Coomorbilidad'),
        SizedBox(
          width: 30.0,
        ),
        Expanded(
          child: DropdownButton(
            value: _coomorbilidad,
            items: getOpcionesDropdown(_tiposComorbilidad),
            onChanged: (opt) {
              setState(() {
                _coomorbilidad = opt;
              });
            },
          ),
        )
      ],
    );
  }

  Widget _getCampoMalnutricion() {
    return Checkbox(
      value: _malnutricion,
      onChanged: (value) => setState(() {
        _malnutricion = value;
      }),
    );
  }

  Widget _getCampoContactos() {
    return TextField(
      keyboardType: TextInputType.number,
      decoration:
          InputDecoration(labelText: 'Contactos', icon: Icon(Icons.contacts)),
      onChanged: (valor) {
        setState(() {
          _contactos = valor;
        });
      },
    );
  }

  Widget _getCampoContactosSR() {
    return TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          labelText: 'Contactos SR', icon: Icon(Icons.contacts)),
      onChanged: (valor) {
        setState(() {
          _contactosSR = valor;
        });
      },
    );
  }

  Widget _getCampoContactosSRExaminadosconBK() {
    return TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          labelText: 'Contactos SR Examinados con BK',
          icon: Icon(Icons.contacts)),
      onChanged: (valor) {
        setState(() {
          _contactosSRExaminadosconBK = valor;
        });
      },
    );
  }

  Widget _getCampoContactosMenores5Anios() {
    return TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          labelText: 'Contactos Menores 5 Años', icon: Icon(Icons.contacts)),
      onChanged: (valor) {
        setState(() {
          _contactosMenores5Anios = valor;
        });
      },
    );
  }

  Widget _getCampoVihConfirmado() {
    return Checkbox(
      value: _vihConfirmado,
      onChanged: (value) => setState(() {
        _vihConfirmado = value;
      }),
    );
  }

  Widget _getCampoRecibeTar() {
    return Row(
      children: <Widget>[
        Text('Recibe Tar'),
        SizedBox(
          width: 30.0,
        ),
        Expanded(
          child: DropdownButton(
            value: _recibeTar,
            items: getOpcionesDropdown(_tiposRecibeTar),
            onChanged: (opt) {
              setState(() {
                _recibeTar = opt;
              });
            },
          ),
        )
      ],
    );
  }

  Widget _getCampoRecibeTrimetoprim() {
    return Row(
      children: <Widget>[
        Text('Recibe Trimetoprim'),
        SizedBox(
          width: 30.0,
        ),
        Expanded(
          child: DropdownButton(
            value: _recibeTrimetoprim,
            items: getOpcionesDropdown(_tiposRecibeTrimetoprim),
            onChanged: (opt) {
              setState(() {
                _recibeTrimetoprim = opt;
              });
            },
          ),
        )
      ],
    );
  }

  Widget _getCampoRdoBkDx() {
    return Row(
      children: <Widget>[
        Text('RdoBkDx'),
        SizedBox(
          width: 30.0,
        ),
        Expanded(
          child: DropdownButton(
            value: _rdobxdx,
            items: getOpcionesDropdown(_tiposRdoBkDx),
            onChanged: (opt) {
              setState(() {
                _rdobxdx = opt;
              });
            },
          ),
        )
      ],
    );
  }

  List<DropdownMenuItem<String>> getOpcionesDropdown(listaOpciones) {
    List<DropdownMenuItem<String>> lista = new List();

    listaOpciones.forEach((opcion) {
      lista.add(DropdownMenuItem(child: Text(opcion), value: opcion));
    });

    return lista;
  }
}

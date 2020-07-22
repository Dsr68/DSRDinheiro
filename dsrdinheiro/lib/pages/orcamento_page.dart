import "package:flutter/material.dart";

class OrcamentoPage extends StatefulWidget {
  @override
  _OrcamentoPageState createState() => _OrcamentoPageState();
}

class _OrcamentoPageState extends State<OrcamentoPage> {
  final _formKey = GlobalKey<FormState>();
  bool _validador = false;
  String categoria, valor, meta;

  String _validarCategoria(String value) {
    String Pattern = r'(^[a-zA-Z]*$)';
    RegExp regExp = new RegExp(Pattern);
    if (value.length == 0) {
      return "Informe o nome";
    } else if (!regExp.hasMatch(value)) {
      return "O nome deve conter caracteres de a-z ou de A-Z";
    } else {
      return null;
    }
  }

  _salvar() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      print("categoria: $categoria");
      print("valor: $valor");
    } else {
      setState(() {
        _validador = true;
      });
    }
  }

  Widget _campos() {
    return Column(
      children: <Widget>[
        TextFormField(
          decoration: InputDecoration(hintText: "Digite o nome da categoria"),
          maxLength: 40,
          validator: _validarCategoria,
          onSaved: (String val) {
            categoria = val;
          },
        ),
        TextFormField(
          decoration: InputDecoration(hintText: "Quanto você deseja gastar?"),
          keyboardType: TextInputType.number,
          onSaved: (String val) {
            valor = val;
          },
        ),
        TextFormField(
          decoration: InputDecoration(hintText: "Quanto você quer economizar?"),
          keyboardType: TextInputType.number,
          onSaved: (String val) {
            meta = val;
          },
        ),
        SizedBox(
          height: 30.0,
          child: RaisedButton(
            color: Colors.lightBlue,
            onPressed: _salvar,
            child: Text(
              "Salvar",
              style: TextStyle(color: Colors.white),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text("Criar Metas"),
        centerTitle: true,
      ),
      body: Form(key: _formKey, autovalidate: _validador, child: _campos()),
    );
  }
}

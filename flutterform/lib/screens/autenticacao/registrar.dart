
import 'package:brasil_fields/brasil_fields.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Registrar extends StatelessWidget {

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _celularController = TextEditingController();
  final TextEditingController _nascimentoController = TextEditingController();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _logradouroController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _complemento = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Cliente'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).accentColor)),
                  ),
                  controller: _nomeController,
                  maxLength: 255,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if(value!.contains("")) {
                     return 'Informe pelo menos um sobrenome';
                    }
                    if(value.length < 3) {
                      return 'Nome inválido';
                    }
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).accentColor)),
                  ),
                  controller: _emailController,
                  maxLength: 255,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if(!value!.contains("@") || value.contains('.')) {
                      return 'Email inválido';
                    }
                    if(value.length < 3) {
                      return 'Email muito curto';
                    }
                  },
                ),
                TextFormField(

                  inputFormatters: [
                    //Digits only pra apenas aceitar numeros
                    FilteringTextInputFormatter.digitsOnly,
                    CpfInputFormatter(),
                  ],
                  decoration: InputDecoration(
                    labelText: 'CPF',
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).accentColor)),
                  ),
                  controller: _cpfController,
                  maxLength: 14,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if(value!.length != 14 ) {
                      return 'CPF inválido';
                    }
                    if(value.length < 3) {
                      return 'Email muito curto';
                    }
                  },
                ),
                TextFormField(
                  inputFormatters: [
                    //Digits only pra apenas aceitar numeros
                    FilteringTextInputFormatter.digitsOnly,
                    TelefoneInputFormatter(),
                  ],
                  decoration: InputDecoration(
                    labelText: 'Celular',
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).accentColor)),
                  ),
                  controller: _celularController,
                  maxLength: 15,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if(value!.length != 15 ) {
                      return 'Celular inválido';
                    }
                    if(value.length < 11) {
                      return 'Celular muito curto';
                    }
                  },
                ),
                DateTimePicker(
                  controller: _nascimentoController,
                  type: DateTimePickerType.date,
                  firstDate: DateTime(1940),
                  lastDate: DateTime(2100),
                  dateLabelText: 'Nascimento',
                  dateMask: 'dd/MM/yyyy',
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  inputFormatters: [
                    //Digits only pra apenas aceitar numeros
                    FilteringTextInputFormatter.digitsOnly,
                    CepInputFormatter(),
                  ],
                  decoration: InputDecoration(
                    labelText: 'Cep',
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).accentColor)),
                  ),
                  controller: _cepController,
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if(value!.length != 10 ) {
                      return 'Cep inválido';
                    }
                    if(value.length < 10) {
                      return 'Cep muito curto';
                    }
                  },
                ),
                DropdownButtonFormField(
                    isExpanded: true,
                    items: Estados.listaEstadosSigla.map((String estado){
                      return DropdownMenuItem(
                        child: Text(estado),
                        value: estado,
                      );
                    }).toList(),
                  onChanged: (String? novoEstadoSelecionado){
                      _estadoController.text = novoEstadoSelecionado!;
                  },
                  decoration: InputDecoration(
                    labelText: 'Estado',
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).accentColor)),
                  ),
                  validator: (value) {
                      if(value == null) {
                        return 'Selecione um estado!';
                      }
                  },
                ),
                SizedBox(height: 20,),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Cidade',
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).accentColor)),
                  ),
                  controller: _cidadeController,
                  maxLength: 15,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if(value!.contains("")) {
                      return 'Informe sua cidade';
                    }
                    if(value.length < 3) {
                      return 'Cidade inválida';
                    }
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Bairro',
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).accentColor)),
                  ),
                  controller: _bairroController,
                  maxLength: 15,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if(value!.contains("")) {
                      return 'Informe seu bairro';
                    }
                    if(value.length < 3) {
                      return 'Bairro inválido';
                    }
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Logradouro',
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).accentColor)),
                  ),
                  controller: _logradouroController,
                  maxLength: 15,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if(value!.contains("")) {
                      return 'Informe seu endereço';
                    }
                    if(value.length < 3) {
                      return 'Endereço inválido';
                    }
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Numero',
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).accentColor)),
                  ),
                  controller: _numeroController,
                  maxLength: 15,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if(value!.contains("")) {
                      return 'Informe seu numero';
                    }
                    if(value.length < 3) {
                      return 'Endereço inválido';
                    }
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Complemento',
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).accentColor)),
                  ),
                  controller: _complemento,
                  maxLength: 15,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if(value!.contains("")) {
                      return 'Informe seu complento';
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

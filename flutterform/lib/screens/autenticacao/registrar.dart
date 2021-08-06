import 'dart:io';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterform/components/biometria.dart';
import 'package:flutterform/models/cliente.dart';
import 'package:flutterform/screens/dashboard/dashboard.dart';
import 'package:provider/provider.dart';
import 'package:flux_validator_dart/flux_validator_dart.dart';
import 'package:image_picker/image_picker.dart';

class Registrar extends StatelessWidget {
  //Step 1
  final _formUserData = GlobalKey<FormState>();
  final _formUserAddress = GlobalKey<FormState>();
  final _formUserAuth = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _celularController = TextEditingController();
  final TextEditingController _nascimentoController = TextEditingController();
  //Step 2
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _logradouroController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();
  //Step3
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmarSenhaController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Cliente'),
      ),
      body: Consumer<Cliente>(
        builder: (context, cliente, child) {
          return Stepper(
            currentStep: cliente.stepAtual,
            onStepContinue: () {
              final functions = [
                _salvarStep1,
                _salvarStep2,
                _salvarStep3,
              ];
              //retorna o indice do step atual
              return functions[cliente.stepAtual](context);
            },
            onStepCancel: () {
              cliente.stepAtual =
                  cliente.stepAtual > 0 ? cliente.stepAtual - 1 : 0;
            },
            steps: _construirSteps(context, cliente),
            controlsBuilder: (context, {onStepContinue, onStepCancel}) {
              return Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: onStepContinue,
                      child: Text(
                        'Salvar',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).accentColor),
                    ),
                    Padding(padding: EdgeInsets.only(right: 20)),
                    ElevatedButton(
                      onPressed: onStepCancel,
                      child: Text(
                        'Voltar',
                        style: TextStyle(color: Theme.of(context).accentColor),
                      ),
                      style: ElevatedButton.styleFrom(primary: Colors.white),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  // void _salvar(context) {
  //   Provider.of<Cliente>(context).nome = _nomeController.text;
  // }

  _salvarStep1(context) {
    if (_formUserData.currentState!.validate()) {
      //com o cliente.nome porque vamos salvar o nome
      Cliente cliente = Provider.of<Cliente>(context, listen: false);
      cliente.nome = _nomeController.text;
      _proximoStep(context);
    }
  }

  _salvarStep2(context) {
    if (_formUserAddress.currentState!.validate()) {
      _proximoStep(context);
    }
  }

  _salvarStep3(context) {
    if (_formUserAuth.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Dashboard()),
          (route) => false);
    }
  }

  List<Step> _construirSteps(context, cliente) {
    List<Step> step = [
      Step(
          title: Text('Seus dados'),
          isActive: cliente.stepAtual >= 0,
          content: Form(
            key: _formUserData,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nome',
                  ),
                  controller: _nomeController,
                  maxLength: 255,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.length < 3) {
                      return 'Nome inválido!';
                    }
                    if (value.contains(" "))
                      return 'Informe pelo menos um sobrenome!';
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                  controller: _emailController,
                  maxLength: 255,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) =>
                      Validator.email(value) ? 'Email inválido' : null,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'CPF',
                  ),
                  controller: _cpfController,
                  maxLength: 14,
                  keyboardType: TextInputType.number,
                  // validator: (value) =>
                      // Validator.cpf(value) ? 'CPF inválido' : null,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CpfInputFormatter()
                  ],
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Celular',
                  ),
                  controller: _celularController,
                  maxLength: 15,
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      Validator.phone(value) ? 'Celular inválido' : null,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    TelefoneInputFormatter()
                  ],
                ),
                DateTimePicker(
                  controller: _nascimentoController,
                  type: DateTimePickerType.date,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  dateLabelText: 'Nascimento',
                  dateMask: 'dd/MM/yyyy',
                  validator: (value) {
                    if (value!.isEmpty) return 'Data inválida!';

                    return null;
                  },
                ),
              ],
            ),
          )),
      Step(
        title: Text('Endereço'),
        isActive: cliente.stepAtual >= 1,
        content: Form(
          key: _formUserAddress,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Cep',
                ),
                controller: _cepController,
                maxLength: 10,
                keyboardType: TextInputType.number,
                // validator: (value) => Validator.cep(value) ? 'Cep inválido' : null,

                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CepInputFormatter()
                ],
              ),
              DropdownButtonFormField(
                isExpanded: true,
                decoration: InputDecoration(labelText: 'Estado'),
                items: Estados.listaEstadosSigla.map((String estado) {
                  return DropdownMenuItem(
                    child: Text(estado),
                    value: estado,
                  );
                }).toList(),
                onChanged: (String? novoEstadoSelecionado) {
                  _estadoController.text = novoEstadoSelecionado!;
                },
                validator: (value) {
                  if (value == null) return 'Selecione um estado!';

                  return null;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Cidade',
                ),
                controller: _cidadeController,
                maxLength: 255,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.length < 3) return 'Cidade inválida';

                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Bairro',
                ),
                controller: _bairroController,
                maxLength: 255,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.length < 3) return 'Bairro inválido';

                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Logradouro',
                ),
                controller: _logradouroController,
                maxLength: 255,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.length < 3) return 'Logradouro inválido';

                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Número',
                ),
                controller: _numeroController,
                maxLength: 255,
                keyboardType: TextInputType.text,
              ),
            ],
          ),
        ),
      ),
      Step(
        title: Text('Autenticação'),
        isActive: cliente.stepAtual >= 2,
        content: Form(
          key: _formUserAuth,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Senha',
                ),
                controller: _senhaController,
                maxLength: 255,
                obscureText: true,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.length < 8) return 'Senha muito curta';

                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Confirmar senha',
                ),
                controller: _confirmarSenhaController,
                maxLength: 255,
                obscureText: true,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value != _senhaController.text) return 'Senha diferente';

                  return null;
                },
              ),
              SizedBox(height: 15),
              Text(
                'Para prosseguir com o seu cadastro é necessário que tenhamos uma foto do seu rg',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 14,
              ),
              ElevatedButton(
                  onPressed: () => _capturarRg(cliente),
                  child: Text('Foto do RG')),
              _jaEnviouRG(context)
                  ? _imagemDoRG(context)
                  : _pedidoDeRG(context),
            ],
          ),
        ),
      )
    ];
    return step;
  }

  void _proximoStep(context) {
    Cliente cliente = Provider.of<Cliente>(context, listen: false);
    irPara(cliente.stepAtual + 1, cliente);
  }

  void irPara(int step, cliente) {
    cliente.stepAtual = step;
  }

  void _capturarRg(cliente) async {
    final pickedImage = await _picker.pickImage(source: ImageSource.camera);
    cliente.imagemRg = File(pickedImage!.path);
  }

  bool _jaEnviouRG(context) {
    if (Provider.of<Cliente>(context, listen: false).imagemRg != null) {
      return true;
    } else {
      return false;
    }
  }

  Widget _imagemDoRG(context) {
    if(Provider.of<Cliente>(context,listen: false).imagemRg == null) {
      return SizedBox.shrink();
    }
      return Image.file(Provider.of<Cliente>(context).imagemRg!);
    }

  Column _pedidoDeRG(context) {
    return Column(
      children: [
        SizedBox(
          height: 15,
        ),
        Text(
          'Foto do RG pendente!',
          style: TextStyle(
              color: Colors.red, fontWeight: FontWeight.bold, fontSize: 15),

        ),
        Biometria(),
      ],
    );
  }
}

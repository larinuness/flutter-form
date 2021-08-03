import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterform/components/mensagem.dart';
import 'package:flutterform/screens/autenticacao/registrar.dart';
import 'package:flutterform/screens/dashboard/dashboard.dart';

class Login extends StatelessWidget {
  TextEditingController _cpfController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 50),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  'img/logobytebank.png',
                  width: 200,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 300,
                  height: 444,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: _construirFormulario(context)),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Theme.of(context).accentColor,
    );
  }

  Widget _construirFormulario(context) {
    return Form(
      key: _formkey,
      child: Column(
        children: [
          Text(
            'Faça seu login',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CpfInputFormatter(),
            ],
            decoration: InputDecoration(
              labelText: 'CPF',
              labelStyle: TextStyle(color: Colors.black),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).accentColor)),
            ),
            //só aceita até 11 caracteres
            maxLength: 14,
            validator: (value) {
              if (value!.length == 0) {
                return 'Informe CPF';
              }

              if (value.length < 14) {
                return 'CPF inválido';
              }
            },
            //Já aparece com teclado numerico
            keyboardType: TextInputType.number,
            controller: _cpfController,
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Senha',
              labelStyle: TextStyle(color: Colors.black),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).accentColor)),
            ),
            //só aceita até 11 caracteres
            maxLength: 15,
            validator: (value) {
              if (value!.length == 0) {
                return 'Informe uma senha!';
              }
            },
            //Já aparece com teclado numerico
            keyboardType: TextInputType.text,
            controller: _senhaController,
          ),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            //pega o valor maximo de largura da box
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                if (_formkey.currentState!.validate()) {
                  if (_cpfController.text == '111.111.111-11' &&
                      _senhaController.text == 'abc123') {
                         Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Dashboard(),
                        ),
                        (route) => false);
                  } else {
                    exibirAlerta(context: context, titulo: 'Atenção', content:'CPF ou Senha incorretos');
                  }
                }
              },
              style: OutlinedButton.styleFrom(
                  primary: Colors.white,
                  side: BorderSide(color: Theme.of(context).accentColor),
                  backgroundColor: Theme.of(context).accentColor),
              child: Text('Entrar'),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          SizedBox(
            width: double.infinity,
            child: TextButton(
                onPressed: () {},
                child: Text(
                  'Esqueci minha senha',
                  style: TextStyle(color: Theme.of(context).accentColor),
                )),
          ),
          SizedBox(
            //pega o valor maximo de largura da box
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context)=> Registrar()
                    )
                );
              },
              style: OutlinedButton.styleFrom(
                primary: Theme.of(context).accentColor,
              ),
              child: Text('Criar uma conta'),
            ),
          ),
        ],
      ),
    );
  }
}

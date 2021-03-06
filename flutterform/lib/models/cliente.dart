import 'dart:io';

import 'package:flutter/material.dart';

class Cliente extends ChangeNotifier {
  late String _nome;
  late String _email;
  late String _celular;
  late String _cpf;
  late String _nascimento;
  late String _cep;
  late String _estado;
  late String _bairro;
  late String _cidade;
  late String _logradouro;
  late String _numero;
  late String _complemento;
  late String _senha;

  String get nome => _nome;

  String get email => _email;

  String get celular => _celular;

  String get cpf => _cpf;

  String get nascimento => _nascimento;

  String get cep => _cep;

  String get estado => _estado;

  String get bairro => _bairro;

  String get cidade => _cidade;

  String get logradouro => _logradouro;

  String get numero => _numero;

  String get complemento => _complemento;

  String get senha => _senha;

  set email(String value) {
    _email = value;
  }

  set senha(String value) {
    _senha = value;
  }

  set complemento(String value) {
    _complemento = value;
  }

  set numero(String value) {
    _numero = value;
  }

  set logradouro(String value) {
    _logradouro = value;
  }

  set cidade(String value) {
    _cidade = value;
  }

  set bairro(String value) {
    _bairro = value;
  }

  set estado(String value) {
    _estado = value;
  }

  set cep(String value) {
    _cep = value;
  }

  set nascimento(String value) {
    _nascimento = value;
  }

  set cpf(String value) {
    _cpf = value;
  }

  set celular(String value) => _celular = value;

  set nome(String value) {
    _nome = value;
    notifyListeners();
  }

  //Tela de registro
  late int _stepAtual = 0;
  File? _imagemRg = null;

  bool? _biometria = false;

  bool? get biometria => _biometria;

  set biometria(bool? value) {
    _biometria = value;

    notifyListeners();
  }


  File? get imagemRg => _imagemRg;

  set imagemRg(File? value) {
    _imagemRg = value;
    notifyListeners();
  }

  int get stepAtual => _stepAtual;

  set stepAtual(int value) {
    _stepAtual = value;
    notifyListeners();
  }
}

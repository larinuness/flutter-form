import 'package:flutterform/models/transferencia.dart';
import 'package:flutterform/models/transferencias.dart';
import 'package:flutterform/screens/extrato/item.dart';
import 'package:flutterform/screens/transferencia/formulario.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


const _tituloAppBar = 'Extrato';

class ListaMovimentacoes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tituloAppBar),
      ),
      body: Consumer<Transferencias>(
        builder: (context, transferencias, child) {
          return ListView.builder(
            itemCount: transferencias.transferencias.length,
            itemBuilder: (context, indice) {
              final transferencia = transferencias.transferencias[indice];

              return Item.transferencia(
                transferencia.toStringValor(),
                transferencia.toStringConta(),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormularioTransferencia();
          }));
        },
      ),
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
          leading: Icon(Icons.monetization_on),
          title: Text(_transferencia.toStringValor()),
          subtitle: Text(_transferencia.toStringConta()),
        ));
  }
}

import 'package:flutterform/screens/autenticacao/login.dart';
import 'package:flutterform/screens/dashboard/saldo.dart';
import 'package:flutterform/screens/deposito/formulario.dart';
import 'package:flutterform/screens/transferencia/formulario.dart';
import 'package:flutter/material.dart';
import 'package:flutterform/screens/extrato/ultimas.dart';

class Dashboard extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bytebank'),
      ),
      body: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: SaldoCard(),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                // color: Colors.green,
                style: ElevatedButton.styleFrom(primary: Colors.green),
                child: Text('Recebe valor'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return FormularioDeposito();
                    }),
                  );
                },
              ),
              ElevatedButton(
                // color: Colors.green,
                child: Text('Nova Transferência'),
                style: ElevatedButton.styleFrom(primary: Colors.green),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return FormularioTransferencia();
                    }),
                  );
                },
              ),
            ],
          ),
          UltimasTransferencias(),
          ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.green),
              onPressed: (){
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(
                        builder: (context) => Login()
                    ),
                        (route) => false);
              },
              child: Text('Sair'))
          
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CadastroCliente extends StatefulWidget {
  const CadastroCliente({Key? key}) : super(key: key);

  @override
  State<CadastroCliente> createState() => _CadastroClienteState();
}

class _CadastroClienteState extends State<CadastroCliente> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: const [
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: Text(
                  'Cadastro Cliente',
                  style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

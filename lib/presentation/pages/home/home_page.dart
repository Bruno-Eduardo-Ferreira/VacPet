import 'package:vacpet/presentation/pages/consulta_cliente_page/consulta_cliente_page.dart';
import 'package:vacpet/services/auth_service.dart';
import 'package:flutter/material.dart';
import '../cadastro_cliente_page/cadastro_cliente_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  AuthService auth = new AuthService();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: SafeArea(
        child: Column(
          children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: Text(
                  "Home Vacpet",
                  style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: ElevatedButton(
                          onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CadastroCliente()));   
                               },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.check),
                              Padding(
                                padding: EdgeInsets.all(16),
                                child: Text(
                                  'Cadastrar cliente',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ],
                          ),
              ),
            ),
             Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: ElevatedButton(
                          onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ConsultaCliente()));   
                               },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.check),
                              Padding(
                                padding: EdgeInsets.all(16),
                                child: Text(
                                  'Consultar cliente',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ],
                          ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: ElevatedButton(
                          onPressed: () {
                              auth.logout();
                              
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.check),
                              Padding(
                                padding: EdgeInsets.all(16),
                                child: Text(
                                  'Logout',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ],
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
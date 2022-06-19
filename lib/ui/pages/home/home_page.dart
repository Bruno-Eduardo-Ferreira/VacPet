import 'dart:async';

import 'package:vacpet/ui/pages/cadastros/cadastro_pet/cadastro_pet_page.dart';
import 'package:vacpet/ui/pages/cadastros/cadastro_vacina/cadastro_vacina_page.dart';
import 'package:vacpet/ui/pages/consultas/consulta_cliente/consulta_cliente_page.dart';
import 'package:vacpet/services/auth_service.dart';
import 'package:flutter/material.dart';

import '../cadastros/cadastro_cliente/cadastro_cliente_page.dart';
import '../consultas/consulta_cliente/consulta_cliente_page.dart';
import '../consultas/consulta_vacina/consulta_vacina_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthService auth = AuthService();
  bool cadastro = false;
  bool consulta = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: const Text('Cadastro de vacinas', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 50.0),
                  child: Text(
                    "Home Vacpet",
                    style:
                        TextStyle(fontSize: 32.0, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: ElevatedButton(
                  onPressed: () {
                    setState(
                      () {
                        if (consulta == true) {
                          consulta = false;
                          startTimer(1);
                        } else {
                          cadastro = cadastro ? false : true;
                        }
                      },
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.add_box_outlined),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'Cadastrar',
                          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds:500),
                height: cadastro ? 320 : 0,
                curve: Curves.easeInOut,
                child: Padding(
                  padding: const EdgeInsets.only(left: 32, right: 32),
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const CadastroCliente()));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.account_box_rounded),
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Center(
                                    child: Text(
                                      'Cadastrar cliente',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const CadastroPet()));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.pets_outlined),
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    'Cadastrar pet',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const CadastroVacina()));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.vaccines_rounded),
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    'Cadastrar vacina',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                    setState(
                      () {
                        if (cadastro == true) {
                          cadastro = false;
                          startTimer(0);
                        } else {
                          consulta = consulta ? false : true;
                        }
                      },
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.search_rounded),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(
                          child: Text(
                            'Consultas',
                            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                height: consulta ? 210 : 0,
                curve: Curves.easeInOut,
                child: Padding(
                  padding: const EdgeInsets.only(left: 32, right: 32),
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const ConsultaCliente()));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.account_box_rounded),
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    'Consultar cliente',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const ConsultaVacina()));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.vaccines_rounded),
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    'Consultar vacinas a notificar',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                      Icon(Icons.logout),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'Logout',
                          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void startTimer(int flag) {
    const oneSec = Duration(milliseconds: 500);
    Timer(
      oneSec,
      () {
        setState(
          () {
            if (flag == 1) {
              cadastro = true;
            } else if (flag == 0) {
              consulta = true;
            }
          },
        );
      },
    );
  }
}

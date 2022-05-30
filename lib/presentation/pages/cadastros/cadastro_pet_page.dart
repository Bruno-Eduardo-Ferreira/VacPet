import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vacpet/presentation/pages/home/home_page.dart';

class CadastroPet extends StatefulWidget {
  const CadastroPet({Key? key}) : super(key: key);

  @override
  State<CadastroPet> createState() => _CadastroPetState();
}

class _CadastroPetState extends State<CadastroPet> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final nome = TextEditingController();
  final nomePet = TextEditingController();
  final idadePet = TextEditingController();
  final sexoPet = TextEditingController();
  final pesoPet = TextEditingController();
  final racaPet = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _addPet(String nome, String nomePet, String idadePet,
      String sexoPet, String pesoPet, String racaPet) async {
    await _firestore.collection('pets').add({
      'dono': nome,
      'nomePet': nomePet,
      'idade': idadePet,
      'sexo': sexoPet,
      'peso': pesoPet,
      'raca': racaPet,
    });
  }

  String? nomeDigitado;
  String? nomePetDigitado;
  String? idadePetDigitado;
  String? sexoPetDigitado;
  String? pesoPetDigitado;
  String? racaPetDigitado;

  final selectSexo = ['M', 'F'];

  String? selectInitialSexo;
  String? teste;

  final clientesCadastrados = [];

  /*void _getUsers() async {
    var colletion = FirebaseFirestore.instance.collection('clientes');
    var result = await colletion.get();
    for (var doc in result.docs) {
      clientesCadastrados.add(doc['nome']);
      setState(() {
        clientesCadastrados;
      });
    }
  }*/

  @override
  void initState() {

    void _getUsers() async {
    var colletion = FirebaseFirestore.instance.collection('clientes');
    var result = await colletion.get();
    for (var doc in result.docs) {
      clientesCadastrados.add(doc['nome']);
      setState(() {
        clientesCadastrados;
      });
    }
  }
    _getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 50.0, bottom: 50.0),
                  child: Text(
                    'Pet',
                    style:
                        TextStyle(fontSize: 32.0, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                        padding: const EdgeInsets.fromLTRB(34, 6, 24, 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              'Dono do pet:    ',
                              style: TextStyle(fontSize: 16),
                            ),
                            DropdownButton(
                              hint: const Text("Seleciona o dono do pet"),
                              value: teste ?? null,
                              items: clientesCadastrados.map((username) {
                                return DropdownMenuItem(
                                    value: username,
                                    child: Text(
                                      username,
                                      style: const TextStyle(fontSize: 24),
                                    ));
                              }).toList(),
                              onChanged: (valuename) {
                                nomeDigitado = valuename as String;
                                setState(() {
                                  teste = valuename;
                                });
                              },
                            ),
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 6, 24, 6),
                      child: TextFormField(
                          controller: nome,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Nome do pet',
                          ),
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Informe algum nome!';
                            } else if (value.length > 80) {
                              return 'São permitidos no máximo 80 caracteres para o nome!';
                            }
                            nomePetDigitado = value;
                            return null;
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 6, 24, 6),
                      child: TextFormField(
                        controller: idadePet,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Idade do pet',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Informe alguma idade!';
                          }
                          idadePetDigitado = value;
                          return null;
                        },
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(34, 6, 24, 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              'Sexo do pet:    ',
                              style: TextStyle(fontSize: 16),
                            ),
                            DropdownButton(
                              hint: Text('Selecione o sexo do pet'),
                              value: selectInitialSexo ?? null,
                              items: selectSexo.map((itemsname) {
                                return DropdownMenuItem(
                                    value: itemsname,
                                    child: Text(
                                      itemsname,
                                      style: const TextStyle(fontSize: 24),
                                    ));
                              }).toList(),
                              onChanged: (value) {
                                sexoPetDigitado = value as String;
                                setState(() {
                                  selectInitialSexo = value;
                                });
                              },
                            ),
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 6, 24, 6),
                      child: TextFormField(
                        controller: pesoPet,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Peso do pet',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Informe algum peso!';
                          }
                          pesoPetDigitado = value;
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 6, 24, 6),
                      child: TextFormField(
                        controller: racaPet,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Raça do pet',
                        ),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Informe alguma raça!';
                          }
                          racaPetDigitado = value;
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState?.save();

                            if (nomeDigitado != null &&
                                nomePetDigitado != null &&
                                idadePetDigitado != null &&
                                sexoPetDigitado != null &&
                                pesoPetDigitado != null &&
                                racaPetDigitado != null) {
                              await _addPet(
                                  nomeDigitado!,
                                  nomePetDigitado!,
                                  idadePetDigitado!,
                                  sexoPetDigitado!,
                                  pesoPetDigitado!,
                                  racaPetDigitado!);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const HomePage()));
                            }
                          } else {
                            FocusManager.instance.primaryFocus?.unfocus();
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.check),
                            Padding(
                              padding: EdgeInsets.all(16),
                              child: Text(
                                'Cadastrar',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

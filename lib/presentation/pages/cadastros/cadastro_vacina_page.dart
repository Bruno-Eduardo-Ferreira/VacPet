import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:vacpet/presentation/pages/home/home_page.dart';

class CadastroVacina extends StatefulWidget {
  const CadastroVacina({Key? key}) : super(key: key);

  @override
  State<CadastroVacina> createState() => _CadastroVacinaState();
}

class _CadastroVacinaState extends State<CadastroVacina> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final nomeVacina = TextEditingController();
  final dataAplicado = TextEditingController();
  final dataVencimento = TextEditingController();
  final dias = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _addVacina(String nomeVacina, DateTime dataAplicado,
      DateTime dataVencimento, String idUser, String idPetAdd, nomePetAplicado) async {
    await _firestore
        .collection('clientes')
        .doc(idUser)
        .collection('pets')
        .doc(idPet)
        .collection('vacinas')
        .add({
      'idUser': idUser,
      'idPet' : idPetAdd,
      'nomeVacina': nomeVacina,
      'dataAplicado': dataAplicado,
      'dataVencimento': dataVencimento,
      'nomePet': nomePetAplicado,
      'status': 'await',
    });
  }

  String? nomeVacinaDigitado;
  DateTime? dataVacAplicado = DateTime.now();
  DateTime? dataVacVencimento;
  String? dataPtVacAplicado;
  String? dataPtVacVencimento;
  DateTime? dataAtual = DateTime.now();
  num? tempoDigitado;

  String? selectPet;
  String? selectDono;
  String? selectTempo;
  String? idUser;
  String? idPet;
  bool? flagTempo;

  final clientesCadastrados = [];
  final petsCadastrados = [];
  final tempo = ['Dia', 'Mês'];

  void _getUserID(String user) async {
    var colletion = FirebaseFirestore.instance.collection('clientes');
    var result = await colletion.get();
    for (var doc in result.docs) {
      if (doc['nome'] == user) {
        idUser = doc.id;
      }
    }
  }

  void _getPetID(String pet, String user) async {
    var colletion = FirebaseFirestore.instance.collectionGroup('pets');
    var result = await colletion.get();
    for (var doc in result.docs) {
      if (doc['nomePet'] == pet && doc['nomeDono'] == user) {
        idPet = doc.id;
      }
    }
  }

  void _getPets(String pet) async {
    var colletion = FirebaseFirestore.instance.collectionGroup('pets');
    var result = await colletion.get();
    selectPet = null;
    petsCadastrados.clear();
    for (var doc in result.docs) {
      if (doc['nomeDono'] == pet) {
        petsCadastrados.add(doc['nomePet']);
        setState(() {
          petsCadastrados;
        });
      }
    }
  }

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
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    dataPtVacAplicado =
        DateFormat(DateFormat.YEAR_MONTH_DAY, 'pt_Br').format(dataAtual!);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de vacinas'),
      ),
      backgroundColor: Colors.blue.shade50,
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.fromLTRB(44, 6, 24, 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Dono do pet:    ',
                                style: TextStyle(fontSize: 16),
                              ),
                              DropdownButton(
                                hint: const Text("Selecione o dono do pet"),
                                value: selectDono,
                                items: clientesCadastrados.map((username) {
                                  return DropdownMenuItem(
                                      value: username,
                                      child: Text(
                                        username,
                                        style: const TextStyle(fontSize: 24),
                                      ));
                                }).toList(),
                                onChanged: (valuename) {
                                  setState(() {
                                    selectDono = valuename as String;
                                  });
                                  _getUserID(selectDono!);
                                  _getPets(selectDono!);
                                },
                              ),
                            ],
                          )),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(44, 6, 24, 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Pet:    ',
                                style: TextStyle(fontSize: 16),
                              ),
                              DropdownButton(
                                hint: const Text("Selecione o pet"),
                                value: selectPet,
                                items: petsCadastrados.map((petname) {
                                  return DropdownMenuItem(
                                      value: petname,
                                      child: Text(
                                        petname,
                                        style: const TextStyle(fontSize: 24),
                                      ));
                                }).toList(),
                                onChanged: (valuename) {
                                  setState(() {
                                    selectPet = valuename as String;
                                  });
                                  _getPetID(selectPet!, selectDono!);
                                },
                              ),
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                        child: TextFormField(
                            controller: nomeVacina,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Nome da vacina',
                            ),
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Informe algum nome!';
                              } else if (value.length > 80) {
                                return 'São permitidos no máximo 80 caracteres para o nome!';
                              }
                              nomeVacinaDigitado = value;
                              return null;
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 12, 24, 12),
                        child: Text('Data de aplicação: $dataPtVacAplicado.',
                            style: const TextStyle(fontSize: 16)),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 24),
                              child: Text('Informe o tempo:   '),
                            ),
                            DropdownButton(
                              hint: const Text('Selecione o tempo'),
                              value: selectTempo,
                              items: tempo.map((itemsname) {
                                return DropdownMenuItem(
                                    value: itemsname,
                                    child: Text(
                                      itemsname,
                                      style: const TextStyle(fontSize: 20),
                                    ));
                              }).toList(),
                              onChanged: (value) {
                                selectTempo = value as String;
                                selectTempo == 'Dia'
                                    ? flagTempo = true
                                    : flagTempo = false;
                                setState(() {
                                  selectTempo = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 12, 31, 12),
                        child: TextFormField(
                          controller: dias,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Informe quanto tempo',
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Informe quantos dias!';
                            }
                            if (flagTempo == true) {
                              tempoDigitado = num.parse(value);
                            } else if (flagTempo == false) {
                              tempoDigitado = num.parse(value) * 30;
                            } else {
                              return 'Informe o tempo no campo superior!';
                            }
                            dataVacVencimento = dataAtual!
                                .add(Duration(days: tempoDigitado as int));
                            dataPtVacVencimento =
                                DateFormat(DateFormat.YEAR_MONTH_DAY, 'pt_Br')
                                    .format(dataVacVencimento!);
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                        child: dataPtVacVencimento != null
                            ? Text('Data de vencimento: $dataPtVacVencimento.',
                                style: const TextStyle(fontSize: 16))
                            : const Text('Sem data de vencimento.'),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 32, 24, 12),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState?.save();
                              setState(() {
                                dataPtVacVencimento;
                              });
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
                                  'Verificar data',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState?.save();

                              if (selectPet != null &&
                                  nomeVacinaDigitado != null &&
                                  dataVacAplicado != null &&
                                  dataVacVencimento != null &&
                                  idUser != null &&
                                  idPet != null) {
                                await _addVacina(
                                    nomeVacinaDigitado!,
                                    dataVacAplicado!,
                                    dataVacVencimento!,
                                    idUser!, idPet!,
                                    selectPet!);
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ConsultaVacina extends StatefulWidget {
  const ConsultaVacina({Key? key}) : super(key: key);

  @override
  State<ConsultaVacina> createState() => _ConsultaVacinaState();
}

class _ConsultaVacinaState extends State<ConsultaVacina> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void lauchWpp({@required number, @required message}) async {
    final url = 'whatsapp://send?phone=$number&text=$message';
    final uri = Uri.parse('whatsapp://send?phone=$number&text=$message');

    await canLaunchUrl(uri) ? launch(url) : print("não abriu o wpp");
  }

  Stream<QuerySnapshot> _getList() {
    return _firestore.collectionGroup('vacinas').snapshots();
  }

  DateTime dataAtual = DateTime.now();
  DateTime? dataNotificacao;
  String? dataPtExibir;
  String? celularnotificacao;
  String? nome;
  final celularPorCard = [];
  int count = 0;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  Future<String?> _getCelular(String idUser) async {
    var colletion = FirebaseFirestore.instance.collection('clientes');
    var result = await colletion.get();
    for (var doc in result.docs) {
      if (doc.id == idUser) {
        celularnotificacao = doc['celular'];
        nome = doc['nome'];
        return celularnotificacao;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consulta de vacinas'),
      ),
      backgroundColor: Colors.blue.shade50,
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: StreamBuilder<QuerySnapshot>(
                stream: _getList(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:

                    case ConnectionState.waiting:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );

                    case ConnectionState.active:

                    case ConnectionState.done:
                      if (snapshot.data!.docs.isEmpty) {
                        return const Center(
                          child: Text(
                              'Não possui vacinas para notificar vencimento.'),
                        );
                      }
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final DocumentSnapshot doc =
                                snapshot.data!.docs[index];
                            dataNotificacao = doc['dataVencimento'].toDate();
                            dataPtExibir =
                                DateFormat(DateFormat.YEAR_MONTH_DAY, 'pt_Br')
                                    .format(dataNotificacao!);
                            if (dataNotificacao!.difference(dataAtual).inDays <
                                7) {
                              return Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(28, 12, 28, 12),
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.5, color: Colors.blue.shade200),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(6.0)),
                                    color: Colors.white,
                                  ),
                                  child: cardVac(
                                      doc['nomeVacina'],
                                      doc['idUser'],
                                      doc['nomeVacina'],
                                      doc['nomePet']),
                                ),
                              );
                            }
                            return const Text('');
                          });
                  }
                }),
          )),
    );
  }

  Widget cardVac(String doc, String idUser, String nomeVacina, String nomePet) {
    return Column(
      children: [
        GestureDetector(
              onTap: () async {
                await 
                _getCelular(idUser);
                lauchWpp(
                      number: celularnotificacao,
                      message:
                          "Olá $nome, a vacina: $nomeVacina, do seu pet: $nomePet, está para vencer na data de: $dataPtExibir");
                  count++;
              },
              child: ListTile(
                title: Text(
                  doc,
                  style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
                ),
                subtitle: Text('Venc.: $dataPtExibir.',
                    style: const TextStyle(
                        fontSize: 16.0, height: 2, fontWeight: FontWeight.w600)),
                trailing: const Icon(Icons.whatsapp_outlined),
              ),
            ),  
      ],
    );
  }
}

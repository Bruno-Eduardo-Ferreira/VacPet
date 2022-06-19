import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'cadastro_pet_presenter.dart';

class GetCadastroPet implements ICadastroPet {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _idUser = '';
  String get idUser => _idUser;
  set idUser(String idUser) => _idUser = idUser;

  List _clientesCadastrados = [];
  List get clientesCadastrados => _clientesCadastrados;
  set clientesCadastrados(List clientesCadastrados) =>
      _clientesCadastrados = clientesCadastrados;

  @override
  Future addPet(String nomeDono, String nomePet, String idadePet,
      String sexoPet, String pesoPet, String racaPet, String idUser) async {
    await _firestore.collection('clientes').doc(idUser).collection('pets').add({
      'nomeDono': nomeDono,
      'nomePet': nomePet,
      'idade': idadePet,
      'sexo': sexoPet,
      'peso': pesoPet,
      'raca': racaPet,
    });
  }

  @override
  Future getUserId(String user) async {
    var colletion = _firestore.collection('clientes');
    var result = await colletion.get();
    for (var doc in result.docs) {
      if (doc['nome'] == user) {
        idUser = doc.id;
      }
    }
  }

  @override
  Future getUsers(VoidCallback attdono) async {
    var colletion = _firestore.collection('clientes');
    var result = await colletion.get();
    for (var doc in result.docs) {
      clientesCadastrados.add(doc['nome']);
      attdono();
    }
  }
}

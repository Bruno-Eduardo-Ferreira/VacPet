import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:vacpet/presentation/pages/home/home_page.dart';

class CadastroCliente extends StatefulWidget {
  const CadastroCliente({Key? key}) : super(key: key);

  @override
  State<CadastroCliente> createState() => _CadastroClienteState();
}

class _CadastroClienteState extends State<CadastroCliente> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final nome = TextEditingController();
  final cpf = TextEditingController();
  final celular = TextEditingController();
  final endereco = TextEditingController();
  final maskCpf = MaskTextInputFormatter(mask: "###.###.###.##", type: MaskAutoCompletionType.eager);
  final maskCel = MaskTextInputFormatter(mask: "(##) #####-####", type: MaskAutoCompletionType.eager);

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _addCliente(
    String nome,
    String cpf,
    String celular,
    String endereco,
  ) async {
    await _firestore.collection('clientes').add({
      'nome': nome,
      'cpf': cpf,
      'celular': celular,
      'endereço': endereco,
    });
  }

  String? nomeDigitado;
  String? cpfDigitado;
  String? celularDigitado = '+';
  String? enderecoDigitado;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de clientes'),
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
                        padding: const EdgeInsets.fromLTRB(24, 6, 24, 6),
                        child: TextFormField(
                            controller: nome,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Nome',
                            ),
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Informe algum nome!';
                              } else if (value.length > 80) {
                                return 'São permitidos no máximo 80 caracteres para o nome!';
                              }
                              nomeDigitado = value;
                              return null;
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 6, 24, 6),
                        child: TextFormField(
                          inputFormatters: [maskCpf],
                          controller: cpf,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'CPF',
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Informe algum cpf!';
                            } else if (value.length != 14) {
                              return 'Verifique a quantidade de números informados!';
                            }
                            cpfDigitado = value;
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 6, 24, 6),
                        child: TextFormField(
                          inputFormatters: [maskCel],
                          controller: celular,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Número do celular',
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Informe algum número de celular!';
                            } else if (value.length != 15) {
                              return 'Verifique a quantidade de números informados!';
                            }
                            celularDigitado = celularDigitado! + value;
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 6, 24, 6),
                        child: TextFormField(
                          controller: endereco,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Endereço',
                          ),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Informe algum endereço!';
                            }
                            enderecoDigitado = value;
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
                                  cpfDigitado != null &&
                                  celularDigitado != null &&
                                  enderecoDigitado != null) {
                                await _addCliente(
                                  nomeDigitado!,
                                  cpfDigitado!,
                                  celularDigitado!,
                                  enderecoDigitado!,
                                );
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

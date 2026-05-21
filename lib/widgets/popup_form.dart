import 'package:flutter/material.dart';
import 'dart:ui';
import '../models/item_model.dart';
import '../controllers/colecao_controller.dart';

void mostrarPopupFormulario(BuildContext context, ColecaoController controller, {ItemColecao? itemAntigo}) {
  final _formKey = GlobalKey<FormState>();
  final nomeCtrl = TextEditingController(text: itemAntigo?.nomeAlbum ?? '');
  final artistaCtrl = TextEditingController(text: itemAntigo?.artista ?? '');
  final generoCtrl = TextEditingController(text: itemAntigo?.genero ?? '');
  final anoCtrl = TextEditingController(text: itemAntigo?.anoLancamento?.toString() ?? '');
  final valorCtrl = TextEditingController(text: itemAntigo?.valorPago?.toString() ?? '');

  showDialog(
    context: context,
    builder: (context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Fundo borrado
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          content: SizedBox(
            width: 400,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextFormField(
                    controller: nomeCtrl,
                    decoration: const InputDecoration(labelText: 'Nome do Álbum/Single'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Informe o nome do álbum.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: artistaCtrl,
                    decoration: const InputDecoration(labelText: 'Artista'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Informe o nome do artista.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: generoCtrl,
                    decoration: const InputDecoration(labelText: 'Gênero'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Informe o gênero.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: anoCtrl,
                    decoration: const InputDecoration(labelText: 'Lançamento'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Informe o ano de lançamento.';
                      }
                      final ano = int.tryParse(value);
                      if (ano == null || ano < 1800 || ano > DateTime.now().year + 1) {
                        return 'Ano inválido.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: valorCtrl,
                    decoration: const InputDecoration(labelText: 'Valor pago'),
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Informe o valor pago.';
                      }
                      final valor = double.tryParse(value.replaceAll(',', '.'));
                      if (valor == null) {
                        return 'Valor inválido.';
                      }
                      if (valor < 0) {
                        return 'O valor não pode ser negativo.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.upload),
                    label: const Text('Capa do Álbum'),
                    onPressed: () {}, // upload decorativo, ainda não implementado
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff0d4f9f)),
                      child: const Text('CONTINUAR', style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final novoItem = ItemColecao(
                            nomeAlbum: nomeCtrl.text,
                            artista: artistaCtrl.text,
                            genero: generoCtrl.text,
                            anoLancamento: int.tryParse(anoCtrl.text) ?? 0,
                            valorPago: double.tryParse(valorCtrl.text) ?? 0.0,
                            caminhoCapa: itemAntigo?.caminhoCapa,
                          );
                          if (itemAntigo == null) {
                            controller.adicionarAlbum(novoItem);
                          } else {
                            // Atualiza o id do novoItem para manter o mesmo registro
                            final atualizado = ItemColecao(
                              id: itemAntigo.id,
                              nomeAlbum: novoItem.nomeAlbum,
                              artista: novoItem.artista,
                              genero: novoItem.genero,
                              anoLancamento: novoItem.anoLancamento,
                              valorPago: novoItem.valorPago,
                              caminhoCapa: novoItem.caminhoCapa,
                            );
                            controller.atualizarAlbum(atualizado);
                          }
                          Navigator.pop(context); // Fecha pop-up
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

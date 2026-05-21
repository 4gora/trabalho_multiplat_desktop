import 'package:flutter/material.dart';
import 'dart:ui';
import '../models/item_model.dart';
import '../controllers/colecao_controller.dart';
import 'popup_form.dart';

void mostrarOpcoesItem(BuildContext context, ItemColecao item, ColecaoController controller) {
  showDialog(
    context: context,
    builder: (context) {
      return Align(
        alignment: Alignment.bottomLeft,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Fundo borrado
          child: Card(
            margin: const EdgeInsets.all(32),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('O que deseja fazer com esse item?'),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        icon: const Icon(Icons.edit),
                        label: const Text('EDITAR'),
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff0d4f9f)),
                        onPressed: () {
                          Navigator.pop(context);
                          mostrarPopupFormulario(context, controller, itemAntigo: item);
                        },
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.delete),
                        label: const Text('DELETAR'),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                        onPressed: () {
                          Navigator.pop(context);
                          mostrarConfirmacaoDeletar(context, item.id!, controller);
                        },
                      ),
                    ],
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

void mostrarConfirmacaoDeletar(BuildContext context, int id, ColecaoController controller) {
  showDialog(
    context: context,
    builder: (context) {
      return Align(
        alignment: Alignment.bottomLeft,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Fundo borrado
          child: Card(
            margin: const EdgeInsets.all(32),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Tem certeza que deseja deletar?'),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        child: const Text('VOLTAR'),
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff0d4f9f)),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.delete),
                        label: const Text('DELETAR'),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                        onPressed: () async {
                          await controller.deletarAlbum(id);
                          Navigator.pop(context); // Fecha pop-up
                        },
                      ),
                    ],
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

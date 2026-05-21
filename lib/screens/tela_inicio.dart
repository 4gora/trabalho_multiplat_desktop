import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../controllers/colecao_controller.dart';
import '../widgets/popup_form.dart';
import '../widgets/popup_deletar.dart';

class InicioScreen extends StatefulWidget {
  const InicioScreen({super.key});

  @override
  State<InicioScreen> createState() => _InicioScreenState();
}

class _InicioScreenState extends State<InicioScreen> {
  // instancia o controlador que gerencia os dados e regras
  final ColecaoController _controller = ColecaoController();

  @override
  void initState() {
    super.initState();
    // busca inicial dos itens no sql
    _controller.carregarAlbuns();
  }

  void _abrirPopupFormulario(BuildContext context) {
    mostrarPopupFormulario(context, _controller);
  }

  void _abrirPopupOpcoes(BuildContext context, ItemColecao item) {
    mostrarOpcoesItem(context, item, _controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, _) {
          if (_controller.estaCarregando) {
            return const Center(child: CircularProgressIndicator());
          }

          return Row(
            children: [
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header - Logo Musicolector
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 32.0),
                          child: Text(
                            'Musicolector',
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Color(0xff0d4f9f), // Azul do seu design
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: _buildResumoCard(
                              titulo: 'Itens na coleção',
                              valor: '${_controller.quantidadeTotal}',
                              corValor: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildResumoCard(
                              titulo: 'Valor da coleção',
                              valor:
                                  'R\$ ${_controller.valorTotalInvestido.toStringAsFixed(2).replaceAll('.', ',')}',
                              corValor: const Color(
                                0xff2ecc71,
                              ), 
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      const Text(
                        'Última adição',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildUltimaAdicaoCard(),

                      const Spacer(),

                      Row(
                        children: [
                          Expanded(
                            child: _buildBotaoAcao(
                              titulo: 'Adicionar item',
                              icone: Icons.add,
                              onTap: () => _abrirPopupFormulario(context),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              Container(width: 1, color: Colors.grey.shade300),

              Expanded(
                flex: 4,
                child: Container(
                  color: const Color(
                    0xffeaeaea,
                  ), // Fundo um pouco mais escuro para a lista
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.all(16),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'Itens recentes',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),

                      Expanded(
                        child: _controller.albuns.isEmpty
                            ? const Center(
                                child: Text('Nenhum álbum cadastrado ainda.'),
                              )
                            : ListView.builder(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                itemCount: _controller.albuns.length,
                                itemBuilder: (context, index) {
                                  final album = _controller.albuns[index];
                                  return _buildAlbumCard(album);
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildResumoCard({
    required String titulo,
    required String valor,
    required Color corValor,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Text(
            titulo,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            valor,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: corValor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUltimaAdicaoCard() {
    if (_controller.albuns.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(child: Text('Nenhum dado disponível')),
      );
    }

    // Pega o ultimo item da lista
    final ultimo = _controller.albuns.last;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          // Placeholder para a Capa do Álbum
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.music_note,
              size: 40,
              color: Colors.blueGrey,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ultimo.nomeAlbum,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  ultimo.artista,
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                ),
                const SizedBox(height: 8),
                Text(
                  'Gênero: ${ultimo.genero}',
                  style: const TextStyle(fontSize: 14),
                ),
                Text(
                  'Ano: ${ultimo.anoLancamento}',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBotaoAcao({
    required String titulo,
    required IconData icone,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          children: [
            Icon(icone, size: 32, color: Colors.black87),
            const SizedBox(height: 8),
            Text(
              titulo,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlbumCard(ItemColecao album) {
    return GestureDetector(
      onTap: () => _abrirPopupOpcoes(context, album),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Icon(Icons.album, color: Colors.grey),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    album.nomeAlbum,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    album.artista,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  ),
                  Text(
                    'Gênero: ${album.genero}',
                    style: const TextStyle(color: Colors.black87, fontSize: 12),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Ano: ${album.anoLancamento}',
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

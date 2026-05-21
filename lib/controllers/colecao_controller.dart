import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../services/database_service.dart';

class ColecaoController extends ChangeNotifier {
  final DatabaseService _dbService = DatabaseService();
  
  List<ItemColecao> _albuns = [];
  bool _estaCarregando = false;

  List<ItemColecao> get albuns => _albuns;
  bool get estaCarregando => _estaCarregando;

  // variaveis de busca e filtro
  String _buscaAtual = '';
  String? _generoFiltrado;

  // 1. Total investido (soma de todos os valores pagos)
  double get valorTotalInvestido {
    return _albuns.fold(0.0, (soma, album) => soma + album.valorPago);
  }

  // valorização estimada de 20 % sobre o valor pago para simular um valor de mercado
  double get valorTotalEstimado {
    return _albuns.fold(0.0, (soma, album) => soma + (album.valorPago * 1.2));
  }

  // 3. Quantidade total de itens na coleção
  int get quantidadeTotal => _albuns.length;

  // 4. Contagem de itens por genero
  int contarPorGenero(String genero) {
    return _albuns.where((album) => album.genero.toLowerCase() == genero.toLowerCase()).length;
  }

  // busca por texto
  Future<void> carregarAlbuns() async {
    _estaCarregando = true;
    notifyListeners();

    try {
      _albuns = await _dbService.listarItens(buscaNome: _buscaAtual);

      // Filtro por genero
      if (_generoFiltrado != null && _generoFiltrado!.isNotEmpty) {
        _albuns = _albuns
            .where((album) => album.genero.toLowerCase() == _generoFiltrado!.toLowerCase())
            .toList();
      }
    } catch (e) {
      debugPrint('Erro ao carregar álbuns: $e');
    } finally {
      _estaCarregando = false;
      notifyListeners(); // Faz a tela atualizar com nvoso dados
    }
  }

  // Aplica os filtros de busca e genero
  void aplicarFiltros({String? busca, String? genero}) {
    if (busca != null) _buscaAtual = busca;
    _generoFiltrado = genero;
    carregarAlbuns();
  }

  // Reseta a tela para o estado inicial sem filtros
  void limparFiltros() {
    _buscaAtual = '';
    _generoFiltrado = null;
    carregarAlbuns();
  }

// crud encapsulado
  Future<void> adicionarAlbum(ItemColecao album) async {
    await _dbService.cadastrarItem(album); // Salva no SQLite
    await carregarAlbuns(); // atualiza e recarrega a lista
  }

  Future<void> atualizarAlbum(ItemColecao album) async {
    await _dbService.editarItem(album); // Atualiza no SQLite
    await carregarAlbuns();
  }

  Future<void> deletarAlbum(int id) async {
    await _dbService.excluirItem(id); // Remove do SQlite
    await carregarAlbuns();
  }
}
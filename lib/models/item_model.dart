class ItemColecao {
  int? id;
  String nomeAlbum;
  String artista;
  String genero;
  int anoLancamento;
  double valorPago;
  String? caminhoCapa;

  ItemColecao({
    this.id,
    required this.nomeAlbum,
    required this.artista,
    required this.genero,
    required this.anoLancamento,
    required this.valorPago,
    required this.caminhoCapa,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nomeAlbum': nomeAlbum,
      'artista': artista,
      'genero': genero,
      'anoLancamento': anoLancamento,
      'valorPago': valorPago,
      'caminhoCapa': caminhoCapa,
    };
  }

  factory ItemColecao.fromMap(Map<String, dynamic> map) {
    return ItemColecao(
      id: map['id'],
      nomeAlbum: map['nomeAlbum'],
      artista: map['artista'],
      genero: map['genero'],
      anoLancamento: map['anoLancamento'],
      valorPago: map['valorPago'],
      caminhoCapa: map['caminhoCapa'],
    );
  }
}

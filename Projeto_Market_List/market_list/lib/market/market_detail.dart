import 'package:hive/hive.dart';

// Parte do código gerada pelo Hive para lidar com a serialização
part 'market_detail.g.dart';

// Anotando a classe com HiveType para identificar que essa classe é um tipo que será armazenado no Hive
@HiveType(typeId: 3)
class MarketDetail {
  // Campos para armazenar detalhes do mercado, cada um com um identificador de campo HiveField
  @HiveField(0)
  final String storeName; // Nome da loja

  @HiveField(1)
  final String listName; // Nome da lista de compras

  @HiveField(2)
  final double value; // Valor da compra

  // Construtor para inicializar os campos, todos são obrigatórios
  MarketDetail({
    required this.storeName,
    required this.listName,
    required this.value,
  });
}

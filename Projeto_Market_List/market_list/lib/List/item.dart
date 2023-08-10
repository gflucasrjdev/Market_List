import 'package:hive/hive.dart';

// Parte do código gerada pelo Hive para lidar com a serialização
part 'item.g.dart';

// Anotando a classe com HiveType para identificar que essa classe é um tipo que será armazenado no Hive
@HiveType(typeId: 0)
class Item {
  // Campo para armazenar o nome do item, marcado com um identificador de campo HiveField
  @HiveField(0)
  final String name;

  // Campo para armazenar o status de compra do item, também marcado com um identificador de campo HiveField
  @HiveField(1)
  bool isBought;

  // Construtor para inicializar o nome do item, com opção de definir o status de compra (padrão é false)
  Item({required this.name, this.isBought = false});
}

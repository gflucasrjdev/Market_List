// Importando o pacote Hive para lidar com o armazenamento de dados locais.
import 'package:hive/hive.dart';
// Importando o arquivo de definição do Item para ser utilizado na lista de compras.
import 'item.dart';

// Parte necessária para o código gerado pelo Hive.
part 'shopping_list.g.dart';

// Definindo o tipo para armazenamento no Hive com um identificador único.
@HiveType(typeId: 1)
class ShoppingList {
  // Campo para armazenar o nome da lista de compras. É obrigatório.
  @HiveField(0)
  final String name;

  // Campo para armazenar os itens da lista de compras. É uma lista de objetos do tipo Item.
  @HiveField(1)
  final List<Item> items;

  // Campo para armazenar a data de criação da lista de compras. É útil para organização e rastreamento.
  @HiveField(2)
  final DateTime dateCreated;

  // Construtor da classe, com todos os campos obrigatórios, para garantir que o objeto seja válido no momento da criação.
  ShoppingList({required this.name, required this.items, required this.dateCreated});
}


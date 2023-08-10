import 'package:flutter/material.dart';
import 'package:market_list/List/shopping_list.dart';
import 'package:market_list/List/item.dart';
import 'package:hive/hive.dart';
import 'package:market_list/market/market_detail.dart';
import 'package:market_list/market/market_detail_list.dart';

// Classe para exibir os detalhes de uma lista de compras específica.
class ListDetailsScreen extends StatefulWidget {
  final ShoppingList shoppingList; // Lista de compras atual

  const ListDetailsScreen({super.key, required this.shoppingList});

  @override
  // ignore: library_private_types_in_public_api
  _ListDetailsScreenState createState() => _ListDetailsScreenState();
}

class _ListDetailsScreenState extends State<ListDetailsScreen> {
  final TextEditingController _controller =
      TextEditingController(); // Controlador para capturar o texto do item

  // Função para abrir um diálogo e adicionar um novo item à lista de compras.
  void _addItem() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Adicionar item'),
            content: TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Nome do produto'),
              style: const TextStyle(
                fontFamily: 'Raleway', // Definindo a fonte como 'Raleway'
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    setState(() {
                      // Adiciona o item à lista e salva no Hive.
                      widget.shoppingList.items
                          .add(Item(name: _controller.text));
                      final box = Hive.box<ShoppingList>('shoppingLists');
                      final index =
                          box.values.toList().indexOf(widget.shoppingList);
                      if (index != -1) {
                        box.putAt(index, widget.shoppingList);
                      }
                    });
                  }
                  _controller.clear();
                  Navigator.of(context).pop();
                },
                child: const Text('Adicionar'),
              ),
              TextButton(
                onPressed: () {
                  _controller.clear();
                  Navigator.of(context)
                      .pop(); // Fecha o diálogo sem adicionar o item
                },
                child: const Text('Cancelar'),
              ),
            ],
          );
        });
  }

  // Função para abrir a tela de detalhes do mercado.
  Future<void> _openMarketDetail() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MarketDetailScreen(),
      ),
    );

    if (result != null) {
      setState(() {
        // Atualiza o estado com o resultado aqui, se aplicável.
      });
    }
  }

  // Constrói a interface do usuário para os detalhes da lista.
  @override
  Widget build(BuildContext context) {
    final box = Hive.box<MarketDetail>(
        'marketDetails'); // Carrega os detalhes do mercado
    final marketDetails = box.values
        .where((detail) => detail.listName == widget.shoppingList.name)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.shoppingList.name),
      ),
      body: ListView(
        children: [
          // Exibe os detalhes do mercado, se disponíveis.
          if (marketDetails.isNotEmpty)
            Column(
              children: marketDetails.map((detail) {
                return ListTile(
                  title: Text('Estabelecimento: ${detail.storeName}',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('Valor: R\$${detail.value.toString()}',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                );
              }).toList(),
            ),
          // Exibe os itens da lista de compras, com efeito de riscado se comprado.
          ...widget.shoppingList.items.map((item) {
            return ListTile(
              title: Text(
                item.name,
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  decoration: item.isBought ? TextDecoration.lineThrough : null,
                ),
              ),
              leading: Checkbox(
                value: item.isBought,
                activeColor: Colors.green,
                onChanged: (bool? newValue) {
                  setState(() {
                    // Altera o estado do item e salva no Hive.
                    item.isBought = newValue ?? false;
                    final box = Hive.box<ShoppingList>('shoppingLists');
                    final index =
                        box.values.toList().indexOf(widget.shoppingList);
                    if (index != -1) {
                      box.putAt(index, widget.shoppingList);
                    }
                  });
                },
              ),
            );
          }).toList(),
        ],
      ),
      // Barra de navegação inferior com botões para adicionar item e visualizar detalhes do mercado.
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: _addItem,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(180, 50),
                elevation: 5,
              ), // Chama a função para adicionar item
              child: const Text('Adicionar Item'),
            ),
            ElevatedButton(
              onPressed: _openMarketDetail,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(180, 50),
                elevation: 5,
              ), // Chama a função para visualizar detalhes do mercado
              child: const Text('Detalhes do Mercado'),
            ),
          ],
        ),
      ),
    );
  }
}

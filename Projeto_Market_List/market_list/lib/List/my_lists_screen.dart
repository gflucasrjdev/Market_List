import 'package:flutter/material.dart';
import 'package:market_list/List/shopping_list.dart';
import 'package:market_list/List/list_details_screen.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart'; // Para formatação de data

class MyListsScreen extends StatefulWidget {
  const MyListsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyListsScreenState createState() => _MyListsScreenState();
}

class _MyListsScreenState extends State<MyListsScreen> {
  @override
  Widget build(BuildContext context) {
    final listsBox = Hive.box<ShoppingList>('shoppingLists'); // Acesso à caixa do Hive para as listas de compras

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Minhas Listas',
          style: TextStyle(
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold,
            fontSize: 18.0, // Personalize o tamanho da fonte
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: listsBox.length,
        itemBuilder: (context, index) {
          final list = listsBox.getAt(index);
          final dateCreated = list != null
              ? DateFormat('dd/MM/yyyy').format(list.dateCreated)
              : '';
          return ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  list?.name ?? '',
                  style: const TextStyle(
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0, // Personalize o tamanho da fonte
                  ),
                ),
                Text(
                  dateCreated,
                  style: const TextStyle(
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0, // Personalize o tamanho da fonte
                  ),
                ),
              ],
            ),
            onTap: () {
              if (list != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListDetailsScreen(shoppingList: list),
                  ),
                ).then((_) {
                  setState(() {}); // Atualiza a tela quando retorna da página de detalhes
                });
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.delete),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text(
                'Apagar Lista',
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0, // Personalize o tamanho da fonte
                ),
              ),
              content: Container(
                width: double.maxFinite,
                child: ListView.builder(
                  itemCount: listsBox.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final list = listsBox.getAt(index);
                    return ListTile(
                      title: Text(
                        list?.name ?? '',
                        style: const TextStyle(
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0, // Personalize o tamanho da fonte
                        ),
                      ),
                      onTap: () {
                        if (list != null) {
                          listsBox.deleteAt(index); // Apaga o item selecionado da caixa do Hive
                          Navigator.of(context).pop();
                          setState(() {});
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

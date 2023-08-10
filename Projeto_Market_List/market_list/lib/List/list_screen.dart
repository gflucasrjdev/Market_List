import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:market_list/List/item.dart';
import 'package:market_list/List/shopping_list.dart';
import 'package:market_list/List/list_details_screen.dart';

class ListScreen extends StatefulWidget {
  final Box<Item> itemsBox;

  const ListScreen({Key? key, required this.itemsBox}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _listNameController = TextEditingController();
  final List<Item> currentItems = [];
  DateTime selectedDate = DateTime.now(); // Armazenar a data selecionada para a lista

  @override
  Widget build(BuildContext context) {
    final listsBox = Hive.box<ShoppingList>('shoppingLists');

    return Scaffold(
      appBar: AppBar(title: const Text('Nova Lista', style: TextStyle(fontFamily: 'Raleway'))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _selectDate(context), // Selecionar data através do calendário
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today),
                        const SizedBox(width: 8),
                        Text("${selectedDate.toLocal()}".split(' ')[0],
                            style: const TextStyle(fontFamily: 'Raleway')), // Mostra a data selecionada
                      ],
                    ),
                  ),
                ),
              ],
            ),
            TextField(
              controller: _listNameController,
              decoration: const InputDecoration(labelText: 'Nome da Lista'),
              style: const TextStyle(fontFamily: 'Raleway'),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(labelText: 'Produto a quantidade ou o kg'),
                    style: const TextStyle(fontFamily: 'Raleway'),
                  ),
                ),
                FloatingActionButton(
                  onPressed: () {
                    final String productName = _controller.text.trim();
                    if (productName.isNotEmpty) {
                      final item = Item(name: productName);
                      currentItems.add(item); // Adicionar item à lista atual
                      _controller.clear(); // Limpar o campo após adicionar
                      setState(() {});
                    }
                  },
                  backgroundColor: Colors.blue,
                  mini: true,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: currentItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(currentItems[index].name, style: const TextStyle(fontFamily: 'Raleway')),
                  ); // Exibir os itens atuais na lista
                },
              ),
            ),
            SizedBox(
              width: 380,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  final String listName = _listNameController.text.trim();
                  if (listName.isNotEmpty && currentItems.isNotEmpty) {
                    final newList = ShoppingList(
                      name: listName,
                      items: currentItems,
                      dateCreated: selectedDate, // Usando a data selecionada
                    );

                    listsBox.add(newList); // Adicionar nova lista à box do Hive
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListDetailsScreen(shoppingList: newList),
                      ),
                    );
                    Navigator.pushNamedAndRemoveUntil(context, '/homescreen', (route) => false);
                  } else {
                    // Você pode adicionar uma mensagem de erro aqui
                  }
                },
                child: const Text('Salvar Lista', style: TextStyle(fontFamily: 'Raleway')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        ) ??
        selectedDate;
    if (picked != selectedDate) {
      setState(() {
        selectedDate = picked; // Atualizar a data selecionada se for diferente da anterior
      });
    }
  }
}

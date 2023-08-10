import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:market_list/List/shopping_list.dart';
import 'package:market_list/market/market_detail.dart';

class MarketDetailScreen extends StatefulWidget {
  const MarketDetailScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MarketDetailScreenState createState() => _MarketDetailScreenState();
}

class _MarketDetailScreenState extends State<MarketDetailScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Chave global para controle do formulário
  TextEditingController storeNameController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  ShoppingList? selectedShoppingList; // Lista de compras selecionada no menu suspenso

  // Função para adicionar detalhes do mercado
  void _addMarketDetail() {
    if (_formKey.currentState!.validate() && selectedShoppingList != null) {
      // Criando o objeto com os detalhes do mercado
      final marketDetail = MarketDetail(
        storeName: storeNameController.text,
        listName: selectedShoppingList!.name,
        value: double.parse(valueController.text),
      );

      // Adicionando o objeto ao banco de dados Hive
      final box = Hive.box<MarketDetail>('marketDetails');
      box.add(marketDetail);

      // Mostrando uma mensagem de sucesso
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Informações gravadas com sucesso!')),
      );

      // Retornando verdadeiro para indicar sucesso
      Navigator.pop(context, true); 
    }
  }

  @override
  Widget build(BuildContext context) {
    // Obtendo a lista de compras
    final box = Hive.box<ShoppingList>('shoppingLists');
    final shoppingLists = box.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detalhes da Compra',
          style: TextStyle(fontFamily: 'Raleway'),
        ),
      ),
      body: Form(
        key: _formKey, // Atribuindo a chave ao formulário
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Campo para inserir o nome da loja
              TextFormField(
                controller: storeNameController,
                decoration: const InputDecoration(labelText: 'Nome do Estabelecimento'),
                validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              // Menu suspenso para selecionar a lista de compras
              DropdownButtonFormField(
                decoration: const InputDecoration(labelText: 'Nome da Lista'),
                value: selectedShoppingList,
                items: shoppingLists.map((list) {
                  return DropdownMenuItem(
                    value: list,
                    child: Text(list.name),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedShoppingList = value;
                  });
                },
                validator: (value) => value == null ? 'Campo obrigatório' : null,
              ),
              // Campo para inserir o valor
              TextFormField(
                controller: valueController,
                decoration: const InputDecoration(
                  labelText: 'Valor',
                  hintText: 'Ex: 10.00',
                ),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null, // Desabilitando o efeito de herói
        onPressed: _addMarketDetail, // Chamando a função para adicionar os detalhes do mercado
        child: const Icon(Icons.add),
      ),
    );
  }
}

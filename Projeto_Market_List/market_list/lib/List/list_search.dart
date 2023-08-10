import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:market_list/List/shopping_list.dart';
import 'package:market_list/List/list_details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // Controlador para monitorar o termo de pesquisa
  final TextEditingController _searchController = TextEditingController();
  // Armazena o termo de pesquisa em letras minúsculas para comparação insensível a maiúsculas/minúsculas
  String _searchTerm = '';

  @override
  Widget build(BuildContext context) {
    // Acessando o box do Hive para as listas de compras
    final listsBox = Hive.box<ShoppingList>('shoppingLists');

    return WillPopScope(
      // Trata o evento de pressionar o botão voltar, navegando para a Home Screen
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/homescreen');
        return false; // Impede que a ação padrão do botão voltar seja ativada
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pesquisar Listas'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pushReplacementNamed(context, '/homescreen'), // Ação de ir para a Home Screen
          ),
        ),
        body: Column(
          children: [
            // Campo de texto para inserir o termo de pesquisa
            TextField(
              controller: _searchController,
              onChanged: (value) {
                // Atualiza o termo de pesquisa, convertendo para minúsculas
                setState(() {
                  _searchTerm = value.toLowerCase();
                });
              },
              decoration: const InputDecoration(
                labelText: 'Pesquisar',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            // Exibe as listas que correspondem ao termo de pesquisa
            Expanded(
              child: ListView.builder(
                itemCount: listsBox.length,
                itemBuilder: (context, index) {
                  final list = listsBox.getAt(index);
                  // Verifica se a lista corresponde ao termo de pesquisa, ignorando a diferença entre maiúsculas e minúsculas
                  if (list != null && (list.name.toLowerCase().startsWith(_searchTerm) || _searchTerm.isEmpty)) {
                    return ListTile(
                      title: Text(list.name),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ListDetailsScreen(shoppingList: list), // Navega para os detalhes da lista
                          ),
                        );
                      },
                    );
                  } else {
                    // Retorna um container vazio se não houver correspondência
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

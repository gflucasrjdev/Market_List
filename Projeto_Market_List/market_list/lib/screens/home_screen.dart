import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:market_list/List/shopping_list.dart';
import 'package:market_list/screens/app_drawer.dart';
import 'package:market_list/screens/bottom_navigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late Future<Box<ShoppingList>>
      listsBoxFuture; // Futura caixa de listas de compras

  // Função chamada ao criar uma nova lista
  void _onCreateNewList() {
    Navigator.pushNamed(context, '/newlist');
  }

  // Função chamada quando um item da barra de navegação é tocado
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 1) {
      Navigator.pushNamed(context, '/search');
    }
  }

  // Inicializando a caixa de listas de compras
  @override
  void initState() {
    super.initState();
    listsBoxFuture = Hive.openBox<ShoppingList>('shoppingLists');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: FutureBuilder<Box<ShoppingList>>(
        future: listsBoxFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // Registrar o erro no console
            print('Erro ao abrir a caixa: ${snapshot.error}');
            return const Text('Erro ao abrir a caixa.');
          }

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(),
            drawer: const AppDrawer(),
            body: Stack(
              children: [
                // Exibindo uma mensagem de boas-vindas ou uma página de pesquisa, dependendo da seleção
                _selectedIndex == 0
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Seja bem-vindo ao seu Market List',
                                style: TextStyle(
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20)),
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: _onCreateNewList,
                              child: Image.asset(
                                  'lib/image/new_list_market.png',
                                  height: 150,
                                  width: 150),
                            ),
                            const Text('Nova Lista',
                                style: TextStyle(
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      )
                    : const Text('Pesquisar',
                        style: TextStyle(fontSize: 24, color: Colors.black)),
                Positioned(
                  top: 10,
                  left: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        right: 13.0), // Espaço à direita da seta
                    child: Row(
                      children: [
                        Image.asset('lib/image/seta_home.png',
                            height: 50, width: 50),
                        const Text('Minhas Listas',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black)), // Removido o negrito
                      ],
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigator(
                selectedIndex: _selectedIndex, onTap: _onItemTapped),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: HomeScreen(),
  ));
}

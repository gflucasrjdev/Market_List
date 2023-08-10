// Desenvolvido por Gabriel Ferreira de Lucas
// Contato: gflucasdev@gmail.com
// Descrição: Trabalho final do curso da prodigyan

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:market_list/List/my_lists_screen.dart';
import 'package:market_list/List/list_search.dart';
import 'package:market_list/List/list_screen.dart';
import 'package:market_list/List/item.dart';
import 'package:market_list/List/shopping_list.dart';
import 'package:market_list/screens/home_screen.dart';
import 'package:market_list/screens/carousel_screen.dart';
import 'package:market_list/drawer_content/culinary_measures.dart';
import 'package:market_list/drawer_content/food_calorie.dart';
import 'package:market_list/market/market_detail.dart';


void main() async {
  // Inicializando o Hive para manipulação de dados local.
  await Hive.initFlutter();

  // Registrando os adaptadores para as classes.
  Hive.registerAdapter(ItemAdapter());
  Hive.registerAdapter(ShoppingListAdapter());
  Hive.registerAdapter(MarketDetailAdapter());

  // Abrindo as "boxes" para manipulação dos dados.
  final itemsBox = await Hive.openBox<Item>('items');
  await Hive.openBox<ShoppingList>('shoppingLists');
  await Hive.openBox<MarketDetail>('marketDetails');

  // Iniciando o aplicativo.
  runApp(MyApp(itemsBox: itemsBox));
}

class MyApp extends StatelessWidget {
  final Box<Item> itemsBox;

  // Construtor padrão.
  const MyApp({Key? key, required this.itemsBox}) : super(key: key);

  // Construtor adicional para testes.
  MyApp.forTesting({super.key}) : itemsBox = Hive.box<Item>('items');

  @override
  Widget build(BuildContext context) {
    // Definindo as rotas e a tela inicial do aplicativo.
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const CarouselScreen(), // Tela inicial de carrossel.
        '/homescreen': (context) => const HomeScreen(), // Tela principal do app.
        '/newlist': (context) => ListScreen(itemsBox: itemsBox), // Tela para criar uma nova lista.
        '/mylists': (context) => const MyListsScreen(), // Tela das minhas listas.
        '/search': (context) => const SearchScreen(), // Tela de pesquisa.
        '/culinarymeasures': (context) => CulinaryMeasuresPage(), // Tela de medidas culinárias.
        '/foodcalorie': (context) => FoodCaloriePage(), // Tela de calorias dos alimentos.
      },
    );
  }
}

import 'package:flutter/material.dart';

class BottomNavigator extends StatelessWidget {
  // Define as variáveis para a seleção atual e a função de toque
  final int selectedIndex;
  final Function(int) onTap;

  // Construtor para inicializar as variáveis
  const BottomNavigator({Key? key, required this.selectedIndex, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Constrói a barra de navegação inferior
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        // Primeiro item da barra (Home)
        BottomNavigationBarItem(
          icon: Image.asset('lib/image/home.png', height: 30),
          label: 'Home',
        ),
        // Segundo item da barra (Pesquisar)
        BottomNavigationBarItem(
          icon: Image.asset('lib/image/pesquisar.png', height: 30),
          label: 'Pesquisar',
        ),
      ],
      // Define o índice do item selecionado
      currentIndex: selectedIndex,
      // Estiliza os itens selecionados e não selecionados
      selectedItemColor: const Color(0xFF378ff2),
      unselectedItemColor: Colors.black,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      // Função chamada ao tocar em um item
      onTap: (index) => onTap(index),
      // Estiliza o texto do item selecionado
      selectedLabelStyle: const TextStyle(
        fontSize: 16,
        color: Color(0xFF378ff2),
      ),
      // Estiliza o texto do item não selecionado
      unselectedLabelStyle: const TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
    );
  }
}

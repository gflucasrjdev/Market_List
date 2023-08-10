import 'package:flutter/material.dart';

class CulinaryMeasuresPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medidas Culinárias', style: TextStyle(fontFamily: 'Raleway')),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              child: Image.asset('lib/image/medidas.jpg'),
            ),
            SizedBox(height: 10),
            // Texto centralizado e em negrito para a tabela de conversão
            Center( 
              child: Text(
                'TABELA DE CONVERSÃO DE MEDIDAS DE INGREDIENTES CULINÁRIOS',
                style: TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              'Farinha de trigo:\n120gramas = 1 xícara (chá)\n60gramas = 1/2 xícara (chá)\n30gramas = 1/4 xícara (chá)\n7,5gramas = 1 colher (sopa)\n2,5gramas = 1 colher (chá)\n'
              // Adicione o restante do texto aqui
              'Líquidos (água, óleos, chás, sucos, leite, creme de leite fresco, bebidas alcoólicas etc.)\n240gramas = 240ml = 1 xícara (chá)\n120gramas = 120ml = 1/2 xícara (chá)\n60gramas = 60ml = 1/4 xícara (chá)\n15gramas = 15ml = 1 colher (sopa)\n5gramas = 5ml = 1 colher (chá)\n',
              style: TextStyle(fontFamily: 'Raleway'),
            ),
            // Texto centralizado e em negrito para unidades básicas
            Center( 
              child: Text(
                'UNIDADES BÁSICAS\n',
                style: TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              'No Sistema Internacional de Unidades, há apenas uma unidade básica para\ncada tipo de medida:\nO grama é a unidade básica para medir o peso.\nO litro é a unidade básica para medir o volume.\nO metro é a unidade básica para medir a extensão.\nOs graus Celsius são usados para medir a temperatura.',
              style: TextStyle(fontFamily: 'Raleway'),
            ),
          ],
        ),
      ),
    );
  }
}

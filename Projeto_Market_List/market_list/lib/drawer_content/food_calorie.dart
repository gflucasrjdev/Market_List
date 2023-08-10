import 'package:flutter/material.dart';

class FoodCaloriePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calorias dos Alimentos'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('lib/image/calorias.jpg'),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'A dieta equilibrada em calorias é essencial para manter a saúde e o bem-estar geral do corpo. Consumir calorias em excesso pode levar ao ganho de peso, enquanto a falta pode resultar em desnutrição. Uma dieta balanceada auxilia no controle de peso, ajudando a alcançar e manter um peso saudável. É importante equilibrar as calorias consumidas com as calorias gastas através do exercício físico. Uma alimentação equilibrada proporciona energia suficiente para as atividades diárias sem sobrecarregar o organismo. Focar na qualidade e não apenas na quantidade de calorias promove uma nutrição adequada, fornecendo vitaminas e minerais essenciais. Ter uma dieta de calorias equilibradas contribui para a prevenção de doenças crônicas como diabetes e doenças cardíacas. A contagem e o controle de calorias podem ajudar na tomada de decisões alimentares conscientes e saudáveis. Comer uma variedade de alimentos dentro de um limite calórico ajuda a garantir que todas as necessidades nutricionais sejam atendidas. Em suma, uma dieta equilibrada em calorias é a base para uma vida saudável e ativa, apoiando a saúde física e mental.',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Dez Benefícios de Manter uma Dieta Equilibrada de Calorias', // Título centralizado
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '1. Mantém a saúde geral do corpo\n'
                '2. Controla o peso\n'
                '3. Fornece energia suficiente\n'
                '4. Promove nutrição adequada\n'
                '5. Previne doenças crônicas\n'
                '6. Ajuda na tomada de decisões alimentares conscientes\n'
                '7. Garante necessidades nutricionais atendidas\n'
                '8. Base para uma vida saudável e ativa\n'
                '9. Suporta saúde física e mental\n'
                '10. Auxilia na prevenção de diabetes e doenças cardíacas', // Dicas em negrito
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

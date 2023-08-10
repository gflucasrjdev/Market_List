import 'package:flutter/material.dart';

class CarouselScreen extends StatefulWidget {
  const CarouselScreen({Key? key}) : super(key: key);

  @override
  _CarouselScreenState createState() => _CarouselScreenState();
}

class _CarouselScreenState extends State<CarouselScreen> {
  int _current = 0; // Variável que guarda o índice atual da imagem exibida

  // Lista de caminhos das imagens que serão exibidas no carrossel
  final List<String> imgList = [
    'lib/image/carrosel_image_01.jpg',
    'lib/image/carrosel_image_02.jpg',
    'lib/image/carrosel_image_03.jpg',
  ];

  // Lista de textos que serão exibidos junto com as imagens
  final List<String> textList = [
    "Modernize sua experiência de compra: diga adeus à velha lista de papel e dê as boas-vindas ao nosso aplicativo inteligente.",
    "Compartilhe listas com familiares e amigos. Facilite a colaboração na hora das compras e nunca mais esqueça de nada!",
    "Além de otimizar suas compras, nosso app contribui para a preservação do meio ambiente, reduzindo o uso de papel e contribuindo para um futuro sustentável."
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.5,
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      itemCount: imgList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Expanded(
                              // Exibir a imagem atual do carrossel
                              child: Image.asset(
                                imgList[index],
                                fit: BoxFit.fill,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              // Exibir o texto correspondente à imagem atual do carrossel
                              child: Text(
                                textList[index],
                                style: TextStyle(
                                  fontFamily: 'Raleway',
                                  color: Colors.black,
                                  fontSize: 16,
                                  backgroundColor:
                                      Colors.white.withOpacity(0.7),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        );
                      },
                      // Atualiza o índice atual quando a página é alterada
                      onPageChanged: (value) {
                        setState(() {
                          _current = value;
                        });
                      },
                    ),
                  ),
                  // Se estiver na última imagem, exibe o botão "Vamos-lá"
                  if (_current == imgList.length - 1)
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width -
                            35, // Largura personalizada
                        height: 45, // Altura personalizada
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 5, // Define a elevação da sombra
                          ),
                          child: const Text(
                            'Vamos-lá',
                            style: TextStyle(
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/homescreen');
                          },
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // Cria indicadores para as páginas do carrossel
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(imgList.length, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: 10,
                  width: _current == index ? 30 : 10,
                  margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == index ? Colors.blue : Colors.grey,
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

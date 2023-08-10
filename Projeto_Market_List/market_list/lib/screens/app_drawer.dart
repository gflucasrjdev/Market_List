import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:market_list/List/my_lists_screen.dart';
import 'package:market_list/drawer_content/culinary_measures.dart';
import 'package:market_list/drawer_content/food_calorie.dart';
import 'package:url_launcher/url_launcher.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  // Método para lançar uma URL
  Future<void> launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: const BoxDecoration(color: Colors.blue),
                  child: Image.asset('lib/image/logo.png', width: 100, height: 100),
                ),
                // As ListTiles aqui representam as opções no drawer.
                // Opção para acessar "Minhas Listas"
                ListTile(
                  leading: Image.asset('lib/image/lista.png', height: 24),
                  title: const Text('Minhas Listas', style: TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.bold, fontSize: 16)),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MyListsScreen())),
                ),
                // Opção para acessar "Medidas Culinárias"
                ListTile(
                  leading: Image.asset('lib/image/medidas_list.png', height: 24),
                  title: const Text('Medidas Culinárias', style: TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.bold, fontSize: 16)),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CulinaryMeasuresPage())),
                ),
                // Opção para acessar "Caloria Alimentos"
                ListTile(
                  leading: Image.asset('lib/image/caloria_list.png', height: 24),
                  title: const Text('Caloria Alimentos', style: TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.bold, fontSize: 16)),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FoodCaloriePage())),
                ),
                // Opção para copiar e-mail para sugestões
                ListTile(
                  leading: Image.asset('lib/image/sugestao.png', height: 24),
                  title: Text.rich(
                    TextSpan(
                      text: 'Dicas e sugestões envie-nos uma mensagem ',
                      style: const TextStyle(color: Colors.black, fontFamily: 'Raleway', fontWeight: FontWeight.bold, fontSize: 16),
                      children: [
                        TextSpan(
                          text: 'clique aqui',
                          style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Clipboard.setData(const ClipboardData(text: 'gflucasdev@gmail.com'));
                              Fluttertoast.showToast(msg: "E-mail copiado com sucesso!", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM);
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Opção para sair
          Align(
            alignment: Alignment.centerRight,
            child: ListTile(
              leading: Image.asset('lib/image/sair_drawer.png', height: 24),
              title: const Text('Sair', style: TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.bold, fontSize: 16)),
              onTap: () => Navigator.pushReplacementNamed(context, '/'),
            ),
          ),
        ],
      ),
    );
  }
}

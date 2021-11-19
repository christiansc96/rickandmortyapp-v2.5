import 'package:devfestmexico/home/controllers/home-controller.dart';
import 'package:devfestmexico/home/models/character.dart';
import 'package:devfestmexico/home/screens/widgets/characters-card.dart';
import 'package:devfestmexico/utils/widgets/drawer.dart';
import 'package:flutter/material.dart';

class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rick & Morty APP"),
      ),
      drawer: DrawerApp(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: getCharacters(),
          ),
        ),
      ),
    );
  }

  FutureBuilder<List<CharacterDTO>> getCharacters() =>
      FutureBuilder<List<CharacterDTO>>(
          future: homecontroller.getCharacters(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container(
                height: 300,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            final List<CharacterDTO> characters = snapshot.data ?? [];
            final bool characterCounter = characters.isNotEmpty;
            if (characterCounter) {
              return _buildMyCharacters(characters);
            } else {
              return Container();
            }
          });

  Widget _buildMyCharacters(List<CharacterDTO> characters) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: characters.length,
        itemBuilder: (context, index) {
          return CharacterCard(character: characters[index]);
        });
  }
}

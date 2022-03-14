import 'package:flutter/material.dart';
import 'package:lista_veiculos/model/list_positions.dart';
import 'package:lista_veiculos/model/position.dart';
import 'package:lista_veiculos/service/endpoints.dart';
import 'package:lista_veiculos/widgets/list_item.dart';

class ListTrucks extends StatefulWidget {
  const ListTrucks({Key? key}) : super(key: key);

  @override
  _ListTrucksState createState() => _ListTrucksState();
}

class _ListTrucksState extends State<ListTrucks> {

  ListPositions? listPositions;

  @override
  void initState() {
    super.initState();
    getPositions().then((c) {
      setState(() {
        listPositions = c;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Veículos" ),
        actions: [
          IconButton (
            icon: const Icon(Icons.map),
            onPressed: () {
              Navigator. pushNamed(context, "/mapa", arguments: listPositions );
            },
          ),
        ],
      ),
      body: listPositions == null ?  //operador ternario
      const LinearProgressIndicator () :
      ListView.separated(
          itemBuilder: (context , index) => buildListItem( listPositions !.positions[index]),
          separatorBuilder: (context , index) => Divider(height: 1),
          itemCount: listPositions ?.positions == null ? 0 : listPositions !.positions.length
      ),
    );
  }

  Widget buildListItem(Position position){
    return ListItemVehicle(position);
  }
}

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ValueNotifier<int> selectedelement = ValueNotifier<int>(0);
  bool clicked = false;
  List<Map> food = [
    {'id': 1, 'name': 'fish'},
    {'id': 2, 'name': 'food'},
    {'id': 3, 'name': 'rice'},
  ];
  List<Map> foods = [
    {"text": 'rice1', "value": 3},
    {"text": 'rice2', "value": 3},
    {"text": 'rice3', "value": 3},
    {"text": 'fish1', "value": 1},
    {"text": 'fish2', "value": 1},
    {"text": 'fish3', "value": 1},
    {"text": 'food1', "value": 2},
    {"text": 'food2', "value": 2},
    {"text": 'food3', "value": 2},
  ];

  @override
  void dispose() {
    selectedelement.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          modalBottomSheetMenu();
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
      body: Container(),
    );
  }

  void modalBottomSheetMenu() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (builder) {
          return Container(
              height: 350.0,
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Wrap(
                      spacing: 10,
                      children: List<Widget>.generate(food.length, (index) {
                        int selectedElement = food.elementAt(index)['id'];
                        return FilterChip(
                            label: Text(food[index]['name'].toString()),
                            selectedColor: Colors.green,
                            checkmarkColor: Colors.white,
                            selected: clicked,
                            onSelected: (bool selected) {
                              if (selected) {
                                selectedelement.value = selectedElement;
                              }
                            });
                      }),
                    ),
                    const SizedBox(height: 10),
                    ValueListenableBuilder(
                      valueListenable: selectedelement,
                      builder:
                          (BuildContext context, int fooditem, Widget? child) {
                        return Wrap(
                          spacing: 10,
                          children: foods
                              .where((element) => element['value'] == fooditem)
                              .map((e) {
                            return FilterChip(
                                label: Text(e['text']),
                                onSelected: (bool selected) {});
                          }).toList(),
                        );
                      },
                    ),
                  ],
                ),
              ));
        });
  }
}

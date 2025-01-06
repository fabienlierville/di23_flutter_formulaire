import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //TextField
  String? textField;
  bool isObsure = true;
  //Checkbox
  Map<String,bool> listeCourse = {
    "Carottes": false,
    "Bananes": false,
    "Yaourt": false,
    "Pain": false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Les Formulaire")
      ),
      body: Column(
        children: [
          TextField(
            obscureText: isObsure,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Saisir votre Email",
              hintText: "test@test.com",
              suffixIcon: IconButton(
                  onPressed: (){
                    setState(() {
                      isObsure = !isObsure;
                    });
                  },
                  icon: (isObsure) ? Icon(Icons.visibility_off) : Icon(Icons.visibility)
              )
            ),
            onChanged: (String value){
              setState(() {
                textField = value;
              });
            },

          ),
          Divider(),
          Text("Valeur du TextField = ${textField}"),
          Container(
            child: Column(
              children: checkListeCourse(),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> checkListeCourse(){
    List<Widget> l = [];
    listeCourse.forEach((String aliments,bool achete){
      // [] Carottes
      Row row = Row(
        children: [
          Checkbox(
              value: achete,
              onChanged: (bool? b){
                setState(() {
                  listeCourse[aliments] = b!;
                });
              }
          ),
          Text(aliments,
            style: TextStyle(
            decoration: (achete) ? TextDecoration.lineThrough : TextDecoration.none
          ),
          )
        ],
      );
      l.add(row);
    });

    return l;
  }
}


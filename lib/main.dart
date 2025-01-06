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
  //Radio
  ChoixTransport choixTransport = ChoixTransport.Avion;
  Icon iconTransport = Icon(Icons.airplanemode_active);
  //Swtich
  bool interrupteur = false;
  //Slider
  double rayonKms = 0.0;
  //DatePicker
  DateTime? dateEvenement;

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
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Radio(
                  value: ChoixTransport.Avion,
                  groupValue: choixTransport,
                  onChanged: (ChoixTransport? c){
                    setState(() {
                      choixTransport = c!;
                      iconTransport = Icon(Icons.airplanemode_active);
                    });
                  }
              ),
              Text("Avion"),
              Radio(
                  value: ChoixTransport.Bateau,
                  groupValue: choixTransport,
                  onChanged: (ChoixTransport? c){
                    setState(() {
                      choixTransport = c!;
                      iconTransport = Icon(Icons.directions_boat);
                    });
                  }
              ),
              Text("Bateau"),
              Radio(
                  value: ChoixTransport.Voiture,
                  groupValue: choixTransport,
                  onChanged: (ChoixTransport? c){
                    setState(() {
                      choixTransport = c!;
                      iconTransport = Icon(Icons.directions_car);
                    });
                  }
              ),
              Text("Voiture"),
            ],
          ),
          iconTransport,
          Switch(
              value: interrupteur,
              inactiveTrackColor: Colors.red,
              activeColor: Colors.green,
              onChanged: (bool b){
                setState(() {
                  interrupteur = b;
                });
              }
          ),
          Text((interrupteur) ? "Pour" : "Contre"),
          Slider(
              value: rayonKms,
              min: 0,
              max: 100,
              divisions: 10,
              label: rayonKms.toString(),
              inactiveColor: Colors.black87,
              activeColor: Colors.pinkAccent,
              onChanged: (double d){
                setState(() {
                  rayonKms = d;
                });
              }
          ),
          Text("Rayon Kms = ${rayonKms}"),
          ElevatedButton(
              onPressed: _selectionDate, 
              child: Text("Ouvrir DatePicker")
          ),
          Text((dateEvenement == null)?"Aucune Date": "${dateEvenement?.day}/${dateEvenement?.month}/${dateEvenement?.year}")
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

  Future<void> _selectionDate() async{
    DateTime? _dateChoisie = await showDatePicker(
        context: context,
        firstDate: DateTime(1980),
        lastDate: DateTime(2045),
      initialDate: DateTime.now()
    );
    if(_dateChoisie != null){
      setState(() {
        dateEvenement = _dateChoisie;
      });
    }
  }

}

enum ChoixTransport{
  Voiture,
  Avion,
  Bateau
}


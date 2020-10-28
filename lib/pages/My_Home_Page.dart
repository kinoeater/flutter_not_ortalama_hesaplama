import 'package:flutter/material.dart';
import 'package:flutter_not_ortalama_hesaplama/model/ders.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String dersAdi;
  int dersKredi = 1;
  double dersHarfDegeri = 4;
  List<Ders> tumDersler;
  var formKey = GlobalKey<FormState>();
  double ortalama = 0;
  static int sayac = 0;

  @override
  void initState() {
    super.initState();
    tumDersler = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Ortalama Hesapla"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
          }
        },
        child: Icon(Icons.add),
      ),
      body: uygulamaGovdesiDikey(),
    );
  }

  Widget uygulamaGovdesiDikey() {
    // STATIK FORMU TUTAN CONTAINER
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            //   color: Colors.pink.shade200,
            child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Ders Adı",
                        hintText: "Ders adı Giriniz",
                        hintStyle: TextStyle(fontSize: 18),
                        labelStyle: TextStyle(fontSize: 22),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.purple.shade300)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.deepPurpleAccent)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value.length > 0) {
                          return null;
                        } else
                          return "Ders adını boş olamaz";
                      },
                      onSaved: (newValue) {
                        dersAdi = newValue;
                        setState(() {
                          tumDersler
                              .add(Ders(dersAdi, dersHarfDegeri, dersKredi));
                          ortalama = 0;
                          ortalamayiHesapla();
                        });
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.purple, width: 2),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<int>(
                              items: dersKredileriItems(),
                              value: dersKredi,
                              onChanged: (secilenKredi) {
                                setState(() {
                                  dersKredi = secilenKredi;
                                });
                              },
                            ),
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.purple, width: 2),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<double>(
                              items: dersHarfDegerleriItem(),
                              value: dersHarfDegeri,
                              onChanged: (secilenharf) {
                                setState(() {
                                  dersHarfDegeri = secilenharf;
                                });
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                )),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
            height: 70,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.purple, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(
                      text: tumDersler.length == 0
                          ? "Lutfen ders ekleyin!"
                          : "Ortalama: ",
                      style: TextStyle(color: Colors.black, fontSize: 25)),
                  TextSpan(
                      text: tumDersler.length == 0
                          ? ""
                          : "${ortalama.toStringAsFixed(2)}",
                      style: TextStyle(
                          color: Colors.purple,
                          fontSize: 25,
                          fontWeight: FontWeight.bold))
                ]),
              ),
            ),
          ),
          // DİNAMİK LİSTE
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              //    color: Colors.green.shade200,
              child: ListView.builder(
                itemBuilder: _listeElemanlariniOlustur,
                itemCount: tumDersler.length,
              ),
            ),
          )
        ],
      ),
    );
  }

  List<DropdownMenuItem<int>> dersKredileriItems() {
    List<DropdownMenuItem<int>> krediler = [];
    for (int i = 1; i <= 10; i++) {
      krediler.add(DropdownMenuItem<int>(
        value: i,
        child: Text(
          "$i Kredi",
          style: TextStyle(fontSize: 20),
        ),
      ));
    }
    return krediler;
  }

  List<DropdownMenuItem<double>> dersHarfDegerleriItem() {
    List<DropdownMenuItem<double>> harfler = [];
    harfler.add(DropdownMenuItem(
      child: Text(
        "AA",
        style: TextStyle(fontSize: 20),
      ),
      value: 4,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(
        "BA",
        style: TextStyle(fontSize: 20),
      ),
      value: 3.5,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(
        "BB",
        style: TextStyle(fontSize: 20),
      ),
      value: 3,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(
        "CB",
        style: TextStyle(fontSize: 20),
      ),
      value: 2.5,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(
        "CC",
        style: TextStyle(fontSize: 20),
      ),
      value: 2,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(
        "DC",
        style: TextStyle(fontSize: 20),
      ),
      value: 1.5,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(
        "DD",
        style: TextStyle(fontSize: 20),
      ),
      value: 1,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(
        "FF",
        style: TextStyle(fontSize: 20),
      ),
      value: 0,
    ));

    return harfler;
  }

  Widget _listeElemanlariniOlustur(BuildContext context, int index) {
    sayac++;
    return Dismissible(
      key: Key(sayac.toString()),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        setState(() {
          tumDersler.removeAt(index);
          ortalamayiHesapla();
        });
      },
      child: Card(
        margin: EdgeInsets.all(5),
        child: ListTile(
          leading: Icon(
            Icons.done,
            size: 30,
          ),
          trailing: Icon(
            Icons.keyboard_arrow_right_outlined,
            size: 20,
          ),
          title: Text(tumDersler[index].ad),
          subtitle: Text(tumDersler[index].kredi.toString() +
              " Kredi Not Değer: " +
              tumDersler[index].harfDegeri.toString()),
        ),
        elevation: 10,
      ),
    );
  }

  void ortalamayiHesapla() {
    double toplamNot = 0;
    double toplamKredi = 0;

    for (var oAnkiDers in tumDersler) {
      var kredi = oAnkiDers.kredi;
      var harfDegeri = oAnkiDers.harfDegeri;

      toplamNot += (harfDegeri * kredi);
      toplamKredi += kredi;
    }
    ortalama = toplamNot / toplamKredi;
  }
}

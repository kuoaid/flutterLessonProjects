import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BillSplitter extends StatefulWidget {
  const BillSplitter({Key? key}) : super(key: key);

  @override
  _BillSplitterState createState() => _BillSplitterState();
}

class _BillSplitterState extends State<BillSplitter> {
  @override
  int _tipPercentage = 0;
  int _personCounter = 1;
  double _billAmt = 0.0;
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          //do this to get the height of device:
          margin: EdgeInsets.only(top: (MediaQuery.of(context).size.height)*0.20 ),
          alignment: Alignment.center,
          color: Colors.white,
          child: ListView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.all(20.5),
            children: <Widget>[
              resultBox(),
              inputWindow()
            ]
          ),
        ),
      );
  }
  Container resultBox(){
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.purpleAccent.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Total per person:"),
            Text("\$ ${(calculateTotalPerPerson(calculateTotalTip(_billAmt, _personCounter, _tipPercentage), _billAmt, _personCounter)).toStringAsFixed(2)}")
          ],
        ),
      ),
    );
  }
  Container inputWindow(){
    return Container(
      width: 150,
      //height: 200,
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(width: 2.0, color: Colors.grey),
        borderRadius: BorderRadius.circular(12)
      ),
      child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children:[
            TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              style: TextStyle(
                color: Colors.grey
              ),
              decoration: (
                InputDecoration(
                  prefixText: "bill amt",
                  prefixIcon: Icon(Icons.attach_money)
                )
              ),
              onChanged: (String value) {setState(() {
                try{
                  _billAmt = double.parse(value);
                }catch(exception){
                  _billAmt = 0;
                }
                debugPrint("$_billAmt");
                }
              );
              },
            ),
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("split"),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        if(_personCounter>1){
                          _personCounter--;
                        }
                      });
                    },
                    child: Container(
                      width:40,
                      height: 40,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.purpleAccent,
                        borderRadius: BorderRadius.circular(4)
                      ),
                      child:
                      Center(
                          child: Text(
                          "-",
                          style: TextStyle(
                              color:Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)
                          )
                      ),
                    ),
                  ),
                  Text(
                      "$_personCounter"
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _personCounter++;
                      });
                    },
                    child: Container(
                      width:40,
                      height: 40,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.purpleAccent,
                          borderRadius: BorderRadius.circular(4)
                      ),
                      child:
                      Center(
                          child: Text(
                              "+",
                              style: TextStyle(
                                  color:Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)
                          )
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Tip"),
              Text("\$ ${calculateTotalTip(_billAmt, _personCounter , _tipPercentage)}"),
            ],
          ),
            Column(
              children: [
                Text("$_tipPercentage%"),
                Slider(
                    value: _tipPercentage.toDouble(),
                    max: 40,
                    min:0,
                    divisions: 8,
                    activeColor: Colors.red,
                    inactiveColor: Colors.grey,
                    onChanged: (double val){
                      setState(() {
                        _tipPercentage = val.round();
                      });
                }
                ),
              ],
            )

          ]
        )

    );
  }
  calculateTotalPerPerson(double totalTip, double billAmount, int splitBy){
    return (totalTip+billAmount)/splitBy;
  }
  double calculateTotalTip(double billAmount, int splitBy, int tipPercentage){
    double totalTip = 0.0;
    if(billAmount<0||billAmount.toString().isEmpty||billAmount==null){
    }else{
      totalTip = (billAmount*tipPercentage)/100;
    }
    return totalTip;
  }
}





class BusinessCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("business card"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            _getCard(),
            _getAvatar(),
          ]
        )
      ),
    );
  }
  //private stuff start with _
  Container _getCard() {
    return Container(
      width: 300,
      height: 200,
      margin: EdgeInsets.all(60),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(4.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Kuo Wang", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
          Text("952-297-2792"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.email),
              Text("kuowangshopping@gmail.com"),
            ],
          )
        ],
      )
    );
  }

  Container _getAvatar() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        border: Border.all(color: Colors.red, width: 1.2),
        image: DecorationImage(
            image: NetworkImage("https://picsum.photos/200/300"),
            fit:BoxFit.cover),
      ),
    );
  }
}

/*
Always use scaffold.
The left half gives you a visual cue of color/icons.

INKWELL
Touchable widget you can modify
 */

class ScaffoldEx extends StatelessWidget {
  @override
  void printstuff(int i){
    if(i==0){
      debugPrint("zero");
    }else if(i==1){
      debugPrint("one");
    }else{
      debugPrint('two');
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.redAccent.shade100,
        appBar: AppBar(
          title: Text("I am appbar"),
          centerTitle: true,
          backgroundColor: Colors.amberAccent.shade100,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.email), onPressed: () => debugPrint("this takes a function call")),
            IconButton(icon: Icon(Icons.ac_unit), onPressed: null),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(Icons.call_end, color:Colors.red),
          onPressed: ()=>{debugPrint("i am fab")},
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.account_balance), title: Text("1"),),
            BottomNavigationBarItem(icon: Icon(Icons.account_balance), title: Text("2")),
            BottomNavigationBarItem(icon: Icon(Icons.account_balance), title: Text("3"))
          ], onTap: (int index) => printstuff(index), //FUNCTION MUST RETURN FUNCTION. well, always make an anonymous function that passes stuff to your function.
        ),
        body: Container(
          alignment: Alignment.center,//this aligns container's child
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("column text"),
              CustomButton(),
              InkWell(//customized buttons
                child: Text(
                  "tap me here",
                  style: TextStyle(fontSize: 23.4),
                ),
                onTap: ()=>debugPrint("tapped"),
              )
            ]
          )
        )
    );
  }
//material knows how to make things look good
//ctrl+alt+shift+L makes format better

//Separating the code is preferred.
}
class CustomButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(//allows more gesture variations; more customizable
      onTap: () {//this is how to write a function on spot
        //show snackbar
        var snackBar = SnackBar(content: Text("hi"));
        //Context: how the tree is rendered, location of widgets in the tree. This part actually shows the stuff.
        Scaffold.of(context).showSnackBar(snackBar);
      },

      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.pink,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text("button"),
      ),
    );
  }
}

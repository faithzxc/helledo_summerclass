import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
 
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  // functions //

final TextEditingController num1 = TextEditingController();
final TextEditingController num2 = TextEditingController();
int total = 0;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    total = 15;
  }

void handleIncrement() {
  setState(() {
    total = total + 1;
  });
}

 // addition //

void handleAddition() {
  setState(() {
    total = int.parse(num1.text) + int.parse(num2.text);
  });
} 

void handleSubtraction() {
  setState(() {
    total = int.parse(num1.text) - int.parse(num2.text);
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold( body: Center(
      child: Column(
        children: [

          TextFormField(
            controller: num1,
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            controller: num2,
            keyboardType: TextInputType.number,
          ),
           ElevatedButton(
            onPressed:(){
              handleAddition();
            },
            child: Text('increment'),
          ),
          ElevatedButton(
            onPressed:(){
              handleAddition();
            },
            child: Text('addtwonumbers'),
          ),
          ElevatedButton(
            onPressed:(){
              handleSubtraction();
            },
            child: Text('subtracttwonumbers'),
          ),
          Text('Total: $total'),
        ],
      ),
    )
    );
   
  }
}
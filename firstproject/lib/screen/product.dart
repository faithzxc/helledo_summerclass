import 'package:flutter/material.dart';

void main() {
runApp(const MyApp());
}

class MyApp extends StatelessWidget {
const MyApp({super.key});

@override
Widget build(BuildContext context) {
return MaterialApp(
title: 'Product Calculator',
debugShowCheckedModeBanner: false,
theme: ThemeData(
colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
useMaterial3: true,
),
home: const ProductScreen(),
);
}
}

class ProductScreen extends StatefulWidget {
const ProductScreen({super.key});

@override
State<ProductScreen> createState() => ProductScreenState();
}

class ProductScreenState extends State<ProductScreen> {
// ── Product 1 ──
final TextEditingController price1Controller = TextEditingController();
final TextEditingController qty1Controller = TextEditingController();

// ── Product 2 ──
final TextEditingController price2Controller = TextEditingController();
final TextEditingController qty2Controller = TextEditingController();

// ── Product 3 ──
final TextEditingController price3Controller = TextEditingController();
final TextEditingController qty3Controller = TextEditingController();

String customerType = 'regular';

double subtotal = 0;
double discount = 0;
double total = 0;

// ────────────────────────────────────────
// TODO: initState (10 points)
// Set the default text of all 6 controllers to '0'
// HINT: Use super.initState() first, then set each controller's .text
// ────────────────────────────────────────

@override
void initState() {
super.initState();

price1Controller.text = '0';
qty1Controller.text = '0';

price2Controller.text = '0';
qty2Controller.text = '0';

price3Controller.text = '0';
qty3Controller.text = '0';
}

// ────────────────────────────────────────
// Calculate — if/else + switch + setState
// ───────────────────────────────────────

// ────────────────────────────────────────
// TODO: calculate() (40 points)
// 1. Parse the value of all 6 controllers into double (price) and int (qty)
// HINT: use double.tryParse() and int.tryParse()
// 2. Compute the subtotal: (price1 * qty1) + (price2 * qty2) + (price3 * qty3)
// 3. Use if / else to get the discount rate based on customerType
// - 'senior' = 30% (0.30)
// - 'pwd' = 40% (0.40)
// - else = 0
// 4. Compute: discount = subtotal * discountRate
// total = subtotal - discount
// 5. Call setState() and update subtotal, discount, and total
// ────────────────────────────────────────
void calculate() {
double price1 = double.tryParse(price1Controller.text) ?? 0;
int qty1 = int.tryParse(qty1Controller.text) ?? 0;
double price2 = double.tryParse(price2Controller.text) ?? 0;
int qty2 = int.tryParse(qty2Controller.text) ?? 0;
double price3 = double.tryParse(price3Controller.text) ?? 0;
int qty3 = int.tryParse(qty3Controller.text) ?? 0;

double computedSubtotal = (price1 * qty1) + (price2 * qty2) + (price3 * qty3);

double discountRate;
if (customerType == 'senior') {
discountRate = 0.30;
} else if (customerType == 'pwd') {
discountRate = 0.40;
} else {
discountRate = 0;
}

double computedDiscount = computedSubtotal * discountRate;
double computedTotal = computedSubtotal - computedDiscount;

setState(() {
subtotal = computedSubtotal;
discount = computedDiscount;
total = computedTotal;
});

}

// ────────────────────────────────────────
// TODO: getLabel() (20 points)
// Use a switch case on customerType to return a String label:
// 'senior' → 'Senior Citizen - 30% Discount'
// 'pwd' → 'PWD - 40% Discount'
// default → 'Regular - No Discount'
// ────────────────────────────────────────

String getLabel() {
switch (customerType) {
case 'senior':
return 'Senior Citizen - 30% Discount';
case 'pwd':
return 'PWD - 40% Discount';


default:
return 'Regular - No Discount';
}
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text('Product Calculator'),
backgroundColor: Colors.indigo,
foregroundColor: Colors.white,
),
body: SingleChildScrollView(
padding: const EdgeInsets.all(20),
child: Column(
crossAxisAlignment: CrossAxisAlignment.stretch,
children: [
// ── Product 1 ──
const Text(
'Product 1',
style: TextStyle(fontWeight: FontWeight.bold),
),
const SizedBox(height: 6),
Row(
children: [
Expanded(
child: TextField(
controller: price1Controller,
keyboardType: const TextInputType.numberWithOptions(
decimal: true,
),
decoration: const InputDecoration(
labelText: 'Price',
prefixText: '₱ ',
border: OutlineInputBorder(),
),
),
),
const SizedBox(width: 12),
Expanded(
child: TextField(
controller: qty1Controller,
keyboardType: TextInputType.number,
decoration: const InputDecoration(
labelText: 'Quantity',
border: OutlineInputBorder(),
),
),
),
],
),

const SizedBox(height: 16),

// ── Product 2 ──
const Text(
'Product 2',
style: TextStyle(fontWeight: FontWeight.bold),
),
const SizedBox(height: 6),
Row(
children: [
Expanded(
child: TextField(
controller: price2Controller,
keyboardType: const TextInputType.numberWithOptions(
decimal: true,
),
decoration: const InputDecoration(
labelText: 'Price',
prefixText: '₱ ',
border: OutlineInputBorder(),
),
),
),
const SizedBox(width: 12),
Expanded(
child: TextField(
controller: qty2Controller,
keyboardType: TextInputType.number,
decoration: const InputDecoration(
labelText: 'Quantity',
border: OutlineInputBorder(),
),
),
),
],
),

const SizedBox(height: 16),

// ── Product 3 ──
const Text(
'Product 3',
style: TextStyle(fontWeight: FontWeight.bold),
),
const SizedBox(height: 6),
Row(
children: [
Expanded(
child: TextField(
controller: price3Controller,
keyboardType: const TextInputType.numberWithOptions(
decimal: true,
),
decoration: const InputDecoration(
labelText: 'Price',
prefixText: '₱ ',
border: OutlineInputBorder(),
),
),
),
const SizedBox(width: 12),
Expanded(
child: TextField(
controller: qty3Controller,
keyboardType: TextInputType.number,
decoration: const InputDecoration(
labelText: 'Quantity',
border: OutlineInputBorder(),
),
),
),
],
),

const SizedBox(height: 24),
const Divider(),
const SizedBox(height: 8),

// ── Customer Type ──
const Text(
'Customer Type',
style: TextStyle(fontWeight: FontWeight.bold),
),
const SizedBox(height: 6),

RadioListTile(
title: const Text('Regular'),
value: 'regular',
groupValue: customerType,
onChanged: (value) {
setState(() {
customerType = value!;
});
},
),
RadioListTile(
title: const Text('Senior Citizen (30% off)'),
value: 'senior',
groupValue: customerType,
onChanged: (value) {
setState(() {
customerType = value!;
});
},
),
RadioListTile(
title: const Text('PWD (40% off)'),
value: 'pwd',
groupValue: customerType,
onChanged: (value) {
setState(() {
customerType = value!;
});
},
),

const SizedBox(height: 16),

// ── Calculate Button ──
ElevatedButton(
onPressed: calculate,
style: ElevatedButton.styleFrom(
backgroundColor: Colors.indigo,
foregroundColor: Colors.white,
padding: const EdgeInsets.symmetric(vertical: 14),
),
child: const Text('Calculate', style: TextStyle(fontSize: 16)),
),

const SizedBox(height: 24),
const Divider(),

// ── Result Display ──
Text(
'Customer: ${getLabel()}',
style: const TextStyle(color: Colors.indigo),
),
const SizedBox(height: 8),
Text('Subtotal : ₱${subtotal.toStringAsFixed(2)}'),
Text(
'Discount : ₱${discount.toStringAsFixed(2)}',
style: const TextStyle(color: Colors.red),
),
const SizedBox(height: 4),
Text(
'TOTAL : ₱${total.toStringAsFixed(2)}',
style: const TextStyle(
fontSize: 20,
fontWeight: FontWeight.bold,
color: Colors.indigo,
),
),
],
),
),
);
}
}
import 'package:flutter/material.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({Key? key}) : super(key: key);

  @override
  State createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        title: Text("فروشگاه", style: TextStyle(fontFamily: "Vazir", fontSize: 25),),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.map))
        ],
      ),
      body: Container(),
    );
  }
}

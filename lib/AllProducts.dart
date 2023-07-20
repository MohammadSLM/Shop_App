import 'package:flutter/material.dart';
import 'package:shop_app/BottomNav.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({Key? key}) : super(key: key);

  @override
  State createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){}, child: Icon(Icons.add),),
      bottomNavigationBar: BottomNav(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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

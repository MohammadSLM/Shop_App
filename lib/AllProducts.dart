import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:shop_app/BottomNav.dart';

import 'Model/SpecialOfferModel.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({Key? key}) : super(key: key);

  @override
  State createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {

  late Future<List<SpecialOfferModel>> specialOfferFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    specialOfferFuture = SendRequestSpecialOffer();
  }
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
      body: Container(
        child: FutureBuilder<List<SpecialOfferModel>>(
            future: specialOfferFuture,
            builder: (context , snapshot){
              if(snapshot.hasData){
                List<SpecialOfferModel>? models = snapshot.data;

                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: List.generate(models!.length, (index) => GenerateItem(models[index])),
                  ),
                );
              }else{
                return Container(
                  child: JumpingDotsProgressIndicator(
                    fontSize: 60,
                    dotSpacing: 5,
                  ),
                );
              }
            }
        ),
      ),
    );
  }
}

Future<List<SpecialOfferModel>> SendRequestSpecialOffer() async {
  List<SpecialOfferModel> model = [];

  var response =
  await Dio().get("http://mohammad.slm72.freehost.io/db2.json");

  print(response);

  for (var item in response.data['products']) {
    model.add(SpecialOfferModel(
        item['id'],
        item['product_name'],
        item['imgUrl'],
        item['price'],
        item['off_price'],
        item['off_percent']));
  }

  return model;
}

Card GenerateItem(SpecialOfferModel model){
  return Card(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))),
    elevation: 10,
    child: Center(
      child: Column(
        children: [
          Container(
            width: 90,
            height: 90,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Image.network(model.imgUrl),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(model.productName),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Text(model.price.toString()),
          ),
        ],
      ),
    ),
  );
}
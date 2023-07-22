import 'package:flutter/material.dart';
import 'package:shop_app/Model/SpecialOfferModel.dart';

class SingleProduct extends StatelessWidget {
  SpecialOfferModel specialOfferModel;

  SingleProduct(this.specialOfferModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        title: Text("Product", style: TextStyle(fontFamily: "Vazir", fontSize: 25),)
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Image.network(specialOfferModel.imgUrl, fit: BoxFit.fill, width: 300, height: 300,),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(specialOfferModel.productName, style: TextStyle(fontSize: 20),),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(specialOfferModel.price.toString(), style: TextStyle(fontSize: 20, color: Colors.red),),
              ),
              Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: MediaQuery.of(context).size.width-30,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                            onPressed: (){},
                            child: Text("Add To Cart"),
                        )),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

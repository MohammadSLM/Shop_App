import 'package:flutter/material.dart';
import 'package:shop_app/AllProducts.dart';
import 'package:shop_app/Model/EventModel.dart';
import 'package:shop_app/Model/PageViewModel.dart';
import 'package:dio/dio.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:shop_app/Model/SpecialOfferModel.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<PageViewModel>> pageViewFuture;
  late Future<List<SpecialOfferModel>> specialOfferFuture;
  late Future<List<EventModel>> eventFuture;
  PageController pageController = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    pageViewFuture = SendRequestPageView();
    specialOfferFuture = SendRequestSpecialOffer();
    eventFuture = SendRequestEvent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: Text('Shop'),
        backgroundColor: Colors.red,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                height: 250,
                child: FutureBuilder<List<PageViewModel>>(
                  future: pageViewFuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<PageViewModel>? model = snapshot.data;

                      return Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          PageView.builder(
                              controller: pageController,
                              allowImplicitScrolling: true,
                              itemCount: model?.length,
                              itemBuilder: (context, position) {
                                return PageViewItems(model![position]);
                              }),
                          Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: SmoothPageIndicator(
                                controller: pageController,
                                count: model!.length,
                                effect: ExpandingDotsEffect(
                                    dotWidth: 10,
                                    dotHeight: 10,
                                    spacing: 3,
                                    dotColor: Colors.white,
                                    activeDotColor: Colors.red),
                                onDotClicked: (index) =>
                                    pageController.animateToPage(index,
                                        duration: Duration(microseconds: 500),
                                        curve: Curves.bounceOut)),
                          ),
                        ],
                      );
                    } else {
                      return Center(
                        child: JumpingDotsProgressIndicator(
                          fontSize: 60,
                          dotSpacing: 5,
                        ),
                      );
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Container(
                  color: Colors.red,
                  height: 300,
                  child: FutureBuilder<List<SpecialOfferModel>>(
                    future: specialOfferFuture,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<SpecialOfferModel>? model = snapshot.data;

                        return ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: model!.length,
                          reverse: true,
                          itemBuilder: (context, position) {
                            if (position == 0) {
                              return Container(
                                height: 300,
                                width: 200,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, left: 10, right: 10),
                                      child: Image.asset(
                                        "images/box.png",
                                        height: 230,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Expanded(
                                        child: OutlinedButton(
                                            style: OutlinedButton.styleFrom(
                                                side: BorderSide(
                                                    color: Colors.white)),
                                            onPressed: () {
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => AllProducts()));
                                            },
                                            child: Text(
                                              "مشاهده همه",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            )),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            } else {
                              return SpecialOfferItem(model[position - 1]);
                            }
                          },
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ),
              Container(
                height: 500,
                width: double.infinity,
                child: FutureBuilder<List<EventModel>>(
                  future: eventFuture,
                  builder: (context , snapshot){
                    print(snapshot.hasData);
                    if(snapshot.hasData){
                      List<EventModel>? model = snapshot.data;

                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 150,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                      child: Image.network(model![0].imgUrl, fit: BoxFit.fill, width: 195,))
                                ),
                                Container(
                                    height: 150,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        child: Image.network(model![1].imgUrl, fit: BoxFit.fill, width: 195,))
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                    height: 150,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        child: Image.network(model![2].imgUrl, fit: BoxFit.fill, width: 195,))
                                ),
                                Container(
                                    height: 150,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        child: Image.network(model![3].imgUrl, fit: BoxFit.fill, width: 195,))
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    }else{
                      return Container(
                        child: JumpingDotsProgressIndicator(
                          fontSize: 60,
                          dotSpacing: 5,
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container SpecialOfferItem(SpecialOfferModel specialOfferModel) {
    return Container(
      width: 200,
      height: 300,
      color: Colors.white,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          width: 200,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  specialOfferModel.imgUrl,
                  height: 150,
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(specialOfferModel.productName),
              ),
              Expanded(
                  child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10, left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            specialOfferModel.offPrice.toString() + "T",
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            specialOfferModel.price.toString() + "T",
                            style: TextStyle(
                                fontSize: 15,
                                decoration: TextDecoration.lineThrough),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                          padding: const EdgeInsets.only(right: 10, bottom: 10),
                        child: Container(
                          decoration: new BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                                "${specialOfferModel.offPercent}%",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<List<EventModel>> SendRequestEvent() async {
    List<EventModel> models = [];

    var response = await Dio().get("http://mohammad.slm72.freehost.io/db.json");

    for(var item in response.data['photos']){
      models.add(EventModel(item['imgUrl']));
    }
    print(models);
    return models;
  }

  Future<List<PageViewModel>> SendRequestPageView() async {
    List<PageViewModel> model = [];

    var response = await Dio().get("http://mohammad.slm72.freehost.io/db.json");

    print(response);

    for (var item in response.data['photos']){
      model.add(PageViewModel(item['id'], item['imgUrl']));
    }

    return model;
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

  Padding PageViewItems(PageViewModel pageViewModel) {
    return Padding(
      padding: EdgeInsets.only(
        top: 10,
        right: 5,
        left: 5,
      ),
      child: Container(
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              pageViewModel.imgUrl,
              fit: BoxFit.fill,
            )),
      ),
    );
  }
}

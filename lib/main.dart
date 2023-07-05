import 'package:flutter/material.dart';
import 'package:shop_app/Model/PageViewModel.dart';
import 'package:dio/dio.dart';
import 'package:progress_indicators/progress_indicators.dart';
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
  PageController pageController = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    pageViewFuture = SendRequestPageView();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: Text('Shop'),
        backgroundColor: Colors.red,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.shopping_cart_outlined))
        ],
      ),
      body: Container(
        color: Colors.purple,
        child: Column(
          children: [
            Container(
              height: 250,
              child: FutureBuilder<List<PageViewModel>>(
                future: pageViewFuture,
                builder: (context , snapshot){
                  if(snapshot.hasData){
                    List<PageViewModel>? model = snapshot.data;

                    return Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        PageView.builder(
                          controller: pageController,
                          allowImplicitScrolling: true,
                          itemCount: model?.length,
                            itemBuilder: (context , position){
                            return PageViewItems(model![position]);
                            }
                        ),
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
                              activeDotColor: Colors.red
                            ),
                            onDotClicked: (index) =>
                                pageController.animateToPage(index,
                                    duration: Duration(microseconds: 500),
                                    curve: Curves.bounceOut)
                          ),
                        ),
                      ],
                    );
                  }else{
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
          ],
        ),
      ),
    );
  }

  Future<List<PageViewModel>> SendRequestPageView() async{
    List<PageViewModel> model = [];

    var response = await Dio().get("http://mohammad.slm72.freehost.io/db.json");
    
    print(response);

    for(var item in response.data['photos']){
      model.add(PageViewModel(item['id'], item['imgUrl']));
    }

    return model;
}

Padding PageViewItems(PageViewModel pageViewModel) {
    return Padding(
      padding: EdgeInsets.only(top: 10, right: 5, left: 5, ),
      child: Container(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
            child: Image.network(pageViewModel.imgUrl, fit: BoxFit.fill,)
        ),
      ),
    );
}
}

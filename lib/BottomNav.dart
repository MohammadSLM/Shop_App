import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 5,
      color: Colors.red,
      child: Container(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width/2 - 20,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(onPressed: (){}, icon: Icon(Icons.home, color: Colors.white, size: 35,)),
                  IconButton(onPressed: (){}, icon: Icon(Icons.person, color: Colors.white,size: 35,)),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width/2 - 20,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(onPressed: (){}, icon: Icon(Icons.search, color: Colors.white,size: 35,)),
                  IconButton(onPressed: (){}, icon: Icon(Icons.shopping_basket, color: Colors.white,size: 35,)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

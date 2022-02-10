import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miindfully/models/user_model.dart';
import 'package:miindfully/resources/database_helper.dart';
import 'package:miindfully/shop/order_summary.dart';
import 'package:miindfully/shop/product_details.dart';
import 'package:page_transition/page_transition.dart';

class ProductLists extends StatefulWidget {
  final userData;

  const ProductLists({Key? key, this.userData}) : super(key: key);

  @override
  _ProductListsState createState() => _ProductListsState();
}

class _ProductListsState extends State<ProductLists> {
  final DatabaseHelper dbHelper =
      DatabaseHelper(); //creating singleton instance

  int quantity = 0;

  List<dynamic> productList = [
    {
      "name":
          "Toyshine Push and Shake Wobbling Bell Sounds Roly Poly Tumbler Doll (Multicolour)",
      "image": "assets/images/product1.jpg",
      "price": 250,
      "desc": "Description about the product.",
      "rating": 4
    },
    {
      "name": "Yashi Talking Parrot",
      "image": "assets/images/product2.jpg",
      "price": 105,
      "desc": "Description about the product.",
      "rating": 3
    },
    {
      "name": "Product 3",
      "image": "assets/images/product1.jpg",
      "price": 345,
      "desc": "Description about the product.",
      "rating": 3.5
    },
    {
      "name": "Product 4",
      "image": "assets/images/product1.jpg",
      "price": 400,
      "desc": "Description about the product.",
      "rating": 2
    },
    {
      "name": "Product 5",
      "image": "assets/images/product1.jpg",
      "price": 500,
      "desc": "Description about the product.",
      "rating": 1
    },
    {
      "name": "Product 6",
      "image": "assets/images/product1.jpg",
      "price": 200,
      "desc": "Description about the product.",
      "rating": 4.3
    },
  ];

  @override
  void initState() {
    // TODO: implement initState
    cartQuantityCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              );
            },
          ),
          backgroundColor: Color(0xffFAD7A0),
          elevation: 1.0,
          title: Text(
            "Shop",
            style: TextStyle(
                // fontFamily: "FuturaHeavy",
                color: Colors.black),
          ),
          actions: [
            InkWell(
              onTap: () {
                if (quantity > 0)
                  Navigator.of(context).push(PageTransition(
                      curve: Curves.decelerate,
                      type: PageTransitionType.rightToLeft,
                      child:
                          OrderSummary(cartQuantityCount: cartQuantityCount)));
              },
              child: Container(
                alignment: Alignment.center,
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(right: 20, left: 10, top: 10),
                      child: new Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.black,
                        size: 25,
                      ),
                    ),
                    Visibility(
                      visible: quantity > 0 ? true : false,
                      child: Positioned(
                          right: 10,
                          top: 5,
                          child: Container(
                            padding: EdgeInsets.all(1),
                            decoration: new BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(8.5),
                            ),
                            constraints: BoxConstraints(
                              minWidth: 15,
                              minHeight: 15,
                            ),
                            child: AutoSizeText(
                              "$quantity",
                              minFontSize: 8,
                              maxFontSize: 12,
                              style: new TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          )),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        body: Container(
          color: Color(0xffFEF2EF),
          child: Column(
            children: [
              Expanded(
                child: Container(
                    child: Container(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: productList != null ? productList.length : 0,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return InkWell(
                          splashColor: Colors.blue,
                          onTap: () {
                            Navigator.of(context).push(PageTransition(
                                curve: Curves.decelerate,
                                type: PageTransitionType.rightToLeft,
                                child: ProductDetails(
                                    product: productList[index],
                                    cartQuantityCount: cartQuantityCount)));
                          },
                          child: Container(
                              child: Column(
                            children: [
                              Container(
                                  height:
                                      MediaQuery.of(context).size.height / 6,
                                  padding: EdgeInsets.only(
                                      left: 15, right: 15, top: 15, bottom: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Container(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              productList[index]["image"] == ""
                                                  ? Container(
                                                      child: CircleAvatar(
                                                        radius: 30,
                                                        backgroundColor:
                                                            Color(0xffFAD7A0),
                                                      ),
                                                    )
                                                  : Container(
                                                      child: CircleAvatar(
                                                        radius: 30,
                                                        backgroundImage: AssetImage(
                                                            "${productList[index]["image"]}"),
                                                      ),
                                                    ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Flexible(
                                                  child: Container(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(
                                                      child: AutoSizeText(
                                                        "${productList[index]["name"].toUpperCase()}",
                                                        maxLines: 2,
                                                        minFontSize: 18,
                                                        maxFontSize: 40,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          // // fontFamily: "Roboto",
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 5),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            child: AutoSizeText(
                                                              "Price : ",
                                                              maxLines: 1,
                                                              minFontSize: 18,
                                                              maxFontSize: 30,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontFamily:
                                                                    "Roboto",
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: AutoSizeText(
                                                              "${productList[index]["price"]}",
                                                              maxLines: 1,
                                                              minFontSize: 20,
                                                              maxFontSize: 40,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xffffcc8800),
                                                                  fontFamily:
                                                                      "Roboto",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 22),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Container(
                                        child: Icon(Icons.arrow_forward_ios,
                                            color: Colors.grey),
                                      )
                                    ],
                                  )),
                              Container(
                                color: Color(0XFF282828),
                                height: 1,
                              ),
                            ],
                          )),
                        );
                      }),
                )),
              )
            ],
          ),
        ));
  }

  cartQuantityCount() async {
    final result = await dbHelper.quantityCount();
    setState(() {
      quantity =
          result[0]["totalQuantity"] == null ? 0 : result[0]["totalQuantity"];
    });
  } //func

}

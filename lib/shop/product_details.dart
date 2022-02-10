import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:miindfully/resources/database_helper.dart';
import 'package:miindfully/shop/order_summary.dart';
import 'package:page_transition/page_transition.dart';

class ProductDetails extends StatefulWidget {
  final Map<String, dynamic>? product;
  final Function()? cartQuantityCount;
  const ProductDetails({Key? key, this.product, this.cartQuantityCount})
      : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final DatabaseHelper dbHelper =
      DatabaseHelper(); //creating singleton instance

  bool added = false;

  int quantity = 0;

  Future<bool> onBack() async {
    widget.cartQuantityCount!();
    Navigator.of(context, rootNavigator: true).pop();

    return true;
  }

  @override
  void initState() {
    // TODO: implement initState
    cartQuantityCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBack,
      child: Scaffold(
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
                  onBack();
                },
              );
            },
          ),
          backgroundColor: Color(0xffFAD7A0),
          elevation: 1.0,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: MediaQuery.of(context).size.height / 4,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "${widget.product!["image"]}"))),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5, bottom: 5),
                        child: AutoSizeText(
                          "${widget.product!["name"].toUpperCase()}",
                          maxLines: 3,
                          minFontSize: 18,
                          maxFontSize: 40,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black,
                              // fontFamily: "Roboto",
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 2, bottom: 5),
                        child: AutoSizeText(
                          "${widget.product!["desc"]}",
                          minFontSize: 14,
                          maxFontSize: 39,
                          style: TextStyle(
                              color: Colors.black54,
                              // fontFamily: "Roboto",
                              fontSize: 17),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 2, bottom: 5),
                        child: RatingBar.builder(
                          initialRating: (widget.product!["rating"]).toDouble(),
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          ignoreGestures: true,
                          itemSize: MediaQuery.of(context).size.width / 18,
                          itemCount: 5,
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          onRatingUpdate: (double value) {},
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Row(
                          children: [
                            Container(
                              child: AutoSizeText(
                                "Price : ",
                                maxLines: 1,
                                minFontSize: 18,
                                maxFontSize: 30,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.black,
                                  // fontFamily: "Roboto",
                                ),
                              ),
                            ),
                            Container(
                              child: AutoSizeText(
                                "Rs ${widget.product!["price"]}",
                                maxLines: 1,
                                minFontSize: 20,
                                maxFontSize: 40,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Color(0xffffcc8800),
                                    // fontFamily: "Roboto",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 12,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.3),
                      blurRadius: 4.0, // soften the shadow
                      offset: Offset(
                        0.0, // Move to right 10  horizontally
                        -1.0, // Move to bottom 10 Vertically
                      ),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          if (!added) {
                            setState(() {
                              added = true;
                            });
                            _insert(widget.product);
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          color: Colors.white,
                          child: AutoSizeText(
                              "${added ? "GO TO CART" : "ADD TO CART"}",
                              maxLines: 1,
                              minFontSize: 18,
                              maxFontSize: 25,
                              style: TextStyle(
                                  // fontFamily: "Roboto",
                                  )),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if (quantity > 0)
                            Navigator.of(context).push(PageTransition(
                                curve: Curves.decelerate,
                                type: PageTransitionType.rightToLeft,
                                child: OrderSummary(
                                    cartQuantityCount: cartQuantityCount)));
                        },
                        child: Container(
                          color: Color(0xffFAD7A0),
                          alignment: Alignment.center,
                          child: AutoSizeText("SHOP NOW",
                              maxLines: 1,
                              minFontSize: 18,
                              maxFontSize: 25,
                              style: TextStyle(
                                color: Colors.black,
                                // fontFamily: "Roboto",
                              )),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _insert(Map<String, dynamic>? productDetails) async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnProductName: '${productDetails!["name"]}',
      DatabaseHelper.columnDescription: '${productDetails["desc"]}',
      DatabaseHelper.columnImage: '${productDetails["image"]}',
      DatabaseHelper.columnPrice: productDetails["price"],
      DatabaseHelper.columnTotalPrice: productDetails["price"],
      DatabaseHelper.columnQuantity: 1,
      DatabaseHelper.columnRating: productDetails["rating"],
    };

    final id = await dbHelper.insertProduct(row);
    setState(() {
      quantity = quantity + 1;
    });
    print('inserted row id: $id');
  }

  cartQuantityCount() async {
    final result = await dbHelper.quantityCount();
    setState(() {
      quantity =
          result[0]["totalQuantity"] == null ? 0 : result[0]["totalQuantity"];
    });
  } //func

}

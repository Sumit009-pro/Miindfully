import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:miindfully/shop/cart_item_lists.dart';
import 'package:miindfully/shop/price_details.dart';

class OrderSummary extends StatefulWidget {
  final Function()? cartQuantityCount;
  const OrderSummary({Key? key, this.cartQuantityCount}) : super(key: key);

  @override
  _OrderSummaryState createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  int totalPrice = 0;
  int totalQuantity = 0;
  int discount = 400;
  int deliveryCharges = 100;
  int finalAmount = 0;

  Future<bool> onBack() async {
    widget.cartQuantityCount!();
    Navigator.of(context, rootNavigator: true).pop();

    return await true;
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
          title: Text(
            "Order Summary",
            style: TextStyle(
                // fontFamily: "FuturaHeavy",
                color: Colors.black),
          ),
        ),
        body: Container(
          //   color: Color(0xffFEF2EF),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Container(
                        child: CartItemLists(
                            setPriceAndQuantity: setPriceAndQuantity),
                      ),
                      Container(
                        child: PriceDetails(
                          totalPrice: totalPrice,
                          totalQuantity: totalQuantity,
                          deliveryCharges: deliveryCharges,
                          discount: discount,
                          finalAmount: finalAmount,
                        ),
                      ),
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
                      child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.only(top: 3, bottom: 3),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: AutoSizeText("Total Price",
                                    maxLines: 1,
                                    minFontSize: 15,
                                    maxFontSize: 25,
                                    style: TextStyle(
                                        // fontFamily: "Roboto",
                                        fontWeight: FontWeight.bold)),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: AutoSizeText("Rs $finalAmount",
                                    maxLines: 1,
                                    minFontSize: 14,
                                    maxFontSize: 22,
                                    style: TextStyle(// fontFamily: "Roboto",
                                        )),
                              ),
                            ],
                          )),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          /* Navigator.of(context).push(PageTransition(curve: Curves.decelerate,type: PageTransitionType.rightToLeft,
                              child:OrderSummary()) );*/
                        },
                        child: Container(
                          color: Color(0xffFAD7A0),
                          alignment: Alignment.center,
                          child: AutoSizeText("Place Order",
                              maxLines: 1,
                              minFontSize: 18,
                              maxFontSize: 25,
                              style: TextStyle(
                                  color:
                                      Colors.black // , // fontFamily: "Roboto",
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

  void setPriceAndQuantity(int quantity, int price) {
    setState(() {
      totalPrice = price;
      totalQuantity = quantity;
      finalAmount = (totalPrice + deliveryCharges) - discount;
    });
    if (totalQuantity == 0) onBack();
  }
}

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriceDetails extends StatefulWidget {
  final int totalPrice;
  final int totalQuantity;
  final int discount;
  final int deliveryCharges;
  final int finalAmount;
  const PriceDetails(
      {Key? key,
      required this.totalPrice,
      required this.totalQuantity,
      required this.discount,
      required this.deliveryCharges,
      required this.finalAmount})
      : super(key: key);

  @override
  _PriceDetailsState createState() => _PriceDetailsState();
}

class _PriceDetailsState extends State<PriceDetails> {
  int totalAmount = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    totalAmount =
        (widget.deliveryCharges + widget.totalPrice) - widget.discount;
    print("ttttt..$totalAmount");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 15, left: 15, right: 15),
            child: AutoSizeText("PRICE DETAILS",
                maxLines: 1,
                minFontSize: 15,
                maxFontSize: 25,
                style: TextStyle(
                    // fontFamily: "Roboto",fontSize: 18,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold)),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Container(
                    child: AutoSizeText(
                        "${widget.totalQuantity == 1 ? "Price (1 item)" : "Price (${widget.totalQuantity} items)"}",
                        minFontSize: 13,
                        maxFontSize: 25,
                        style: TextStyle(
                          // fontFamily: "Roboto",
                          fontSize: 16,
                        )),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  child: AutoSizeText("Rs ${widget.totalPrice}",
                      maxLines: 1,
                      minFontSize: 13,
                      maxFontSize: 25,
                      style: TextStyle(
                        // fontFamily: "Roboto",
                        fontSize: 16,
                      )),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15, left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Container(
                    child: AutoSizeText("Discount",
                        minFontSize: 13,
                        maxFontSize: 25,
                        style: TextStyle(
                          // fontFamily: "Roboto",
                          fontSize: 16,
                        )),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  child: AutoSizeText("- Rs ${widget.discount}",
                      maxLines: 1,
                      minFontSize: 13,
                      maxFontSize: 25,
                      style: TextStyle(
                          // fontFamily: "Roboto",
                          fontSize: 16,
                          color: Colors.green)),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Container(
                    child: AutoSizeText("Delivery Charges",
                        minFontSize: 13,
                        maxFontSize: 25,
                        style: TextStyle(
                          // fontFamily: "Roboto",
                          fontSize: 16,
                        )),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  child: AutoSizeText("Rs ${widget.deliveryCharges}",
                      maxLines: 1,
                      minFontSize: 13,
                      maxFontSize: 25,
                      style: TextStyle(
                          // fontFamily: "Roboto",
                          fontSize: 16,
                          color: Colors.green)),
                ),
              ],
            ),
          ),
          Divider(),
          Container(
            margin: EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Container(
                    child: AutoSizeText("Total Amount",
                        minFontSize: 13,
                        maxFontSize: 25,
                        style: TextStyle(
                            // fontFamily: "Roboto",
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  child: AutoSizeText("Rs ${widget.finalAmount}",
                      maxLines: 1,
                      minFontSize: 13,
                      maxFontSize: 25,
                      style: TextStyle(
                          // fontFamily: "Roboto",
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          Divider(),
          Container(
            margin: EdgeInsets.only(
              top: 10,
              left: 15,
              right: 15,
            ),
            child: AutoSizeText(
                "You will save Rs ${widget.discount} on this order",
                minFontSize: 13,
                maxFontSize: 25,
                style: TextStyle(
                    // fontFamily: "Roboto",
                    fontSize: 18,
                    color: Colors.green)),
          ),
        ],
      ),
    );
  }
}

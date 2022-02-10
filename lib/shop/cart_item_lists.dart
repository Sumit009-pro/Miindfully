import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miindfully/resources/database_helper.dart';

class CartItemLists extends StatefulWidget {
  final Function(int, int)? setPriceAndQuantity;
  const CartItemLists({Key? key, this.setPriceAndQuantity}) : super(key: key);

  @override
  _CartItemListsState createState() => _CartItemListsState();
}

class _CartItemListsState extends State<CartItemLists> {
  int quantity = 1;

  List<Map<String, dynamic>> itemList = [];

  final DatabaseHelper dbHelper =
      DatabaseHelper(); //creating singleton instance

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchItemList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount:
                itemList != null && itemList.length > 0 ? itemList.length : 0,
            itemBuilder: (context, index) {
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 15, right: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: AutoSizeText(
                                        "${itemList[index]["productName"]}",
                                        maxLines: 1,
                                        minFontSize: 20,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          // // fontFamily: "Roboto",
                                          fontSize: 25,
                                        )),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 5, bottom: 5),
                                    child: AutoSizeText(
                                        "${itemList[index]["description"]}",
                                        maxLines: 1,
                                        minFontSize: 10,
                                        maxFontSize: 20,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            // // fontFamily: "Roboto",
                                            fontSize: 14,
                                            color: Colors.grey)),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 3, right: 3, top: 3, bottom: 3),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      color: Colors.green,
                                    ),
                                    child: AutoSizeText(
                                        " ${itemList[index]["rating"]} \u2605 ",
                                        maxLines: 1,
                                        minFontSize: 10,
                                        maxFontSize: 20,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            // // fontFamily: "Roboto",
                                            fontSize: 14,
                                            color: Colors.white)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 3,
                            height: MediaQuery.of(context).size.height / 10,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "${itemList[index]["image"]}"))),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: 20, left: 15, right: 15, bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              child: AutoSizeText(
                                  "Rs ${itemList[index]["totalPrice"]}",
                                  maxLines: 1,
                                  minFontSize: 18,
                                  maxFontSize: 25,
                                  style: TextStyle(
                                      color: Color(0XFF707070),
                                      // // fontFamily: "Roboto",
                                      fontWeight: FontWeight.bold))),
                          Container(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (itemList[index]["quantity"] > 1)
                                        removeQuantityAndPrice(
                                            index,
                                            itemList[index]["id"],
                                            itemList[index]["quantity"],
                                            itemList[index]["price"] *
                                                (itemList[index]["quantity"] -
                                                    1));
                                      else
                                        deleteProduct(
                                            itemList[index]["id"], index);
                                    });
                                  },
                                  child: Container(
                                    child: Icon(
                                      Icons.remove_circle,
                                      color: Color(0xffffcc8800),
                                      size: 30,
                                    ),
                                  ),
                                ),
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width / 15,
                                    alignment: Alignment.center,
                                    margin:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: AutoSizeText(
                                        "${itemList[index]["quantity"]}",
                                        maxLines: 1,
                                        minFontSize: 18,
                                        maxFontSize: 25,
                                        style: TextStyle(
                                            color: Color(0XFF707070),
                                            // // fontFamily: "Roboto",
                                            fontWeight: FontWeight.w600))),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      addQuantityAndPrice(
                                          index,
                                          itemList[index]["id"],
                                          itemList[index]["quantity"],
                                          itemList[index]["price"] *
                                              (itemList[index]["quantity"] +
                                                  1));
                                    });
                                  },
                                  child: Container(
                                    child: Icon(
                                      Icons.add_circle,
                                      color: Color(0xffffcc8800),
                                      size: 30,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    index + 1 != itemList.length
                        ? Divider(
                            thickness: 1,
                          )
                        : Divider(
                            thickness: 10,
                            color: Colors.grey[200],
                          ),
                  ],
                ),
              );
            }));
  }

  void fetchItemList() async {
    final dataResult = await dbHelper.fetchAllProductData();
    print('fetched data: $dataResult');
    final result = await dbHelper.fetchPriceAndQuantity();
    print('fetchPriceAndQuantity data: $result');

    setState(() {
      itemList = dataResult;
      widget.setPriceAndQuantity!(
          result[0]["totalQuantity"] == null ? 0 : result[0]["totalQuantity"],
          result[0]["totalPrice"] == null ? 0 : result[0]["totalPrice"]);
    });
  }

  void addQuantityAndPrice(
    int index,
    int id,
    int quantity,
    int price,
  ) async {
    final result =
        await dbHelper.updateQuantityAndPrice(id, quantity + 1, price);
    print('updated $result row(s)');
    itemList.clear();
    fetchItemList();
  }

  void removeQuantityAndPrice(
    int index,
    int id,
    int quantity,
    int price,
  ) async {
    final result =
        await dbHelper.updateQuantityAndPrice(id, quantity - 1, price);
    print('updated $result row(s)');
    itemList.clear();
    fetchItemList();
  }

  void deleteProduct(int id, int index) async {
    final dataResult = await dbHelper.deleteProduct(id);
    print('fetched data: $dataResult');
    itemList.clear();
    fetchItemList();
  }
}

import 'package:flutter/material.dart';

class ProductBlock extends StatelessWidget {
  ProductBlock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(productImages);
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        child: InkWell(
          // onTap: () => Navigator.pushNamed(context, ProductDetails.routeName,
          //     arguments: productsAttributes.id),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              children: [
                Column(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(2),
                          child: Container(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * .6,
                              child: Image.network(
                                  "https://miro.medium.com/max/700/1*BgE_7vv3n9T0-IVf0BwWyg.jpeg",
                                  fit: BoxFit.fill)),
                        ),
                        Positioned(
                          top: 10,
                          left: 0,
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInBack,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20))),
                            padding: EdgeInsets.all(12),
                            child: Text(
                              "Brand",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20))),
                            padding: EdgeInsets.all(12),
                            child: Text(
                              "Status",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(left: 8, top: 😎,
                  margin: EdgeInsets.only(left: 5, bottom: 2, right: 3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Product Name",
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 22.0, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Price",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.purple,
                                fontSize: 18),
                          ),
                          // Spacer(flex: 1,),
                          Material(
                            color: Colors.transparent,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                              child: Text(
                                "Model No"
                              )
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
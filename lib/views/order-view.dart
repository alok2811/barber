import 'package:barber/controller/order-controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class OrderView extends StatelessWidget {
  final controller= Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Orders'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Colors.white)
              ),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hair Cut', style: Theme.of(context).textTheme.headline1,),
                      Divider(),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Date', style: Theme.of(context).textTheme.bodyText1,),
                          Text('27 oct 2021 ', style: Theme.of(context).textTheme.subtitle2,),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Time', style: Theme.of(context).textTheme.bodyText1,),
                          Text('08:00 AM', style: Theme.of(context).textTheme.subtitle2,),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Barber Shop', style: Theme.of(context).textTheme.bodyText1,),
                          Text("The Classic Cut",
                            style: Theme.of(context).textTheme.bodyText1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.justify,
                            maxLines: 1,),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Status', style: Theme.of(context).textTheme.bodyText1,),
                          Text('Pending', style: Theme.of(context).textTheme.bodyText1,),
                        ],
                      ),

                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Created at', style: Theme.of(context).textTheme.subtitle1,),
                          Text('25 oct 2021 11:07 AM ', style: Theme.of(context).textTheme.subtitle1,),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Expired at', style: Theme.of(context).textTheme.subtitle1,),
                          Text('27 oct 2021 08:30 AM ', style: Theme.of(context).textTheme.subtitle1,),
                        ],
                      ),


                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:barber/controller/main-controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MainView extends StatelessWidget {
  final controller= Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          physics:  const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 250,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
                      image: AssetImage('assets/images/main-bg.jpg'),
                      fit: BoxFit.cover
                  ),
                ),
                child: Center(
                  child: Container(
                      padding: EdgeInsets.all(8),
                      child: TextField(
                          onChanged: (val){},
                          style: Theme.of(context).textTheme.bodyText1,
                          decoration: InputDecoration(
                              suffixIcon: Icon(Icons.search),
                              hintText: 'Search something ...',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                              contentPadding: EdgeInsets.zero
                          )
                      )
                  ),
                ),
              ),
              FutureBuilder(
                future: controller.getAllData(),
                  builder:(BuildContext context, AsyncSnapshot snapshot){
                  if(snapshot.hasData){
                    List list =snapshot.data;
                    print(list);
                    return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        reverse: true,
                        itemCount: list.length,
                        itemBuilder: (context, index){
                      return Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: 80 , width: 80,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(15)),
                                              image: DecorationImage(
                                                  image: NetworkImage(list[index]['image']),
                                                  fit: BoxFit.fill
                                              )
                                          ),
                                        ),
                                        SizedBox(width: 10,),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(list[index]['name'],
                                                style: Theme.of(context).textTheme.headline1,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.justify,
                                                maxLines: 1,),
                                              SizedBox(height: 5,),
                                              Text(list[index]['address'],
                                                style: Theme.of(context).textTheme.bodyText2,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.justify,
                                                maxLines: 1,),
                                              SizedBox(height: 5,),
                                              Text(list[index]['time'],
                                                style: Theme.of(context).textTheme.bodyText2,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.justify,
                                                maxLines: 1,),
                                              SizedBox(height: 5,),
                                              RatingBar(
                                                initialRating: double.parse(list[index]['star']),
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemSize: 15,
                                                itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                                                onRatingUpdate: (double value) {},
                                                ratingWidget: RatingWidget(
                                                  full: Icon(Icons.star, color: Theme.of(context).primaryColor,),
                                                  empty: Icon(Icons.star, color: Colors.grey,),
                                                  half: Icon(Icons.star, color: Colors.grey,),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                ElevatedButton(onPressed: (){}, child: Text('View')),
                              ],
                            ),
                          ),
                          Divider(
                            color: Theme.of(context).primaryColor.withOpacity(0.7),
                          ),
                        ],
                      );
                    });
                  }
                    return Center(child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CircularProgressIndicator(),
                    ),);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
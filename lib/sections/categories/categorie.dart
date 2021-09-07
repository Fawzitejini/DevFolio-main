import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folio/menu/bloc/bloc/items_bloc.dart';
import 'package:folio/menu/bloc/events/items_events.dart';
import 'package:folio/menu/bloc/repository/firebase_stock_model.dart';
import 'package:folio/menu/bloc/states/items_states.dart';
import 'package:folio/menu/constants/data_converter.dart';
import 'package:folio/menu/constants/own_colors.dart';

import '../../constants.dart';

class Categorie extends StatefulWidget {
  const Categorie({Key key}) : super(key: key);

  @override
  _CategorieState createState() => _CategorieState();
}

class _CategorieState extends State<Categorie> {
  ItemsBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<ItemsBloc>(context);
    bloc.add(FetchData());
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemsBloc, ItemsStates>(builder: (_, state) {
      if (state is ItemsLoadingState) {
        return Center(child: CircularProgressIndicator());
      }
      if (state is ItemsLoadedState) {
        return Container(
          child: GridView.builder(
              itemCount: state.categorie.length,
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1),
              itemBuilder: (_, i) {
                FCategories _categorie = state.categorie[i];
                return 
                Padding(
                  padding: const EdgeInsets.only(right:10),
                  child: OpenContainer(
                      closedColor: BrandColors.xboxGrey,
                      openColor: BrandColors.xboxGrey,
                      closedShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      closedBuilder: (_, void Function() action) {
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Text(_categorie.categoriesName),
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Image.memory(
                                    DataConverter.image(
                                        _categorie.categoriesImage),
                                    width: 40,
                                    height: 40),
                              ),
                            ],
                          ),
                        );
                      },
                      openBuilder: (_, void Function() action) {
                        return Container(color: BrandColors.darkgray,
                            child: OpenContainer(
                          closedColor: BrandColors.xboxGrey,
                          openColor: BrandColors.darkgray,
                          closedShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          closedBuilder: (_, void Function() action) {
                            var listOfItems = state.catalogue.where((element) =>
                                _categorie.categoriesName ==
                                element.productCategories.categoriesName);

                            return Container(color:BrandColors.black,
                              child: CustomScrollView(
                                slivers:[ 
                                  SliverAppBar(title: Text(_categorie.categoriesName),),
                                SliverGrid(
                                  delegate:
                                      SliverChildBuilderDelegate((context, index) {
                                    var P = listOfItems.toList()[index];
                              
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 10, right: 10),
                                      child: OpenContainer(
                                          closedColor: BrandColors.xboxGrey,
                                          openColor: BrandColors.darkgray,
                                          closedShape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          closedBuilder:
                                              (context, void Function() action) {
                                            if (DateTime.now()
                                                    .difference(P.datePublier)
                                                    .inDays >
                                                20) {
                                              return Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  P.productImage == null
                                                      ? SizedBox(
                                                          height: 120,
                                                          child: Text("No image"),
                                                          width: 120,
                                                        )
                                                      : Image.memory(
                                                          DataConverter.image(
                                                              P.productImage),
                                                          height: 120,
                                                          width: 120,
                                                        ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(10),
                                                    child: Text(
                                                      P.productName,
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  P.isSales == true
                                                      ? Padding(
                                                          padding:
                                                              const EdgeInsets.only(
                                                                  bottom: 20),
                                                          child: Row(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left: 10,
                                                                        right: 10),
                                                                child: Text(
                                                                  DataConverter
                                                                      .currencyConvert(
                                                                          P.productUnitPrice),
                                                                  style: const TextStyle(
                                                                      fontSize: 12,
                                                                      decoration:
                                                                          TextDecoration
                                                                              .lineThrough,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                              Text(
                                                                  DataConverter
                                                                      .currencyConvert(P
                                                                          .productSalesPrice),
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white))
                                                            ],
                                                          ),
                                                        )
                                                      : Padding(
                                                          padding:
                                                              const EdgeInsets.only(
                                                                  bottom: 20,
                                                                  left: 10),
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                  child: Text(
                                                                DataConverter
                                                                    .currencyConvert(
                                                                        P.productUnitPrice),
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .white),
                                                              ))
                                                            ],
                                                          ),
                                                        )
                                                ],
                                              );
                                            } else {
                                              return Banner(
                                                  message: "Nouveau",
                                                  location: BannerLocation.topStart,
                                                  child: Column(
                                                    children: [
                                                      Expanded(
                                                          child: P.productImage ==
                                                                  null
                                                              ? SizedBox(
                                                                  height: 120,
                                                                  child: Text(
                                                                      "No image"),
                                                                  width: 120,
                                                                )
                                                              : Image.memory(
                                                                  DataConverter.image(
                                                                      P.productImage),
                                                                  height: 120,
                                                                  width: 120)),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets.all(
                                                                10),
                                                        child: Text(P.productName,
                                                            style: const TextStyle(
                                                                color:
                                                                    Colors.white)),
                                                      ),
                                                      P.isSales == true
                                                          ? Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      bottom: 20),
                                                              child: Row(
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                                .only(
                                                                            left:
                                                                                10,
                                                                            right:
                                                                                10),
                                                                    child: Text(
                                                                      DataConverter
                                                                          .currencyConvert(
                                                                              P.productUnitPrice),
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          decoration:
                                                                              TextDecoration
                                                                                  .lineThrough,
                                                                          color:
                                                                              kPrimaryColor),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                      DataConverter
                                                                          .currencyConvert(P
                                                                              .productSalesPrice),
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          color: Colors
                                                                              .white))
                                                                ],
                                                              ),
                                                            )
                                                          : Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 10,
                                                                      bottom: 10),
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                    child: Text(
                                                                      DataConverter
                                                                          .currencyConvert(
                                                                              P.productUnitPrice),
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          color: Colors
                                                                              .white),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            )
                                                    ],
                                                  ));
                                            }
                                          },
                                          openBuilder:
                                              (context, void Function() action) {
                                            return CustomScrollView(slivers: [
                                              SliverAppBar(
                                                backgroundColor:
                                                    BrandColors.darkgray,
                                                leading: IconButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    icon: const Icon(Icons.close)),
                                              ),
                                              SliverToBoxAdapter(
                                                  child: SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2,
                                                child: P.productImage == null
                                                    ? SizedBox(
                                                        height: 120,
                                                        child: Text("No image"),
                                                        width: 120,
                                                      )
                                                    : Image.memory(
                                                        DataConverter.image(
                                                            P.productImage)),
                                              )),
                                              SliverToBoxAdapter(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(10),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                          child: Text(
                                                        P.productName,
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            color: Colors.white),
                                                      )),
                                                      Padding(
                                                          padding:
                                                              const EdgeInsets.only(
                                                                  right: 20),
                                                          child: P
                                                                        .isSales ==
                                                                    false ?
                                                          
                                                          Text(
                                                            DataConverter.currencyConvert(
                                                                P.productUnitPrice
                                                                ),
                                                            style: TextStyle(
                                                                fontSize: 25,
                                                                color:
                                                                    kPrimaryColor),
                                                          ):
                                                          Wrap(alignment: WrapAlignment.center,
                                                            
                                                            direction: Axis.horizontal,
                                                          children: 
                                                          [
                                                            Padding(
                                                              padding: const EdgeInsets.only(right: 10),
                                                              child: Container(height:30,
                                                                color:BrandColors.googleOrange , width: 50,
                                                                child:
                                                              Center(
                                                                child: Text("-" +
                                                                  
                                                                  (((P.productUnitPrice-P.productSalesPrice )/P.productUnitPrice  * 100).toStringAsFixed(0)+'%')
                                                                  ,style: TextStyle(
                                                                    fontSize: 17,
                                                                    color:
                                                                        Colors.white)
                                                                  ),
                                                              )

                                                              ),
                                                            ),Text(
                                                            DataConverter.currencyConvert(
                                                                P.productSalesPrice
                                                                ),
                                                            style: TextStyle(
                                                                fontSize: 25,
                                                                color:
                                                                    kPrimaryColor),
                                                          )

                                                          ],
                                                          )
                                                          )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SliverToBoxAdapter(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(10),
                                                  child: Text(
                                                    "Description : ",
                                                    style: TextStyle(
                                                        color: kPrimaryColor),
                                                  ),
                                                ),
                                              ),
                                              SliverToBoxAdapter(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(10),
                                                  child: Text(
                                                    P.productDiscreption,
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              )
                                            ]);
                                          }),
                                    );
                                  }, childCount: listOfItems.length),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2),
                                ),
                           ] ),
                            );

                            ;
                          },
                          openBuilder: (_, void Function() action) {
                            return Container(
                              child: Text("In open"),
                            );
                          },
                        ));
                      }),
                );
              }),
        );
      }
      if (state is ItemsFailedLoadState) {
        return Center(child: Text(state.errorMessage));
      }
      return Center(child: Text("data"));
    });
  }
}
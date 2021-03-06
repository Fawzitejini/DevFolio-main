import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folio/menu/bloc/bloc/items_bloc.dart';
import 'package:folio/menu/bloc/events/items_events.dart';
import 'package:folio/menu/bloc/repository/bloc_stock_reposetery.dart';
import 'package:folio/menu/bloc/states/items_states.dart';
import 'package:folio/menu/constants/data_converter.dart';
import 'package:folio/menu/constants/own_colors.dart';

class BlocMainPage extends StatefulWidget {
  const BlocMainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<BlocMainPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ItemsBloc(
              ItemsInitState(),
              NoneAsyncBlocStockReposetery(),
            ),
        child: const Scaffold(body: HomePage()));
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    return BlocBuilder<ItemsBloc, ItemsStates>(builder: (context, state) {
      if (state is ItemsLoadingState) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else if (state is ItemsLoadedState) {
        return CustomScrollView(
          slivers: [
             SliverAppBar(
              backgroundColor: BrandColors.darkgray,
              title: const Text("Notre catalogue"),
            ),
            SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                var P = state.catalogue[index];
                return Padding(
                  padding: const EdgeInsets.only(left:10, top: 10, right: 10),
                  child: OpenContainer(
                      closedColor: BrandColors.xboxGrey,
                      openColor: BrandColors.xboxGrey,
                      closedShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      closedBuilder: (context, void Function() action) {
                        if (DateTime.now().difference(P.datePublier).inDays >
                            20) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.memory(
                                DataConverter.image(P.productImage),
                                height: 120,
                                width: 120,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  P.productName,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              P.isSales == true
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child:     Text(
                                                  DataConverter
                                                      .currencyConvert(
                                                          P.productUnitPrice),
                                                  style: const TextStyle(fontSize: 12,
                                                      decoration:
                                                          TextDecoration
                                                              .lineThrough,
                                                      color: Colors.white),
                                                )
                                              ,
                                          ),
                                          Text(
                                              DataConverter.currencyConvert(
                                                  P.productSalesPrice),
                                              style: const TextStyle(
                                                  color: Colors.white))
                                        ],
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 20, left: 10),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: Text(
                                            DataConverter.currencyConvert(
                                                P.productUnitPrice),
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.white),
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
                                      child: Image.memory(
                                          DataConverter.image(P.productImage),
                                          height: 120,
                                          width: 120)),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(P.productName,
                                        style: const TextStyle(
                                            color: Colors.white)),
                                  ),
                                  P.isSales == true
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 20),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: Text(
                                                  DataConverter
                                                      .currencyConvert(
                                                          P.productUnitPrice),
                                                  style: TextStyle(fontSize: 12,
                                                      decoration:
                                                          TextDecoration
                                                              .lineThrough,
                                                      color: BrandColors
                                                          .googleOrange),
                                                ),
                                              ),
                                              Text(
                                                  DataConverter.currencyConvert(
                                                      P.productSalesPrice),
                                                  style: const TextStyle(fontSize: 12,
                                                      color: Colors.white))
                                            ],
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, bottom: 10),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  DataConverter.currencyConvert(
                                                      P.productUnitPrice),
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                ],
                              ));
                        }
                      },
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                      openBuilder: (context, void Function() action) {
                        return CustomScrollView(slivers: [
                          SliverAppBar(backgroundColor: BrandColors.darkgray,
                           leading:   IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.close)),
                          ),
                          SliverToBoxAdapter(child:
                          SizedBox(width: MediaQuery.of(context).size.width/2,
                          height:MediaQuery.of(context).size.width/2,
                          child: Image.memory(DataConverter.image(P.productImage)),
                          )
                          ) ,
                           SliverToBoxAdapter(child: 
                          Padding(
                            padding:const EdgeInsets.all(10),
                            child: Row(children: [
                              Expanded(child: Text( P.productName,style: const TextStyle(fontSize: 15,color: Colors.white),)),
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Text(DataConverter.currencyConvert(P.isSales==true?P.productSalesPrice:P.productUnitPrice)
                                ,style:  TextStyle(fontSize:12,color:BrandColors.googleOrange ),
                              ))
                            ],
                              
                            ),
                          ),),
                          SliverToBoxAdapter(child: 
                          Padding(
                            padding:const EdgeInsets.all(10),
                            child: Text("Description : ",style: TextStyle(color: BrandColors.googleOrange),),
                          ),), SliverToBoxAdapter(child: 
                          Padding(
                            padding:const EdgeInsets.all(10),
                            child: Text(P.productDiscreption,style: const TextStyle(color: Colors.white),),
                          ),)
                          
                          
                           ]);
                      }),
















                );
              }, childCount: state.catalogue.length),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
            ),
          ],
        );
      } else if (state is ItemsFailedLoadState) {
        return Center(
          child: Text(state.errorMessage),
        );
      } else {
        return const Center(
          child: Text("Redirect"),
        );
      }
    });
  }
}

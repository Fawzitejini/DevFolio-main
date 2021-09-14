import 'package:animations/animations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:folio/menu/bloc/bloc/items_bloc.dart';
import 'package:folio/menu/bloc/events/items_events.dart';
import 'package:folio/menu/bloc/repository/firebase_reposetory.dart';
import 'package:folio/menu/bloc/repository/firebase_stock_model.dart';
import 'package:folio/menu/bloc/states/items_states.dart';
import 'package:folio/menu/constants/data_converter.dart';
import 'package:folio/menu/constants/own_colors.dart';
import 'package:folio/menu/ui_states/avis/avis.dart';
import 'package:folio/public_data.dart';
import 'package:folio/sections/categories/categorie.dart';
import 'package:folio/users/facebook_users.dart';
import 'package:folio/users/google_users.dart';

import 'package:responsive_builder/responsive_builder.dart';

import '../../../constants.dart';

class MenuPage extends StatefulWidget {
  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
        mobile: BlocMainPage(), desktop: BlockManPageDesktop());
  }
}

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
              FReposetery(),
            ),
        child: const Scaffold(body: HomePage()));
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

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
        return Container(
          color: BrandColors.black,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                  leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('index');
                    },
                    icon: Icon(Icons.keyboard_return_sharp),
                  ),
                  actions: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed("newitem")
                              .then((value) => setState(() {}));
                        },
                        icon: Icon(
                          Icons.add,
                          size: 30,
                        ))
                  ],
                  pinned: true,
                  expandedHeight: 200,
                  backgroundColor: BrandColors.black,
                  flexibleSpace: FlexibleSpaceBar(
                      title: Text("Catalogue"),
                      background:
                          Image.asset("assets/banner.jpg", fit: BoxFit.fill))),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: kPrimaryColor),
                          borderRadius: BorderRadius.circular(25)),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Text("Categories"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: SizedBox(
                                height: 100,
                                child: Categorie(),
                              ),
                            ),
                          ])),
                ),
              ),
              SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) {
                  var P = state.catalogue[index];

                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 10, top: 10, right: 10),
                    child: OpenContainer(
                        closedColor: BrandColors.xboxGrey,
                        openColor: BrandColors.darkgray,
                        closedShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        closedBuilder: (context, void Function() action) {
                          if (DateTime.now().difference(P.datePublier).inDays >
                              20) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                P.productImage == null
                                    ? SizedBox(
                                        height: 120,
                                        child: Text("No image"),
                                        width: 120,
                                      )
                                    : Image.memory(
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
                                              child: Text(
                                                DataConverter.currencyConvert(
                                                    P.productUnitPrice),
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    color: Colors.white),
                                              ),
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
                                        child: P.productImage == null
                                            ? SizedBox(
                                                height: 120,
                                                child: Text("No image"),
                                                width: 120,
                                              )
                                            : Image.memory(
                                                DataConverter.image(
                                                    P.productImage),
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
                                            padding: const EdgeInsets.only(
                                                bottom: 20),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, right: 10),
                                                  child: Text(
                                                    DataConverter
                                                        .currencyConvert(
                                                            P.productUnitPrice),
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        color: kPrimaryColor),
                                                  ),
                                                ),
                                                Text(
                                                    DataConverter
                                                        .currencyConvert(P
                                                            .productSalesPrice),
                                                    style: const TextStyle(
                                                        fontSize: 12,
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
                                                    DataConverter
                                                        .currencyConvert(
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
                          globalStock = P;
                          double countItemRating = 0;
                          double itemRating = 0;
                          bool isDone = false;
                          var m = P.avis.where((element) =>
                              element.user.id == facebookUserLogin.id);
                          if (m.length > 0) {
                            m.forEach((element) {
                              countItemRating += element.rate;
                            });
                            itemRating = countItemRating / m.length;
                            isDone = true;
                          } else {
                            isDone = false;
                          }
                          return CustomScrollView(slivers: [
                            SliverAppBar(
                              backgroundColor: BrandColors.darkgray,
                              leading: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.close)),
                            ),
                            SliverToBoxAdapter(
                                child: SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              height: MediaQuery.of(context).size.width / 2,
                              child: P.productImage == null
                                  ? SizedBox(
                                      height: 120,
                                      child: Text("No image"),
                                      width: 120,
                                    )
                                  : Image.memory(
                                      DataConverter.image(P.productImage)),
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
                                          fontSize: 15, color: Colors.white),
                                    )),
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 20),
                                            child: P.isSales == false
                                                ? Text(
                                                    DataConverter
                                                        .currencyConvert(
                                                            P.productUnitPrice),
                                                    style: TextStyle(
                                                        fontSize: 25,
                                                        color: kPrimaryColor),
                                                  )
                                                : Wrap(
                                                    alignment:
                                                        WrapAlignment.center,
                                                    direction: Axis.horizontal,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 10),
                                                        child: Container(
                                                            height: 30,
                                                            color: BrandColors
                                                                .googleOrange,
                                                            width: 50,
                                                            child: Center(
                                                              child: Text(
                                                                  "-" +
                                                                      (((P.productUnitPrice - P.productSalesPrice) / P.productUnitPrice * 100).toStringAsFixed(
                                                                              0) +
                                                                          '%'),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          17,
                                                                      color: Colors
                                                                          .white)),
                                                            )),
                                                      ),
                                                      Text(
                                                        DataConverter
                                                            .currencyConvert(P
                                                                .productSalesPrice),
                                                        style: TextStyle(
                                                            fontSize: 25,
                                                            color:
                                                                kPrimaryColor),
                                                      )
                                                    ],
                                                  )))
                                  ],
                                ),
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  "Description : ",
                                  style: TextStyle(color: kPrimaryColor),
                                ),
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  P.productDiscreption,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: ExpansionTile(
                                title: Text("Avis de notre client"),
                                subtitle: facebookUserLogin.id == null
                                    ? Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: SizedBox(
                                            height: 40,
                                            child: Row(children: [
                                              Expanded(
                                                child: Text(facebookUserLogin
                                                            .fullName !=
                                                        null
                                                    ? facebookUserLogin.fullName
                                                    : "Pour publier to avis veuillez inscrivez vous\npar votre compte google ou facebook"),
                                                flex: 2,
                                              ),
                                              VerticalDivider(),
                                              IconButton(
                                                icon: Icon(
                                                    Icons.add_comment_outlined),
                                                onPressed: () {
                                                    currentavis = FAvis();
                                                        
                                                        ratingComment.text =
                                                          null;
                                                        ratingController =
                                                            null;
                                                  avisEditing = false;
                                                  Navigator.of(context)
                                                      .pushReplacementNamed(
                                                          "newavis")
                                                      .then((value) =>
                                                          setState(() {}));
                                                },
                                              )
                                            ])),
                                      )
                                    : Row(children: [
                                        Expanded(
                                            child: Text(
                                                facebookUserLogin.fullName)),
                                        VerticalDivider(),
                                        isDone == false
                                            ? IconButton(
                                                icon: Icon(
                                                    Icons.add_comment_outlined),
                                                onPressed: () {
                                                currentavis = FAvis();
                                                        
                                                        ratingComment.text =
                                                          null;
                                                        ratingController =
                                                            null;
                                                  Navigator.of(context)
                                                      .pushReplacementNamed(
                                                          "newavis")
                                                      .then((value) =>
                                                          setState(() {}));
                                                },
                                              )
                                            : Container()
                                      ]),
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height,
                                    child: ListView.builder(
                                        itemCount: P.avis.length,
                                        itemBuilder: (_, ii) {
                                          var _avis = P.avis[ii];
                                          print(_avis.user.fullName);

                                          if (facebookUserLogin.id != null) {
                                            if (_avis.user.id ==
                                                facebookUserLogin.id) {
                                              return Column(children: [
                                                ListTile(
                                                  title: Text(_avis
                                                              .user.fullName ==
                                                          null
                                                      ? "null"
                                                      : _avis.user.fullName),
                                                  trailing: IconButton(
                                                      onPressed: () {
                                                         currentavis = _avis;
                                                        avisEditing = true;
                                                        ratingComment.text =
                                                            _avis.comment;
                                                        ratingController =
                                                            _avis.rate;
                                                        Navigator.of(context)
                                                            .pushReplacementNamed(
                                                                "newavis")
                                                            .then((value) =>
                                                                setState(
                                                                    () {}));
                                                      },
                                                      icon: Icon(Icons.edit)),
                                                  subtitle: Text(_avis.comment),
                                                  leading: Wrap(children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3),
                                                      child: Icon(Icons.star,
                                                          size: 15),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3),
                                                      child: Text(DataConverter
                                                          .numberConvert(
                                                              itemRating)),
                                                    )
                                                  ]),
                                                ),
                                                Divider(height: 20)
                                              ]);
                                            }
                                          }
                                         
                                          return Column(children: [
                                            ListTile(
                                              title: Text(
                                                  _avis.user.fullName == null
                                                      ? "Null"
                                                      : _avis.user.fullName),
                                              subtitle: Text(_avis.comment),
                                              leading: Wrap(children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(3),
                                                  child: Icon(Icons.star,
                                                      size: 15),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(3),
                                                  child: Text(
                                                      _avis.rate.toString()),
                                                )
                                              ]),
                                            ),
                                            Divider(height: 20)
                                          ]);
                                        }),
                                  )
                                ],
                              ),
                            ),
                            /**   SliverToBoxAdapter(child:),
                        SliverList(delegate:SliverChildBuilderDelegate((context, index) => null))*/
                          ]);
                        }),
                  );
                }, childCount: state.catalogue.length),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
              ),
            ],
          ),
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

class BlockManPageDesktop extends StatefulWidget {
  const BlockManPageDesktop({Key key}) : super(key: key);

  @override
  _BlockManPageDesktopState createState() => _BlockManPageDesktopState();
}

class _BlockManPageDesktopState extends State<BlockManPageDesktop> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ItemsBloc(
              ItemsInitState(),
              FReposetery(),
            ),
        child: const Scaffold(body: HomePageDesktop()));
  }
}

class HomePageDesktop extends StatefulWidget {
  const HomePageDesktop({Key key}) : super(key: key);

  @override
  _HomePageDesktopState createState() => _HomePageDesktopState();
}

class _HomePageDesktopState extends State<HomePageDesktop> {
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
        return Scaffold(
          appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "index");
                  },
                  icon: Icon(Icons.keyboard_return_outlined))),
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else if (state is ItemsLoadedState) {
        return Container(
          color: BrandColors.black,
          child: CustomScrollView(
            slivers: [
              /*    SliverAppBar(
                  actions: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed("newitem");
                        },
                        icon: Icon(
                          Icons.add,
                          size: 30,
                        ))
                  ],
                  pinned: true,
                  expandedHeight: 200,
                  backgroundColor: BrandColors.black,
                  flexibleSpace: FlexibleSpaceBar(
                      title: Text("Tous les produits"),
                      background:
                          Image.asset("assets/banner.jpg", fit: BoxFit.fill)),
                 ),
           */

              SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) {
                  var P = state.catalogue[index];
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 10, top: 10, right: 10),
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
                                              child: Text(
                                                DataConverter.currencyConvert(
                                                    P.productUnitPrice),
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    color: Colors.white),
                                              ),
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
                                            padding: const EdgeInsets.only(
                                                bottom: 20),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, right: 10),
                                                  child: Text(
                                                    DataConverter
                                                        .currencyConvert(
                                                            P.productUnitPrice),
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        color: kPrimaryColor),
                                                  ),
                                                ),
                                                Text(
                                                    DataConverter
                                                        .currencyConvert(P
                                                            .productSalesPrice),
                                                    style: const TextStyle(
                                                        fontSize: 12,
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
                                                    DataConverter
                                                        .currencyConvert(
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
                            SliverAppBar(
                              backgroundColor: BrandColors.darkgray,
                              leading: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.close)),
                            ),
                            SliverToBoxAdapter(
                                child: SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              height: MediaQuery.of(context).size.width / 2,
                              child: Image.memory(
                                  DataConverter.image(P.productImage)),
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
                                          fontSize: 15, color: Colors.white),
                                    )),
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: Text(
                                          DataConverter.currencyConvert(
                                              P.isSales == true
                                                  ? P.productSalesPrice
                                                  : P.productUnitPrice),
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: kPrimaryColor),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  "Description : ",
                                  style: TextStyle(color: kPrimaryColor),
                                ),
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  P.productDiscreption,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          ]);
                        }),
                  );
                }, childCount: state.catalogue.length),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
              ),
            ],
          ),
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

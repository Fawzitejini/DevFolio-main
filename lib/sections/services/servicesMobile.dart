import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folio/menu/bloc/bloc/items_bloc.dart';
import 'package:folio/menu/bloc/events/items_events.dart';
import 'package:folio/menu/bloc/states/items_states.dart';
import 'package:folio/widget/serviceCard.dart';
import 'package:google_fonts/google_fonts.dart';

/*
class ServiceMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return 
    Container(
      child:
       Column(
        children: [
          Text(
            "\Notre Nouveauté",
            style: GoogleFonts.montserrat(
              fontSize: height * 0.06,
              fontWeight: FontWeight.w100,
              letterSpacing: 1.0,
            ),
          ),
          Text(
            "I may not be perfect, but I'm surely of some help :)\n\n",
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(fontWeight: FontWeight.w200),
          ),
          CarouselSlider.builder(
            itemCount: 5,
            itemBuilder: (BuildContext context, int itemIndex, int i) =>
                Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: ServiceCard(
                cardWidth: width < 650 ? width * 0.8 : width * 0.5,
                serviceIcon: kServicesIcons[i],
                serviceTitle: kServicesTitles[i],
                serviceDescription: kServicesDescriptions[i],
                serviceLink: kServicesLinks[i],
              ),
            ),
            options: CarouselOptions(
                height: height * 0.45,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 5),
                enlargeCenterPage: true,
                autoPlayCurve: Curves.fastOutSlowIn,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                enableInfiniteScroll: false),
          )
        ],
      ),
    );
  }
}

*/

class ServiceMobiles extends StatefulWidget {
  const ServiceMobiles({Key key}) : super(key: key);

  @override
  _ServiceMobilesState createState() => _ServiceMobilesState();
}

class _ServiceMobilesState extends State<ServiceMobiles> {
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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder<ItemsBloc, ItemsStates>(builder: (context, state) {
      if (state is ItemsLoadingState) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is ItemsLoadedState) {
        if (state.newItems.length < 1) {
          return Container(child: Column(children:
           [

              Text(
                  "\Notre Nouveauté",
                  style: GoogleFonts.montserrat(
                    fontSize: height * 0.06,
                    fontWeight: FontWeight.w100,
                    letterSpacing: 1.0,
                  ),
                ),
                Text(
                  "Je ne suis peut-être pas parfait, mais je suis sûrement d'une certaine aide :)\n\n",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w200),
                ),SizedBox(height:180,width: 250,
                child:Card(child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: 
                [
                 Icon(Icons.emoji_emotions_rounded,size: 80,)
                ],),) )

           ],),
              );
        } else {
          return Container(
            child: Column(
              children: [
                Text(
                  "\Notre Nouveauté",
                  style: GoogleFonts.montserrat(
                    fontSize: height * 0.06,
                    fontWeight: FontWeight.w100,
                    letterSpacing: 1.0,
                  ),
                ),
                Text(
                  "Je ne suis peut-être pas parfait, mais je suis sûrement d'une certaine aide :)\n\n",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w200),
                ),
                CarouselSlider.builder(
                  itemCount: state.newItems.length,
                  itemBuilder: (BuildContext context, int itemIndex, int i) =>
                      Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: ServiceCard(
                      cardWidth: width < 650 ? width * 0.8 : width * 0.5,
                      serviceIcon: state.newItems[i].productImage,
                      serviceTitle: state.newItems[i].productName,
                      serviceDescription: state.newItems[i].productDiscreption,
                      serviceLink: state.newItems[i].productName,
                    ),
                  ),
                  options: CarouselOptions(
                      height: height * 0.45,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 5),
                      enlargeCenterPage: true,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      enableInfiniteScroll: false),
                )
              ],
            ),
          );
        }
      } else {
        return Center(
          child: Container(),
        );
      }
    });
  }
}

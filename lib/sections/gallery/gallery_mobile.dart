import 'package:animated_background/animated_background.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folio/menu/bloc/bloc/items_bloc.dart';
import 'package:folio/menu/bloc/bloc/repository/firebase_reposetory.dart';
import 'package:folio/menu/bloc/events/items_events.dart';
import 'package:folio/menu/bloc/repository/firebase_reposetory.dart';
import 'package:folio/nou_used/bloc_stock_reposetery.dart';
import 'package:folio/menu/bloc/states/items_states.dart';
import 'package:folio/widget/projectCard.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../constants.dart';

class GalleryBloc extends StatefulWidget {
  const GalleryBloc({Key key}) : super(key: key);
  @override 
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<GalleryBloc> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ItemsBloc(ItemsInitState(), FReposetery()),
      child: MyGallery(),
    );
  }
}

class MyGallery extends StatefulWidget {
  const MyGallery({Key key}) : super(key: key);

  @override
  _MyGalleryState createState() => _MyGalleryState();
}

class _MyGalleryState extends State<MyGallery> {
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
        return Center(child: CircularProgressIndicator());
      } else if (state is ItemsLoadedState) {
        double height = MediaQuery.of(context).size.height;
        double width = MediaQuery.of(context).size.width;
        Departement departement = Departement(branche: [   Branche(name:"Caffe" , image:"https://media-cdn.tripadvisor.com/media/photo-s/18/06/3e/ac/ambiance-vintage-dans.jpg" , 
   description: "est simplement du faux texte employé dans la composition et la mise en page avant impression. Le Lorem Ipsum est le faux texte standard de l'imprimerie depuis les années 1500, quand un imprimeur anonyme assembla ensemble des morceaux de texte pour réaliser un livre spécimen de polices de texte",
     ),
   Branche(name: "Restaurant", image:"https://media-cdn.tripadvisor.com/media/photo-s/1c/12/4c/9a/le-beret-c-est-un-endroit.jpg" ,
    description:  "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
    ),
   Branche(name: "patisserie", image: "https://static.wixstatic.com/media/0e0a8d_8bf2f65236ae47dc831d99c8e51cae79~mv2.jpg/v1/fill/w_691,h_445,al_c,lg_1,q_80/0e0a8d_8bf2f65236ae47dc831d99c8e51cae79~mv2.webp", description:
      "er rett og slett dummytekst fra og for trykkeindustrien. Lorem Ipsum har vært bransjens standard for dummytekst helt siden 1500-tallet, da en ukjent boktrykker stokket en mengde bokstaver for å lage et prøveeksemplar av en bok. Lorem Ipsum har tålt tidens tann usedvanlig godt")
  ]);
        return Container(
          child: Column(
            children: [
              Text(
                "\nDecouvrir notre services",
                style: GoogleFonts.montserrat(
                  fontSize: height * 0.06,
                  fontWeight: FontWeight.w100,
                  letterSpacing: 1.0,
                ),
              ),
              Text(
                "Here are few samples of my previous work :)\n\n",
                style: GoogleFonts.montserrat(fontWeight: FontWeight.w200),
                textAlign: TextAlign.center,
              ),
              CarouselSlider.builder(
                itemCount: departement.branche.length,
                itemBuilder: (BuildContext context, int itemIndex, int i) =>
                    Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: ProjectCard(
                    cardWidth: width < 650 ? width * 0.8 : width * 0.4,
                       projectIcon: departement.branche[i].image,
                    projectTitle: departement.branche[i].name,
                    projectDescription: departement.branche[i].description,
                  ),
                ),
                options: CarouselOptions(
                    height: height * 0.5,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 5),
                    enlargeCenterPage: true,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    enableInfiniteScroll: false),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              MaterialButton(
                hoverColor: kPrimaryColor.withAlpha(150),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: BorderSide(color: kPrimaryColor)),
                onPressed: () {
                  launchURL("");
                },
                child: Text(
                  "Decouvrire",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
            ],
          ),
        );
      } else {
        return Center(
          child: Text("Essalam"),
        );
      }
    });
  }
}

 












class Departement {
  List<Branche> branche;
  Departement({@required this.branche});
}

class Branche {
  String name;
  String image;
  String description;
  Branche(
      {@required this.name, @required this.image, @required this.description});
}

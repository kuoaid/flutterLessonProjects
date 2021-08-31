import 'package:first_flutter_app/model/movie.dart';
import 'package:first_flutter_app/ui/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MovieListView extends StatelessWidget {

  final List movies = [
    "Titanic",
    "Blade Runner",
    "Rambo",
    "The Avengers",
    "Avatar",
    "I Am Legend",
    "300",
    "The Wolf of Wall Street",
    "Interstellar",
    "Game of Thrones",
    "Vikings"
  ];

  final List<Movie> movieList = Movie.getMovies();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
        title: Text("Movies"),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder:
          (BuildContext context, int index) {
          return Stack(
              children:[
                Positioned(
                  child: movieCard(movieList[index], context),
                ),
                Positioned(
                  top: 10,
                  child: movieImage(movieList[index].images[0]),
                ),
              ]
          );

            // return Card(
            //   elevation: 2,
            //   color:Colors.white,
            //   child: ListTile(
            //     leading: CircleAvatar(
            //       backgroundColor: Colors.blue,
            //       child: Container(
            //         decoration: BoxDecoration(
            //           // color: Colors.transparent,
            //           image: DecorationImage(
            //             image: NetworkImage(
            //               movieList[index].images[0]
            //             ),
            //             fit: BoxFit.cover,
            //           ),
            //           borderRadius: BorderRadius.circular(10),
            //         ),
            //       )
            //     ),
            //     trailing: Text("..."),
            //     title: Text(movieList[index].title),
            //     subtitle: Text(movieList[index].genre),
            //     onTap: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context)=>MovieListViewt(
            //                 movieName: movieList[index].title,
            //                 movie: movieList[index]
            //               )
            //           )
            //       );
            //     },
            //   ),
            // );
          }
      ),
    );
  }
  TextStyle greySubText(){
    return(
        TextStyle(
        fontSize: 15,
        color: Colors.grey.shade400,
      )
    );
  }
  Widget movieImage(String imageUrl){
    return Container(
      width:100,
      height:100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(imageUrl ?? "https://picsum.photos/200/300"),
          fit: BoxFit.cover
        )
      ),
    );
  }
  Widget movieCard(Movie movie, BuildContext context){
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(
          left: 60
        ),
        width: MediaQuery.of(context).size.width,
        height: 120.0,
        child: Card(
          color: Colors.black45,
          child: Padding(
            padding: const EdgeInsets.only(
              top:8.0,
              bottom: 8.0,
              left: 50,
              right: 15,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(movie.title, style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Colors.white
                        ),),
                      ),
                      Text(
                        "Rating: ${movie.imdbRating}/10",
                        style: greySubText(),

                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        child: Text("Released: ${movie.released}",
                          style: greySubText(),),
                      ),
                      Text(movie.runtime,
                        style: greySubText(),),
                      Text(movie.rated,
                        style: greySubText(),)
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context)=>MovieListViewDetails(
                      movieName: movie.title,
                      movie: movie
                    )
                )
            );
          },
    );
  }

}

class MovieListViewDetails extends StatelessWidget {

  final String movieName;
  final Movie movie;
  const MovieListViewDetails({Key? key, required this.movieName, required this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
        title: Text("Movie Details"),
        backgroundColor: Colors.black45,
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          MovieDetailsThumbnail(thumbnail: movie.images[0]),
          MovieDetailsHeaderWithPoster(movie: movie),
          MovieDetailsCast(movie: movie),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            child: HorizontalLine(),
          ),
          MovieExtraPosters(posters: movie.images),
        ],
      ),
    );
  }
}

class MovieDetailsThumbnail extends StatelessWidget {
  const MovieDetailsThumbnail({Key? key, required this.thumbnail}) : super(key: key);
  final String thumbnail;
  final double thumbnailWidth = 400;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
            width: thumbnailWidth,
            height: thumbnailWidth*9/16,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(thumbnail),
              ),
            ),
          ),
            Icon(
              Icons.play_circle_outlined,
              size: 90,
              color: Colors.white,
            )],
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0x00F5F5F5),Colors.blueGrey.shade900],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          height: 100
        )
      ],
    );
  }
}

class MovieDetailsHeaderWithPoster extends StatelessWidget {

  const MovieDetailsHeaderWithPoster({Key? key, required this.movie}) : super(key: key);
  final Movie movie;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          MoviePoster(poster: movie.images[1].toString()),
          SizedBox(
            width: 16,
          ),
          Expanded(child: MovieDetailsHeader(movie: movie)),
        ],
      ),
    );
  }
}

class MovieDetailsHeader extends StatelessWidget {
  const MovieDetailsHeader({Key? key, required this.movie}) : super(key: key);
  final Movie movie;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${movie.year} . ${movie.genre}".toUpperCase(),
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: Colors.cyan,
          ),
        ),
        Text(
          '${movie.title}',
          style: TextStyle(
            fontSize: 32,
            color: Colors.white,
          ),
        ),
        Text.rich(
          TextSpan(
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w100,
              color: Colors.grey.shade100,
            ),
            children: [
              TextSpan(
                text: movie.plot,
              ),
              TextSpan(

              )
            ]
          )
        )
      ],
    );
  }
}

class MoviePoster extends StatelessWidget {
  const MoviePoster({Key? key, required this.poster}) : super(key: key);
  final String poster;
  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius = BorderRadius.circular(10);//USE THIS AS A LOCAL VARIABLE, NOT CLASS VARIABLE!
    return Card(
      color: Colors.transparent,
      margin: EdgeInsets.only(top:20),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Container(
          width: MediaQuery.of(context).size.width/4,//get 1/4 of the screen width
          height: 160,
          decoration: BoxDecoration(
            image: DecorationImage(
              image:NetworkImage(poster),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class MovieDetailsCast extends StatelessWidget {
  const MovieDetailsCast({Key? key, required this.movie}) : super(key: key);
  final Movie movie;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Column(
        children: [
          MovieField(field: "Cast", value: movie.actors),
          MovieField(field: "Directors", value: movie.director),
          MovieField(field: "Awards", value: movie.awards)
        ],
      ),
    );
  }
}

class MovieField extends StatelessWidget {
  const MovieField({Key? key, required this.field, required this.value}) : super(key: key);
  final String field;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      child: Row(
          children: [
            Flexible(
              child: Text(
                "$field : ",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            Text(
              "$value",
              style: TextStyle(
                color: Colors.white30,
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
            )
          ]
      ),
    );
  }
}

class HorizontalLine extends StatelessWidget {
  const HorizontalLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.5,
      color: Colors.white,
    );
  }
}

class MovieExtraPosters extends StatelessWidget {
  const MovieExtraPosters({Key? key, required this.posters}) : super(key: key);
  final List <String> posters;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("More posters".toUpperCase(),
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          Container(
            height:200,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => SizedBox(width: 8,),
                itemCount: posters.length,
                itemBuilder: (context,index) => ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 4,
                    height: 140,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(posters[index]),fit: BoxFit.cover,),
                    ),
                  )
                ),
              )
          )
        ],
      ),
    );
  }
}




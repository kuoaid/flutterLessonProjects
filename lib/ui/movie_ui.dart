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
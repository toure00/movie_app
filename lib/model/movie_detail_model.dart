class MovieDetailModel {
  Rating rating;
  List<Author> author;
  String altTitle;
  String image;
  String title;
  String summary;
  Attrs attrs;
  String id;
  String mobileLink;
  String alt;
  List<Tags> tags;

  MovieDetailModel(
      {this.rating,
      this.author,
      this.altTitle,
      this.image,
      this.title,
      this.summary,
      this.attrs,
      this.id,
      this.mobileLink,
      this.alt,
      this.tags});

  MovieDetailModel.fromJson(Map<String, dynamic> json) {
    rating =
        json['rating'] != null ? new Rating.fromJson(json['rating']) : null;
    if (json['author'] != null) {
      author = new List<Author>();
      json['author'].forEach((v) {
        author.add(new Author.fromJson(v));
      });
    }
    altTitle = json['alt_title'];
    image = json['image'];
    title = json['title'];
    summary = json['summary'];
    attrs = json['attrs'] != null ? new Attrs.fromJson(json['attrs']) : null;
    id = json['id'];
    mobileLink = json['mobile_link'];
    alt = json['alt'];
    if (json['tags'] != null) {
      tags = new List<Tags>();
      json['tags'].forEach((v) {
        tags.add(new Tags.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.rating != null) {
      data['rating'] = this.rating.toJson();
    }
    if (this.author != null) {
      data['author'] = this.author.map((v) => v.toJson()).toList();
    }
    data['alt_title'] = this.altTitle;
    data['image'] = this.image;
    data['title'] = this.title;
    data['summary'] = this.summary;
    if (this.attrs != null) {
      data['attrs'] = this.attrs.toJson();
    }
    data['id'] = this.id;
    data['mobile_link'] = this.mobileLink;
    data['alt'] = this.alt;
    if (this.tags != null) {
      data['tags'] = this.tags.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rating {
  int max;
  String average;
  int numRaters;
  int min;

  Rating({this.max, this.average, this.numRaters, this.min});

  Rating.fromJson(Map<String, dynamic> json) {
    max = json['max'];
    average = json['average'];
    numRaters = json['numRaters'];
    min = json['min'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['max'] = this.max;
    data['average'] = this.average;
    data['numRaters'] = this.numRaters;
    data['min'] = this.min;
    return data;
  }
}

class Author {
  String name;

  Author({this.name});

  Author.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class Attrs {
  List<String> language;
  List<String> pubdate;
  List<String> title;
  List<String> country;
  List<String> writer = [];
  List<String> director;
  List<String> cast;
  List<String> movieDuration;
  List<String> year;
  List<String> movieType;

  Attrs(
      {this.language,
      this.pubdate,
      this.title,
      this.country,
      this.writer,
      this.director,
      this.cast,
      this.movieDuration,
      this.year,
      this.movieType});

  Attrs.fromJson(Map<String, dynamic> json) {
    language = json['language'] == null ? [] : json['language'].cast<String>();
    pubdate =  json['pubdate'] == null ? [] : json['pubdate'].cast<String>();
    title =    json['title'] == null ? [] : json['title'].cast<String>();
    country =  json['country'] == null ? [] : json['country'].cast<String>();
    writer = json['writer'] == null ? [] :json['writer'].cast<String>();
    director =  json['director'] == null ? [] : json['director'].cast<String>();
    cast =      json['cast'] == null ? [] : json['cast'].cast<String>();
    movieDuration = json['movie_duration'] == null ? [] : json['movie_duration'].cast<String>();
    year =      json['year'] == null ? [] : json['year'].cast<String>();
    movieType = json['movie_type'] == null ? [] : json['movie_type'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['language'] = this.language;
    data['pubdate'] = this.pubdate;
    data['title'] = this.title;
    data['country'] = this.country;
    data['writer'] = this.writer;
    data['director'] = this.director;
    data['cast'] = this.cast;
    data['movie_duration'] = this.movieDuration;
    data['year'] = this.year;
    data['movie_type'] = this.movieType;
    return data;
  }
}

class Tags {
  int count;
  String name;

  Tags({this.count, this.name});

  Tags.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['name'] = this.name;
    return data;
  }
}
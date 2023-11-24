class Recipe{
  String name;
  String time;
  String category;
  String imageLink;
  String description;
  String stepsDescription;
  double rating;
  bool isLiked;

  Recipe({
     this.name = 'Apple',
     this.imageLink = 'assets/images/recipe_photos/pure.jpg',
     this.time = '30',
     this.category = 'Обед',
     this.description = '...',
     this.rating = 3,
     this.stepsDescription = '...',
    this.isLiked = false,
  });

  set setImage(String path) {
    imageLink = path;
  }
  set setName(String path) {
    name = path;
  }
  set setTime(String path) {
    time = path;
  }
  set setCategory(String path) {
    category = path;
  }
  set setDescription(String path) {
    description = path;
  }
  set setRating(double path) {
    rating = path;
  }
  set setStepsDescription(String path) {
    stepsDescription = path;
  }
}
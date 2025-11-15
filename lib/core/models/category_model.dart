class CategoryModel {
  final int id;
  final String title;
  final String imageLightPath;
  final String imageDarkPath;
  final String categoryName;

  CategoryModel({
    required this.categoryName,
    required this.id,
    required this.title,
    required this.imageLightPath,
    required this.imageDarkPath,
  });

  static List<CategoryModel> categories = [
    CategoryModel(
      id: 1,
      title: "📰   General",
      imageLightPath: "assets/images/general_black.png",
      imageDarkPath: "assets/images/general.png",
      categoryName: "general",
    ),
    CategoryModel(
      id: 2,
      title: "💼   Business",
      imageLightPath: "assets/images/business_black.png",
      imageDarkPath: "assets/images/business.png",
      categoryName: "business",
    ),
    CategoryModel(
      id: 3,
      title: "🏈   Sports",
      imageLightPath: "assets/images/sport_black.png",
      imageDarkPath: "assets/images/sport.png",
      categoryName: "sports",
    ),
    CategoryModel(
      id: 4,
      title: "💻   Technology",
      imageLightPath: "assets/images/technology_black.png",
      imageDarkPath: "assets/images/technology.png",
      categoryName: "technology",
    ),
    CategoryModel(
      id: 5,
      title: "🔬   Science",
      imageLightPath: "assets/images/science_black.png",
      imageDarkPath: "assets/images/science.png",
      categoryName: "science",
    ),
    CategoryModel(
      id: 6,
      title: "🩺   Health",
      imageLightPath: "assets/images/health_black.png",
      imageDarkPath: "assets/images/health.png",
      categoryName: "health",
    ),
    CategoryModel(
      id: 7,
      title: "🎬   Entertainment",
      imageLightPath: "assets/images/entertainment_black.png",
      imageDarkPath: "assets/images/entertainment.png",
      categoryName: "entertainment",
    ),
  ];
}

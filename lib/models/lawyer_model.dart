class Lawyer {
  final String name;
  final String role;
  final String experience;
  final String cases;
  final String rate;
  final double rating;
  final String status;
  final String imagePath;
  final String bio;
  final List<String> practiceAreas;

  Lawyer({
    required this.name,
    required this.role,
    required this.experience,
    required this.cases,
    required this.rate,
    required this.rating,
    required this.status,
    this.imagePath = 'assets/images/lawyer_image.jpg',
    required this.bio,
    required this.practiceAreas,
  });
}
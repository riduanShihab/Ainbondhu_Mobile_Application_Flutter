class LawyerService {
  final String category;
  final String title;
  final String subTitle;
  final String description;
  final List<ServicePackage> packages;

  LawyerService({
    required this.category,
    required this.title,
    required this.subTitle,
    required this.description,
    required this.packages,
  });
}

class ServicePackage {
  final String name;
  final String time;
  final String price;

  ServicePackage({required this.name, required this.time, required this.price});
}
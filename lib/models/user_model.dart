class UserProfileModel {
  String name;
  String email;
  String image;
  int totalInterviews;
  int services;
  int completed;
  String? phone;
  String? nid;
  String? address;
  String? city;

  UserProfileModel({
    required this.name,
    required this.email,
    required this.image,
    required this.totalInterviews,
    required this.services,
    required this.completed,
    this.phone,
    this.nid,
    this.address,
    this.city,
  });
}

class ProfileMenuItemModel {
  final String title;
  final String subtitle;
  final dynamic
  icon; // Using dynamic to support IconData or asset paths if needed later
  final String route;

  ProfileMenuItemModel({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.route,
  });
}
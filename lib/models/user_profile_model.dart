class UserProfileModel {
  final String name;
  final String email;
  final String image;
  final int totalInterviews;
  final int services;
  final int completed;
  final String? barCouncilNo;
  final double? rating;

  UserProfileModel({
    required this.name,
    required this.email,
    required this.image,
    required this.totalInterviews,
    required this.services,
    required this.completed,
    this.barCouncilNo,
    this.rating,
  });
}
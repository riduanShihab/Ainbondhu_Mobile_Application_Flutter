class AppointmentModel {
  final String id;
  final String name;
  final String date;
  final String time;
  final String type; // e.g., 'Video Call', 'Audio Call', 'In-Person'
  final String image;
  final String status; // 'Pending', 'Confirmed', 'Completed'
  final String? email;
  final String? phone;
  final String? subject;
  final String? summary;
  final String? duration;
  final String? meetLink;

  AppointmentModel({
    required this.id,
    required this.name,
    required this.date,
    required this.time,
    required this.type,
    required this.image,
    required this.status,
    this.email,
    this.phone,
    this.subject,
    this.summary,
    this.duration,
    this.meetLink,
  });
}

class DashboardStatModel {
  final String title;
  final String value;
  final String iconCode;
  final bool isStatus;

  DashboardStatModel({
    required this.title,
    required this.value,
    this.iconCode = 'default',
    this.isStatus = false,
  });
}

class Lawyer {
  final String name;
  final String role;
  final String experience;
  final String cases;
  final String rate;
  final double rating;
  final String status;
  final String imagePath;

  Lawyer({
    required this.name,
    required this.role,
    required this.experience,
    required this.cases,
    required this.rate,
    required this.rating,
    required this.status,
    required this.imagePath,
  });
}
class ConsultationModel {
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String? selectedLawyer;
  String subject;

  ConsultationModel({
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.phoneNumber = '',
    this.selectedLawyer,
    this.subject = '',
  });
}
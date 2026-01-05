class BookingDateModel {
  final int id;
  final String startDate;
  final String endDate;


  BookingDateModel( {
    required this.id,
    required this.startDate,
    required this.endDate,
  });

  factory BookingDateModel.fromJson(Map<String, dynamic> json) {
    return BookingDateModel(
      id: json['id'],
      startDate: json['start_date'],
      endDate: json['end_date'],

    );
  }
}

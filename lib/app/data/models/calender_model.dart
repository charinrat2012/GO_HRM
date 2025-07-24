class CalenderEventModel {
  final DateTime date; 
  final String title;
  final String? description;
  final String time;
  final String? note;

  const CalenderEventModel({
    required this.date, 
    required this.title,
    this.description,
    required this.time,
    required this.note
  });

  @override
  String toString() => title;

  
  factory CalenderEventModel.fromMap(DateTime date, Map<String, dynamic> map) {
    return CalenderEventModel(
      date: date, 
      title: map['title'] ?? '',
      description: map['description'],
      time: map['time'] ?? 'ทั้งวัน',
      note: map['note'] ?? '',
    );
  }
}
import 'package:incetro_test/features/card_details/domain/entities/schedule.dart';

class ScheduleModel{
  final int day;
  final int start;
  final int end;

  ScheduleModel({required this.day, required this.start, required this.end});

  factory ScheduleModel.fromJson(Map<String, dynamic> json){
    print('МЫ ДОШЛИ ДО ТЕЛА ФУНКЦИИ ШЕДУЛЬ');
    return ScheduleModel(
      day: json['day'],
      start: json['start'],
      end: json['end'],
    );
  }

  Schedule toEntity(){
    return Schedule(
      day: day,
      start: start,
      end: end,
    );
  }
}
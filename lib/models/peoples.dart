import 'package:equatable/equatable.dart';
import 'package:starwars/models/people.dart';

class Peoples extends Equatable {
  final int? count;
  final String? next;
  final dynamic previous;
  final List<People>? results;

  const Peoples({this.count, this.next, this.previous, this.results});

  factory Peoples.fromJson(Map<String, dynamic> json) => Peoples(
        count: json['count'] as int?,
        next: json['next'] as String?,
        previous: json['previous'] as dynamic?,
        results: (json['results'] as List<dynamic>?)
            ?.map((e) => People.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'count': count,
        'next': next,
        'previous': previous,
        'results': results?.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props => [count, next, previous, results];
}

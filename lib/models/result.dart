import 'package:equatable/equatable.dart';

class Result extends Equatable {
  final String? name;
  final String? height;
  final String? mass;
  final String? hairColor;
  final String? skinColor;
  final String? eyeColor;
  final String? birthYear;
  final String? gender;
  final String? homeworld;
  final List<String>? films;
  final List<dynamic>? species;
  final List<String>? vehicles;
  final List<String>? starships;
  final String? created;
  final String? edited;
  final String? url;

  const Result({
    this.name,
    this.height,
    this.mass,
    this.hairColor,
    this.skinColor,
    this.eyeColor,
    this.birthYear,
    this.gender,
    this.homeworld,
    this.films,
    this.species,
    this.vehicles,
    this.starships,
    this.created,
    this.edited,
    this.url,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        name: json['name'] as String?,
        height: json['height'] as String?,
        mass: json['mass'] as String?,
        hairColor: json['hair_color'] as String?,
        skinColor: json['skin_color'] as String?,
        eyeColor: json['eye_color'] as String?,
        birthYear: json['birth_year'] as String?,
        gender: json['gender'] as String?,
        homeworld: json['homeworld'] as String?,
        films: json['films'] as List<String>?,
        species: json['species'] as List<dynamic>?,
        vehicles: json['vehicles'] as List<String>?,
        starships: json['starships'] as List<String>?,
        created: json['created'] as String?,
        edited: json['edited'] as String?,
        url: json['url'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'height': height,
        'mass': mass,
        'hair_color': hairColor,
        'skin_color': skinColor,
        'eye_color': eyeColor,
        'birth_year': birthYear,
        'gender': gender,
        'homeworld': homeworld,
        'films': films,
        'species': species,
        'vehicles': vehicles,
        'starships': starships,
        'created': created,
        'edited': edited,
        'url': url,
      };

  @override
  List<Object?> get props {
    return [
      name,
      height,
      mass,
      hairColor,
      skinColor,
      eyeColor,
      birthYear,
      gender,
      homeworld,
      films,
      species,
      vehicles,
      starships,
      created,
      edited,
      url,
    ];
  }
}

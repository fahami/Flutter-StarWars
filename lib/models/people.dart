import 'dart:convert';

import 'package:equatable/equatable.dart';

class People extends Equatable {
  final String? name;
  final String? height;
  final String? mass;
  final String? hairColor;
  final String? skinColor;
  final String? eyeColor;
  final String? birthYear;
  final String? gender;
  final String? homeworld;
  final List<dynamic>? films;
  final List<dynamic>? species;
  final List<dynamic>? vehicles;
  final List<dynamic>? starships;
  final String? created;
  final String? edited;
  final String? url;

  const People({
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

  factory People.fromJson(Map<String, dynamic> json) => People(
        name: json['name'] as String?,
        height: json['height'].toString(),
        mass: json['mass'].toString(),
        hairColor: json['hair_color'] as String?,
        skinColor: json['skin_color'] as String?,
        eyeColor: json['eye_color'] as String?,
        birthYear: json['birth_year'] as String?,
        gender: json['gender'] as String?,
        homeworld: json['homeworld'] as String?,
        films: json["films"] != null
            ? List<String>.from(json["films"].map((x) => x))
            : null,
        species: json["species"] != null
            ? List<String>.from(json["species"].map((x) => x))
            : null,
        vehicles: json["vehicles"] != null
            ? List<String>.from(json["vehicles"].map((x) => x))
            : null,
        starships: json["starships"] != null
            ? List<String>.from(json["starships"].map((x) => x))
            : null,
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
        'films': json.encode(films),
        'species': json.encode(species),
        'vehicles': json.encode(vehicles),
        'starships': json.encode(starships),
        'created': created,
        'edited': edited,
        'url': url,
      };
  List<String> get params => [
        "name",
        "height",
        "mass",
        "hairColor",
        "skinColor",
        "eyeColor",
        "birthYear",
        "gender",
        "homeworld",
        "films",
        "species",
        "vehicles",
        "starships",
        "created",
        "edited",
        "url",
      ];
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

import 'package:equatable/equatable.dart';

abstract class Queryable extends Equatable {
  final String id;
  final String name;
  final String thumbnailUrl;

  Queryable(
    this.id,
    this.name,
    this.thumbnailUrl,
  );
}

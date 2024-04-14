import 'package:code_hero/app/domain/entities/thumbnail_entity.dart';
import 'package:equatable/equatable.dart';

class ThumbnailModel extends Equatable {
  final String? path;
  final String? extension;

  const ThumbnailModel({this.path, this.extension});

  ThumbnailEntity toEntity() => ThumbnailEntity(
        path: path,
        extension: extension,
      );

  ThumbnailModel fromJson(Map<String, dynamic> json) {
    return ThumbnailModel(
      path: json['path'],
      extension: json['extension'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['path'] = path;
    data['extension'] = extension;
    return data;
  }

  @override
  List<Object?> get props => [path, extension];
}

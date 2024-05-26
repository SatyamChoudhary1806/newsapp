import 'package:json_annotation/json_annotation.dart';

part 'news_services.g.dart';

@JsonSerializable()
class NewsServices {
  final String? status;
  final int? totalResults;
  final List<Articles>? articles;

  const NewsServices({
    this.status,
    this.totalResults,
    this.articles,
  });

  factory NewsServices.fromJson(Map<String, dynamic> json) =>
      _$NewsServicesFromJson(json);

  Map<String, dynamic> toJson() => _$NewsServicesToJson(this);
}

@JsonSerializable()
class Articles {
  final Source? source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

   Articles({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory Articles.fromJson(Map<String, dynamic> json) =>
      _$ArticlesFromJson(json);

  Map<String, dynamic> toJson() => _$ArticlesToJson(this);
}

@JsonSerializable()
class Source {
  final String? name;
  const Source({
    this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) =>
      _$SourceFromJson(json);

  Map<String, dynamic> toJson() => _$SourceToJson(this);
}

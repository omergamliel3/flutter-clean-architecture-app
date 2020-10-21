// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleModel _$ArticleModelFromJson(Map json) {
  return ArticleModel(
    title: json['title'] as String,
    content: json['content'] as String,
    publishedAt: DateTime.parse(json['publishedAt'] as String),
    url: json['url'] as String,
    urlToImage: json['urlToImage'] as String,
  );
}

Map<String, dynamic> _$ArticleModelToJson(ArticleModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'publishedAt': instance.publishedAt.toIso8601String(),
      'url': instance.url,
      'urlToImage': instance.urlToImage,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RestClient implements RestClient {
  _RestClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://newsapi.org/v2/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<List<ArticleModel>> getTopHeadlines() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/top-headlines?language=en&pageSize=100&apiKey=a7e670365d50454a9d746ae81fbbae29',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final values = _result.data['articles'] as List<dynamic>;
    return values
        .map((e) => ArticleModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

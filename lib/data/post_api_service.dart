import 'package:chopper/chopper.dart';
import 'package:flutter_chopper/data/built_value_converter.dart';
import 'package:flutter_chopper/models/built_post.dart';
import 'package:built_collection/built_collection.dart';

part 'post_api_service.chopper.dart';

@ChopperApi(baseUrl: 'https://jsonplaceholder.typicode.com/posts')
abstract class PostApiService extends ChopperService {
  @Get()
  Future<Response<BuiltList<BuiltPost>>> getPosts();

  @Get(path: '/{id}')
  Future<Response<BuiltPost>> getPost(@Path('id') int id);

  @Post()
  Future<Response<BuiltPost>> postPost(
    @Body() BuiltPost body,
  );

  static PostApiService create() {
    final client = ChopperClient(
        baseUrl: 'https://jsonplaceholder.typicode.com',
        services: [
          _$PostApiService(),
        ],
        converter: BuiltValueConverter(),
        interceptors: [
          // HeadersInterceptor({
          //   'Cache-Control': 'no-cache',
          //   'Message': '@@@@@@@@@@@@@@@@@@@',
          // }),
          HttpLoggingInterceptor(),
          // CurlInterceptor(),
          // (Request request) async {
          //   if (request.method == HttpMethod.Post) {
          //     chopperLogger.info('Performed a POST request');
          //   }
          //   return request;
          // },
          // (Response response) async {
          //   if (response.statusCode == 404) {
          //     chopperLogger.severe('404 NOT FOUND');
          //   }
          //   return response;
          // },
          // MobileDataInterceptor(),
        ]);
    return _$PostApiService(client);
  }
}

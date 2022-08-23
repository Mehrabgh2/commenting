import 'package:commenting/core/text_formatter.dart';
import 'package:commenting/model/product.dart';
import 'package:commenting/model/sended_comment.dart';
import 'package:commenting/model/server_response.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class ApiService {
  static var dio = Dio();

  static Future<Either<int, ServerResponse>> getProductCategoryLink(
      String link) async {
    var request = RequestOptions(
        path: link, contentType: 'application/json', method: 'GET');
    try {
      Response response = await dio.fetch(request).catchError((onError) {
        print(onError.response);
        return onError.response;
      });
      if (response.statusCode == 200) {
        String _link = response.headers.map['link'] != null
            ? response.headers.map['link']![1]
            : '0';
        return Left(TextFormatter()
            .extractProductId(TextFormatter().extractProductLink(_link)));
      } else {
        return Right(response.data['message']);
      }
    } catch (ex) {
      return Right(ServerResponse(code: 0, message: 'عملیات با مشکل مواجه شد'));
    }
  }

  static Future<Either<List<Product>, ServerResponse>> getCategoryProducts(
      int code, int count, int page) async {
    var request = RequestOptions(
      path:
          'https://diginice.com/wp-json/wp/v2/product?product_cat=$code&per_page=$count&page=$page',
      contentType: 'application/json',
      method: 'GET',
    );
    try {
      Response response = await dio.fetch(request).catchError((onError) {
        return onError.response;
      });
      if (response.statusCode == 200) {
        List<Product> products = List.empty(growable: true);
        (response.data as List).forEach((element) {
          products.add(Product.fromServerJson(element));
        });
        return Left(products);
      } else {
        return Right(response.data['message']);
      }
    } catch (ex) {
      return Right(ServerResponse(code: 0, message: 'عملیات با مشکل مواجه شد'));
    }
  }

  static Future<Either<List<Product>, ServerResponse>> getSearchProducts(
      String query, int count, int page) async {
    var request = RequestOptions(
      path:
          'https://diginice.com/wp-json/wp/v2/product?search=$query&per_page=$count&page=$page',
      contentType: 'application/json',
      method: 'GET',
    );
    try {
      Response response = await dio.fetch(request).catchError((onError) {
        return onError.response;
      });
      if (response.statusCode == 200) {
        List<Product> products = List.empty(growable: true);
        (response.data as List).forEach((element) {
          products.add(Product.fromServerJson(element));
        });
        return Left(products);
      } else {
        return Right(response.data['message']);
      }
    } catch (ex) {
      return Right(ServerResponse(code: 0, message: 'عملیات با مشکل مواجه شد'));
    }
  }

  static Future<Either<String, String>> sendComment(
      SendedComment sendedComment) async {
    FormData formData = FormData.fromMap(sendedComment.toFormData());
    var request = RequestOptions(
        path: 'https://diginice.com/wp-comments-post.php',
        contentType: 'application/json',
        data: formData,
        method: 'POST');
    print(formData.fields.toString() + ' ' + DateTime.now().second.toString());
    try {
      Response response = await dio.fetch(request).catchError((onError) {
        return onError.response;
      });
      if (response.statusCode == 200 || response.statusCode == 302) {
        return const Left('کامنت با موفقیت ثبت شد');
      } else {
        switch (response.statusCode) {
          case 409:
            return const Right('کامنت تکراری');
          case 429:
            return const Right('تلاش بیش از حد مجاز');
          default:
            return const Right('خطای نامشخص');
        }
      }
    } catch (ex) {
      return Right(ex.toString());
    }
  }
}

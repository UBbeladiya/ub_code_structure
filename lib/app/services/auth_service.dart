import '../api/end_point.dart';
import '../api/web_service_helper.dart';
import '../models/product_model.dart';
import '../utils/utils.dart';

class AuthService {
  Future<List<ProductModel>?> getDetails() async {
    final webserviceHelper = WebserviceHelper(endPointType: Endpoint.posts, path: []);
    final map = await webserviceHelper.postNormal();
    final List<ProductModel> products = (map['data'] as List<dynamic>)
        .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList();
    Utils.debugLog(title: "getDetails", object: "${map['data'].runtimeType}");
    return products;
  }

  Future<ProductModel?> postDetails() async {
    final webserviceHelper = WebserviceHelper(
      endPointType: Endpoint.addPost,
      path: [],
      params: {
        "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
        "body":
            "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto",
      },
    );
    final map = await webserviceHelper.postNormal();
    Utils.debugLog(title: "postDetails", object: " $map ${map['data'].runtimeType}");
    final ProductModel products = ProductModel.fromJson(map);

    return products;
  }

  Future<ProductModel?> putDetails() async {
    final webserviceHelper = WebserviceHelper(endPointType: Endpoint.postsId, path: ['2']);

    final map = await webserviceHelper.postNormal();
    Utils.debugLog(title: "putDetails", object: " $map ${map['data'].runtimeType}");
    // final ProductModel products = ProductModel.fromJson(map);

    return null;
  }
}

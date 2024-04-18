import 'package:pantest/lib.dart';

abstract class SocialMediaDatasource {
  Future<UserResponseModel> getListUser(Map<String, dynamic> payload);

  Future<ProfileResponseModel> getProfile(String idUser);

  Future<PostProfileResponseModel> getListPostProfile(
      Map<String, dynamic> payload, String id);

  Future<ExploreResponseModel> getListPostExplore(
      Map<String, dynamic> payload, String? tag);
}

class SocialMediaDatasourceImpl implements SocialMediaDatasource {
  @override
  Future<UserResponseModel> getListUser(Map<String, dynamic> payload) async {
    try {
      final response = await CustomDio.instance.get(
        "https://dummyapi.io/data/v1/user",
        queryParameters: payload,
      );
      if (response.statusCode == 200) {
        return UserResponseModel.fromJson(response.data);
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.error ?? 'Error on ${e.requestOptions.path}');
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ProfileResponseModel> getProfile(String idUser) async {
    try {
      final response = await CustomDio.instance.get(
        "https://dummyapi.io/data/v1/user/$idUser",
      );
      if (response.statusCode == 200) {
        return ProfileResponseModel.fromJson(response.data);
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.error ?? 'Error on ${e.requestOptions.path}');
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<PostProfileResponseModel> getListPostProfile(
      Map<String, dynamic> payload, String id) async {
    try {
      final response = await CustomDio.instance.get(
        "https://dummyapi.io/data/v1/user/$id/post",
        queryParameters: payload,
      );
      if (response.statusCode == 200) {
        return PostProfileResponseModel.fromJson(response.data);
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.error ?? 'Error on ${e.requestOptions.path}');
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ExploreResponseModel> getListPostExplore(
      Map<String, dynamic> payload, String? tag) async {
    String endPoint = tag == null
        ? "https://dummyapi.io/data/v1/post"
        : "https://dummyapi.io/data/v1/tag/$tag/post";

    try {
      final response = await CustomDio.instance.get(
        endPoint,
        queryParameters: payload,
      );
      if (response.statusCode == 200) {
        return ExploreResponseModel.fromJson(response.data);
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.error ?? 'Error on ${e.requestOptions.path}');
    } catch (e) {
      throw Exception(e);
    }
  }
}

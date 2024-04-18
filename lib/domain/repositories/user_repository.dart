import 'package:dartz/dartz.dart';
import 'package:pantest/core/error/failure.dart';
import 'package:pantest/data/models/explore_response_model.dart';
import 'package:pantest/data/models/post_profile_response_model.dart';
import 'package:pantest/data/models/profile_response_model.dart';
import 'package:pantest/data/models/user_response_model.dart';

abstract class SocialMediaRepository {
  Future<Either<Failure, UserResponseModel>> getListUser(Map<String, dynamic> payload);

  Future<Either<Failure, ProfileResponseModel>> getProfile(String idUser);

  Future<Either<Failure, PostProfileResponseModel>> getListPostProfile(Map<String, dynamic> payload, String id);

  Future<Either<Failure, ExploreResponseModel>> getListPostExplore(Map<String, dynamic> payload, String? tag);
}
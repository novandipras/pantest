import 'package:dartz/dartz.dart';
import 'package:pantest/lib.dart';

class SocialMediaRepositoryImpl implements SocialMediaRepository {
  SocialMediaRepositoryImpl({
    required this.socialMediaDatasource,
  });

  final SocialMediaDatasource socialMediaDatasource;

  @override
  Future<Either<Failure, UserResponseModel>> getListUser(
      Map<String, dynamic> payload) async {
    try {
      final result = await socialMediaDatasource.getListUser(payload);
      return Right(result);
    } catch (e) {
      return Left(OtherFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProfileResponseModel>> getProfile(
      String idUser) async {
    try {
      final result = await socialMediaDatasource.getProfile(idUser);
      return Right(result);
    } catch (e) {
      return Left(OtherFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PostProfileResponseModel>> getListPostProfile(
      Map<String, dynamic> payload, String id) async {
    try {
      final result = await socialMediaDatasource.getListPostProfile(payload,id);
      return Right(result);
    } catch (e) {
      return Left(OtherFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ExploreResponseModel>> getListPostExplore(Map<String, dynamic> payload, String? tag) async {
    try {
      final result = await socialMediaDatasource.getListPostExplore(payload, tag);
      return Right(result);
    } catch (e) {
      return Left(OtherFailure(e.toString()));
    }
  }
}

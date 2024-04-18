import 'package:dartz/dartz.dart';
import 'package:pantest/lib.dart';

class SocialMediaUsecase {
  SocialMediaUsecase(this.socialMediaRepository);

  final SocialMediaRepository socialMediaRepository;

  Future<Either<Failure, UserResponseModel>> getListUserUsecase(
      {required Map<String, dynamic> payload}) {
    return socialMediaRepository.getListUser(payload);
  }

  Future<Either<Failure, ProfileResponseModel>> getProfileUsecase(
      String idUser) {
    return socialMediaRepository.getProfile(idUser);
  }

  Future<Either<Failure, PostProfileResponseModel>> getListPostProfileUsecase(
      {required Map<String, dynamic> payload, required String id}) {
    return socialMediaRepository.getListPostProfile(payload, id);
  }

  Future<Either<Failure, ExploreResponseModel>> getListPostExploreUsecase(
      {required Map<String, dynamic> payload, String? tag}) {
    return socialMediaRepository.getListPostExplore(payload, tag);
  }
}

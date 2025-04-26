import 'package:dartz/dartz.dart';

import '../../common/utils/failure.dart';
import '../../data/data_models/get_users_data.dart';
import '../../data/models/user/glehiha_user_info.dart';

abstract class UserRepository{
  /// Get all users
  Future<Either<Failure, GetUsersData>> getUsers({
    required int page,
    String? search,
  });
  
  Future<Either<Failure, GlehihaUserInfo>> getUsersdata({
    required int userId,
  });

  Future<Either<Failure, String>> setPostConfidentialy({ required String type});
}
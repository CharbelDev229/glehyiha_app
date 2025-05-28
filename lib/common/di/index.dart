import 'package:glehiha/common/di/services .dart';
import 'package:glehiha/common/di/core.dart';
import 'package:glehiha/common/di/data_sources.dart';
import 'package:glehiha/common/di/repositories.dart';
import 'package:glehiha/common/di/use_cases.dart';

class Di {
  static init() async {
    await DiCore.dependencies();
    DiDataSources.dependencies();
    DiRepositories.dependencies();
    DiUseCases.dependencies();
    await DiServices.dependencies();
  }
}

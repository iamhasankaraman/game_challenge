import 'package:get_it/get_it.dart';
import '../../presentation/viewmodels/home_view_model.dart';
import '../../presentation/viewmodels/quiz_view_model.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // ViewModels
  getIt.registerFactory(() => HomeViewModel());
  getIt.registerFactory(() => QuizViewModel());
}

import 'package:get_it/get_it.dart';
import '../../presentation/viewmodels/quiz_view_model.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => QuizViewModel());
}

import 'package:get_it/get_it.dart';
import 'data_storage.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // Register services
  locator.registerSingleton(DataStorage());
}

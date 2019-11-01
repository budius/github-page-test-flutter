import 'package:get_it/get_it.dart';
import 'package:elapsed_time/data_storage.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // Register services
  locator.registerSingleton(DataStorage());
}

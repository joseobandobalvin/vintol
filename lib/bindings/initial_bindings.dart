import 'package:vintol/controllers/theme_controller.dart';

import 'package:get/get.dart';
import 'package:vintol/providers/local/database_provider.dart';

//another

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    DatabaseProvider.db.initialData();
    Get.put(ThemeController());
  }
}

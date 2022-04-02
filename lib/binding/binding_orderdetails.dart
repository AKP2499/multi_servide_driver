
import 'package:dunzodriver_copy1/controller/order_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => OrderController());
  }
}
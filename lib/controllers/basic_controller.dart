import 'package:get/get.dart';

class BasicController extends GetxController implements GetxService {
  //--dashbord screen complete and ongoing order toggle
  bool isOnGoingOrder = true;
  void setIsComplete(bool order) {
    isOnGoingOrder = order;
    update();
  }
  //
}

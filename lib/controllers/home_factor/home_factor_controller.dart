import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeFactorController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    replaceList();
  }

  RxBool isLoading = false.obs;
  RxList<String> factorList = <String>[].obs;
  late SharedPreferences preferences;

  void replaceList() async {
    final list = await getNewFactor();
    factorList.value = list;
    print(list);
  }

  Future<List<String>> getNewFactor() async {
    preferences = await SharedPreferences.getInstance();
    return preferences.getStringList(
          'isAdded',
        ) ??
        [];
  }
}
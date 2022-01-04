import 'package:factor_flutter_mobile/core/theme/factor_theme.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MoreController extends GetxController{


  @override
  void onInit() {
    super.onInit();
    initSharedPreferences();
  }



  RxBool isDark = false.obs;

  void changeTheme(){
    if(isDark.value){
      Get.changeTheme(FactorTheme.darkTheme);
    }else{
      Get.changeTheme(FactorTheme.lightTheme);
    }

  }

  late SharedPreferences sharedPreferences;

  initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    getTheme();
  }



  void saveTheme() {
    sharedPreferences.setBool('saveTheme', isDark.value);
  }

  void getTheme() {
    isDark.value = sharedPreferences.getBool('saveTheme') ?? false;
    Get.changeTheme(isDark.value ? FactorTheme.darkTheme :FactorTheme.lightTheme);
  }



}
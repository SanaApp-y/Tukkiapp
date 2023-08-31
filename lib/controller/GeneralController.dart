import 'package:Tukki/config/Api.dart';
import 'package:Tukki/config/http_service.dart';
import 'package:Tukki/model/GeneralDataModel.dart';
import 'package:get/get.dart';

GeneralDataModel? generalDataModel;
GeneralController generalController=Get.put(GeneralController());

class GeneralController extends GetxController{

  RxBool hasGeneralData=false.obs;
  RxBool failed=false.obs;
  RxInt currentIndex=0.obs;

  fetchGeneralSettings() async {
    var response=await httpPost(Config.getgeneralSettings, {});
    if(response!=null){
      if(response['status']==200){
        hasGeneralData.value=true;
        generalDataModel=GeneralDataModel.fromJson(response);
      }else{
        failed.value=true;
      }
    }else{
      failed.value=true;
      hasGeneralData.value=false;
    }
  }
}
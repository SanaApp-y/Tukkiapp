import 'dart:convert';
import 'package:Tukki/config/Api.dart';
import 'package:Tukki/config/http_service.dart';
import 'package:Tukki/model/BookDateRealEstate.dart';
import 'package:Tukki/utils/ProjectColors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class BookRealEstateController extends GetxController implements GetxService {
  DateRangePickerController controller = DateRangePickerController();

  String _selectedDate = '';
  String _dateCount = '';
  String StartDate = '';
  String EndDate = '';
  String _rangeCount = '';
  int count = 1;
  List<DateTime> selectedDates = [];
  bool checkDateResult = false;
  String checkDateMsg = "";
  dynamic idFeatured = "";
  String rangeCount = '';
  bool chack = false;
  List days = [];
  var StartDatein = "";
  RxString endDate = ''.obs;
  RxString startDate = ''.obs;
  bool isDateAvailale = false;
  RxString showCheckBtn = "".obs;
  RxBool coupneAdded = false.obs;
  RxBool showAddCouponBtn = false.obs;
  RxBool isDateChecking=false.obs;

  onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      startDate.value = '${DateFormat('yyyy-MM-dd').format(args.value.startDate)}';
      endDate.value = '${DateFormat('yyyy-MM-dd').format(args.value.endDate ?? args.value.startDate)}';
      checkDateApi(idFeatured: '$idFeatured');
    } else if (args.value is DateTime) {
      _selectedDate = args.value.toString();
    } else if (args.value is List<DateTime>) {
      _dateCount = args.value.length.toString();
    } else {
      _rangeCount = args.value.length.toString();
    }
  }

  checkDateApi({String? idFeatured}) async {

    if (startDate.value == endDate.value) {
      isDateAvailale = false;
      endDate.value = "";
      return;
    }
    isDateChecking.value=true;
    try {
      Map map = {
        "property_id": "${idFeatured}",
        "check_in": '${startDate.value}',
        "check_out": "${endDate.value}"
      };
      var response = await http.post(
          Uri.parse(Config.baseurl + Config.checkBookingAvailability),
          body: map);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        checkDateResult = result["data"]['availability']['is_available'];
        checkDateMsg = result["error"];
        if (checkDateResult) {
          isDateAvailale = true;
          if (chack == true) {}
        } else {
          isDateAvailale = false;

          if (checkDateMsg.isEmpty) {
            Fluttertoast.showToast(msg: 'Booking not available at this date');
          } else {
            Fluttertoast.showToast(
              msg: checkDateMsg,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: RedColor,
              textColor: Colors.white,
              fontSize: 14.0,
            );
          }
        }
      }
    } catch (e) {
      print(e.toString());
    }
    isDateChecking.value=false;
  }

  bookDateApi({String? idFeatured}) async {
    var response = await http.post(Uri.parse(Config.baseurl + Config.bookingDateApi), body: {'id': idFeatured});

    if (response.statusCode == 200) {
      BookdDate result = BookdDate.fromJson(jsonDecode(response.body));
      return result;
    }
  }

  static Future<BookdDate> fetchBookedDateapi(String idFeatured) async {
    try {
      var response = await http.post(
        Uri.parse(Config.baseurl + Config.bookingDateApi),
        body: {'id': idFeatured},
      );

      if (response.statusCode == 200) {
        return BookdDate.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print("Error fetching booked date: $e");
    }
    return BookdDate();
  }
  checkCouponMethod(code) async {
    var response = await httpPost(Config.checkCouponCode, code);
    print(response);
    if(response!=null){
      if(response['status']==200){
        return response['data']['coupon'];
      }else{
        Fluttertoast.showToast(msg: response['error']);
      }
    }else{
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }

  bookPropertyMethod(String itemId,String checkIn,String checkOut,String totalNight, String pernight, String bookfor, String basePrice, String serviceCharge,String serviceMoney,String ivaText, String total,String currencyCode,String paymentMethod,String wallAmount, String hostId) async {

    Map map={
      "itemid":itemId,
      "check_in":checkIn,
      "check_out":checkOut,
      "total_night":totalNight,
      "per_night":pernight,
      "book_for":bookfor,
      "base_price":basePrice,
      "service_charge":serviceCharge,
      "security_money":serviceCharge,
      "iva_tax":ivaText,
      "total":total,
      "currency_code":currencyCode,
      "payment_method":paymentMethod,
      "wall_amt":wallAmount,
      "host_id":hostId
    };
    var response=await httpPost(Config.bookProperty,map);
    if(response!=null){
      if(response['status']==200){
      }else{
        Fluttertoast.showToast(msg: "${response['error']}");
      }
    }else{
      Fluttertoast.showToast(msg: "Something went wrong");
    }
    return response;
  }

}

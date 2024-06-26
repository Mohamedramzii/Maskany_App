// ignore_for_file: constant_identifier_names

final emailValidation =
    RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

const String baseUrl = 'http://66.45.248.247:8000';

enum InternetState { initial, lost, gained }

const String tokenKey = '';
String tokenHolder = '';
bool isviewed = false;
bool isAllRequestsDone = false;
List gov = [
  {"id": "1", "governorate_name_ar": "القاهرة", "governorate_name_en": "Cairo"},
  {"id": "2", "governorate_name_ar": "الجيزة", "governorate_name_en": "Giza"},
  {
    "id": "3",
    "governorate_name_ar": "الأسكندرية",
    "governorate_name_en": "Alexandria"
  },
  {
    "id": "4",
    "governorate_name_ar": "الدقهلية",
    "governorate_name_en": "Dakahlia"
  },
  {
    "id": "5",
    "governorate_name_ar": "البحر الأحمر",
    "governorate_name_en": "Red Sea"
  },
  {
    "id": "6",
    "governorate_name_ar": "البحيرة",
    "governorate_name_en": "Beheira"
  },
  {"id": "7", "governorate_name_ar": "الفيوم", "governorate_name_en": "Fayoum"},
  {
    "id": "8",
    "governorate_name_ar": "الغربية",
    "governorate_name_en": "Gharbiya"
  },
  {
    "id": "9",
    "governorate_name_ar": "الإسماعلية",
    "governorate_name_en": "Ismailia"
  },
  {
    "id": "10",
    "governorate_name_ar": "المنوفية",
    "governorate_name_en": "Menofia"
  },
  {"id": "11", "governorate_name_ar": "المنيا", "governorate_name_en": "Minya"},
  {
    "id": "12",
    "governorate_name_ar": "القليوبية",
    "governorate_name_en": "Qaliubiya"
  },
  {
    "id": "13",
    "governorate_name_ar": "الوادي الجديد",
    "governorate_name_en": "New Valley"
  },
  {"id": "14", "governorate_name_ar": "السويس", "governorate_name_en": "Suez"},
  {"id": "15", "governorate_name_ar": "اسوان", "governorate_name_en": "Aswan"},
  {"id": "16", "governorate_name_ar": "اسيوط", "governorate_name_en": "Assiut"},
  {
    "id": "17",
    "governorate_name_ar": "بني سويف",
    "governorate_name_en": "Beni Suef"
  },
  {
    "id": "18",
    "governorate_name_ar": "بورسعيد",
    "governorate_name_en": "Port Said"
  },
  {
    "id": "19",
    "governorate_name_ar": "دمياط",
    "governorate_name_en": "Damietta"
  },
  {
    "id": "20",
    "governorate_name_ar": "الشرقية",
    "governorate_name_en": "Sharkia"
  },
  {
    "id": "21",
    "governorate_name_ar": "جنوب سيناء",
    "governorate_name_en": "South Sinai"
  },
  {
    "id": "22",
    "governorate_name_ar": "كفر الشيخ",
    "governorate_name_en": "Kafr Al sheikh"
  },
  {
    "id": "23",
    "governorate_name_ar": "مطروح",
    "governorate_name_en": "Matrouh"
  },
  {"id": "24", "governorate_name_ar": "الأقصر", "governorate_name_en": "Luxor"},
  {"id": "25", "governorate_name_ar": "قنا", "governorate_name_en": "Qena"},
  {
    "id": "26",
    "governorate_name_ar": "شمال سيناء",
    "governorate_name_en": "North Sinai"
  },
  {"id": "27", "governorate_name_ar": "سوهاج", "governorate_name_en": "Sohag"}
];

abstract class EndPoints {
  static const login = '/auth/login/';
  static const register = '/auth/register/';
  static const sendOTP = '/auth/otp-request/';
  static const changePassword = '/auth/reset-password/';
  static const properties = '/properties/';
  static const favorites = '/properties/fav/';
  static const categories = '/properties/categories/';
  static const seen = '/properties/seen/';
  static const userData = '/auth/user/update/';
  static const updateUserData = '/auth/user/update/';
  static const map = '/properties/map/';
  static const ads = '/ads/';
  static const nearest = '/nearbyproperties/';
  static const packages = '/payment/packages/';
  static const createInvoice = '/payment/createinvoice/';
  static const confirmTrx = '/payment/confirmtxn/';

}

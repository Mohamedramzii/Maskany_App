import '../../../core/app_resources/images.dart';

class ServicesModel {
  final String image;
  final String text;
  ServicesModel({
    required this.image,
    required this.text,
  });
}

List<ServicesModel> service = [
  ServicesModel(image: Images.icon1, text: ' سجل احصائيات الاعلان'),
  ServicesModel(image: Images.icon2, text: "البحث بمحتوي الإعلان"),
  ServicesModel(image: Images.icon3, text: 'البحث بالعقارات المباشر مع المالك'),
  ServicesModel(image: Images.icon4, text: 'استخدام خريطة مسكني علي الويب'),
  ServicesModel(image: Images.icon5, text: 'فلترة عقارات المالك'),
  ServicesModel(image: Images.icon6, text: 'خدمات اخري'),
  ServicesModel(image: Images.icon7, text: 'عرض المفضلة عبر الخريطة'),
  ServicesModel(image: Images.icon8, text: 'طلبات عقارية الي 20 طلب')
];

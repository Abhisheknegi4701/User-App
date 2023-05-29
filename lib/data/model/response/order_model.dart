import 'package:flutter_grocery/data/model/response/product_model.dart';
import 'package:flutter_grocery/data/model/response/userinfo_model.dart';

class OrderModel {
  int? id;
  int? userId;
  double? orderAmount;
  double? couponDiscountAmount;
  String? couponDiscountTitle;
  String? paymentStatus;
  String? orderStatus;
  double? totalTaxAmount;
  String? paymentMethod;
  String? transactionReference;
  int? deliveryAddressId;
  String? createdAt;
  String? updatedAt;
  int? checked;
  int? deliveryManId;
  double? deliveryCharge;
  String? orderNote;
  String? couponCode;
  String? orderType;
  int? branchId;
  int? timeSlotId;
  String? date;
  String? deliveryDate;
  int? detailsCount;
  UserInfoModel? customer;
  DeliveryMan? deliveryMan;
  DeliveryAddress? deliveryAddress;
  double? extraDiscount;

  OrderModel({
    this.id,
    this.userId,
    this.orderAmount,
    this.couponDiscountAmount ,
    this.couponDiscountTitle,
    this.paymentStatus,
    this.orderStatus,
    this.totalTaxAmount,
    this.paymentMethod,
    this.transactionReference,
    this.deliveryAddressId,
    this.createdAt,
    this.updatedAt,
    this.checked,
    this.deliveryManId,
    this.deliveryCharge,
    this.orderNote,
    this.couponCode,
    this.orderType,
    this.branchId,
    this.timeSlotId,
    this.date,
    this.deliveryDate,
    this.detailsCount,
    this.customer,
    this.deliveryMan,
    this.deliveryAddress,
    this.extraDiscount
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    orderAmount = json['order_amount'].toDouble();
    couponDiscountAmount = json['coupon_discount_amount'].toDouble();
    couponDiscountTitle = json['coupon_discount_title'];
    paymentStatus = json['payment_status'];
    orderStatus = json['order_status'];
    totalTaxAmount = json['total_tax_amount'].toDouble();
    paymentMethod = json['payment_method'];
    transactionReference = json['transaction_reference'];
    deliveryAddressId = json['delivery_address_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    checked = json['checked'];
    deliveryManId = json['delivery_man_id'];
    deliveryCharge = json['delivery_charge'].toDouble();
    orderNote = json['order_note'];
    couponCode = json['coupon_code'];
    orderType = json['order_type'];
    branchId = json['branch_id'];
    timeSlotId = json['time_slot_id'];
    date = json['date'];
    deliveryDate = json['delivery_date'];
    detailsCount = json['details_count'];
    customer = json['customer'] != null
        ? new UserInfoModel.fromJson(json['customer'])
        : null;
    deliveryMan = json['delivery_man'] != null
        ? new DeliveryMan.fromJson(json['delivery_man'])
        : null;
    deliveryAddress = json['delivery_address'] != null
        ? new DeliveryAddress.fromJson(json['delivery_address'])
        : null;
    if(json['extra_discount'] != null){
      try{
        extraDiscount = double.parse(json['extra_discount']);
      }catch(e){
        extraDiscount = json['extra_discount'];
      }
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['order_amount'] = this.orderAmount;
    data['coupon_discount_amount'] = this.couponDiscountAmount;
    data['coupon_discount_title'] = this.couponDiscountTitle;
    data['payment_status'] = this.paymentStatus;
    data['order_status'] = this.orderStatus;
    data['total_tax_amount'] = this.totalTaxAmount;
    data['payment_method'] = this.paymentMethod;
    data['transaction_reference'] = this.transactionReference;
    data['delivery_address_id'] = this.deliveryAddressId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['checked'] = this.checked;
    data['delivery_man_id'] = this.deliveryManId;
    data['delivery_charge'] = this.deliveryCharge;
    data['order_note'] = this.orderNote;
    data['coupon_code'] = this.couponCode;
    data['order_type'] = this.orderType;
    data['branch_id'] = this.branchId;
    data['time_slot_id'] = this.timeSlotId;
    data['date'] = this.date;
    data['delivery_date'] = this.deliveryDate;
    data['details_count'] = this.detailsCount;
    data['customer'] = this.customer!.toJson();
    data['delivery_man'] = this.deliveryMan!.toJson();
    data['delivery_address'] = this.deliveryAddress!.toJson();
    data['extra_discount'] = this.extraDiscount;
    return data;
  }
}

class DeliveryMan {
  int? _id;
  String? _fName;
  String? _lName;
  String? _phone;
  String? _email;
  String? _identityNumber;
  String? _identityType;
  String? _identityImage;
  String? _image;
  String? _password;
  String? _createdAt;
  String? _updatedAt;
  String? _authToken;
  String? _fcmToken;
  List<Rating>? _rating;

  DeliveryMan(
      {required int id,
        required String fName,
        required String lName,
        required String phone,
        required String email,
        required String identityNumber,
        required String identityType,
        required String identityImage,
        required String image,
        required String password,
        required String createdAt,
        required String updatedAt,
        required String authToken,
        required String fcmToken,
        required List<Rating> rating}) {
    this._id = id;
    this._fName = fName;
    this._lName = lName;
    this._phone = phone;
    this._email = email;
    this._identityNumber = identityNumber;
    this._identityType = identityType;
    this._identityImage = identityImage;
    this._image = image;
    this._password = password;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
    this._authToken = authToken;
    this._fcmToken = fcmToken;
    this._rating = rating;
  }

  int? get id => _id;
  String? get fName => _fName;
  String? get lName => _lName;
  String? get phone => _phone;
  String? get email => _email;
  String? get identityNumber => _identityNumber;
  String? get identityType => _identityType;
  String? get identityImage => _identityImage;
  String? get image => _image;
  String? get password => _password;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get authToken => _authToken;
  String? get fcmToken => _fcmToken;
  List<Rating>? get rating => _rating;

  DeliveryMan.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _fName = json['f_name'];
    _lName = json['l_name'];
    _phone = json['phone'];
    _email = json['email'];
    _identityNumber = json['identity_number'];
    _identityType = json['identity_type'];
    _identityImage = json['identity_image'];
    _image = json['image'];
    _password = json['password'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _authToken = json['auth_token'];
    _fcmToken = json['fcm_token'];
    if (json['rating'] != null) {
      _rating = [];
      json['rating'].forEach((v) {
        _rating!.add(new Rating.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['f_name'] = this._fName;
    data['l_name'] = this._lName;
    data['phone'] = this._phone;
    data['email'] = this._email;
    data['identity_number'] = this._identityNumber;
    data['identity_type'] = this._identityType;
    data['identity_image'] = this._identityImage;
    data['image'] = this._image;
    data['password'] = this._password;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    data['auth_token'] = this._authToken;
    data['fcm_token'] = this._fcmToken;
    data['rating'] = this._rating!.map((v) => v.toJson()).toList();
    return data;
  }
}

class DeliveryAddress {
  int? _id;
  String? _addressType;
  String? _contactPersonNumber;
  String? _address;
  String? _latitude;
  String? _longitude;
  String? _createdAt;
  String? _updatedAt;
  int? _userId;
  String? _contactPersonName;

  DeliveryAddress(
      {required int id,
        required String addressType,
        required String contactPersonNumber,
        required String address,
        required String latitude,
        required String longitude,
        required String createdAt,
        required String updatedAt,
        required int userId,
        required String contactPersonName}) {
    this._id = id;
    this._addressType = addressType;
    this._contactPersonNumber = contactPersonNumber;
    this._address = address;
    this._latitude = latitude;
    this._longitude = longitude;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
    this._userId = userId;
    this._contactPersonName = contactPersonName;
  }

  int? get id => _id;
  String? get addressType => _addressType;
  String? get contactPersonNumber => _contactPersonNumber;
  String? get address => _address;
  String? get latitude => _latitude;
  String? get longitude => _longitude;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  int? get userId => _userId;
  String? get contactPersonName => _contactPersonName;

  DeliveryAddress.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _addressType = json['address_type'];
    _contactPersonNumber = json['contact_person_number'];
    _address = json['address'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _userId = json['user_id'];
    _contactPersonName = json['contact_person_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['address_type'] = this._addressType;
    data['contact_person_number'] = this._contactPersonNumber;
    data['address'] = this._address;
    data['latitude'] = this._latitude;
    data['longitude'] = this._longitude;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    data['user_id'] = this._userId;
    data['contact_person_name'] = this._contactPersonName;
    return data;
  }
}
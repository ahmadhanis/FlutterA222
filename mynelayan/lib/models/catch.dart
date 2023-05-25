class Catch {
  String? catchId;
  String? userId;
  String? catchName;
  String? catchType;
  String? catchDesc;
  String? catchPrice;
  String? catchQty;
  String? catchLat;
  String? catchLong;
  String? catchState;
  String? catchLocality;
  String? catchDate;

  Catch(
      {this.catchId,
      this.userId,
      this.catchName,
      this.catchType,
      this.catchDesc,
      this.catchPrice,
      this.catchQty,
      this.catchLat,
      this.catchLong,
      this.catchState,
      this.catchLocality,
      this.catchDate});

  Catch.fromJson(Map<String, dynamic> json) {
    catchId = json['catch_id'];
    userId = json['user_id'];
    catchName = json['catch_name'];
    catchType = json['catch_type'];
    catchDesc = json['catch_desc'];
    catchPrice = json['catch_price'];
    catchQty = json['catch_qty'];
    catchLat = json['catch_lat'];
    catchLong = json['catch_long'];
    catchState = json['catch_state'];
    catchLocality = json['catch_locality'];
    catchDate = json['catch_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['catch_id'] = catchId;
    data['user_id'] = userId;
    data['catch_name'] = catchName;
    data['catch_type'] = catchType;
    data['catch_desc'] = catchDesc;
    data['catch_price'] = catchPrice;
    data['catch_qty'] = catchQty;
    data['catch_lat'] = catchLat;
    data['catch_long'] = catchLong;
    data['catch_state'] = catchState;
    data['catch_locality'] = catchLocality;
    data['catch_date'] = catchDate;
    return data;
  }
}
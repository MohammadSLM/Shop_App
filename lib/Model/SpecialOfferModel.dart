class SpecialOfferModel{
  var _id;
  String _product_Name;
  var _price;
  var _off_Price;
  var _off_Percent;

  SpecialOfferModel(this._id, this._product_Name, this._price, this._off_Price,
      this._off_Percent);

  get offPercent => _off_Percent;

  get offPrice => _off_Price;

  get price => _price;

  String get productName => _product_Name;

  get id => _id;
}
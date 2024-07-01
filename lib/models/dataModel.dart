class DataModels {
  String _cityname;
  var _lati;
  var _long;
  String _main;
  String Description;
  var _temp;
  var _temp_max;
  var _temp_min;
  var _pressure;
  var _humidity;
  var windSpeed;
  var _dateTime;
  var _country;
  var _sunrise;
  var _sunset;

  //getter
  get humidity => this._humidity;
  get getWindSpeed => this.windSpeed;
  get dateTime => this._dateTime;
  get country => this._country;
  get sunrise => this._sunrise;
  get sunset => this._sunset;
  set sunset(value) => this._sunset = value;
  String get cityname => this._cityname;
  get long => this._long;
  get lati => this._lati;
  get main => this._main;
  get getDescription => this.Description;
  get temp => this._temp;
  get temp_max => this._temp_max;
  get temp_min => this._temp_min;
  get pressure => this._pressure;

  //constractor
  DataModels(
      this._cityname,
      this._lati,
      this.Description,
      this._long,
      this._main,
      this._pressure,
      this._temp,
      this._temp_max,
      this._temp_min,
      this._country,
      this._dateTime,
      this._humidity,
      this._sunrise,
      this._sunset,
      this.windSpeed);
}

final locationName = ['Tehran', 'London', 'New York'];

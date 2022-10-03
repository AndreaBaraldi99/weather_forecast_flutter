class Daily {
  List<String>? time;
  List<int>? weathercode;
  List<double>? temperature2mMax;
  List<double>? temperature2mMin;
  List<String>? sunrise;
  List<String>? sunset;
  List<int>? precipitationSum;
  List<double>? windspeed10mMax;

  Daily(
      {this.time,
      this.weathercode,
      this.temperature2mMax,
      this.temperature2mMin,
      this.sunrise,
      this.sunset,
      this.precipitationSum,
      this.windspeed10mMax});

  Daily.fromJson(Map<String, dynamic> json) {
    time = json['time'].cast<String>();
    weathercode = json['weathercode'].cast<int>();
    temperature2mMax = json['temperature_2m_max'].cast<double>();
    temperature2mMin = json['temperature_2m_min'].cast<double>();
    sunrise = json['sunrise'].cast<String>();
    sunset = json['sunset'].cast<String>();
    precipitationSum = json['precipitation_sum'].cast<int>();
    windspeed10mMax = json['windspeed_10m_max'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['weathercode'] = this.weathercode;
    data['temperature_2m_max'] = this.temperature2mMax;
    data['temperature_2m_min'] = this.temperature2mMin;
    data['sunrise'] = this.sunrise;
    data['sunset'] = this.sunset;
    data['precipitation_sum'] = this.precipitationSum;
    data['windspeed_10m_max'] = this.windspeed10mMax;
    return data;
  }
}

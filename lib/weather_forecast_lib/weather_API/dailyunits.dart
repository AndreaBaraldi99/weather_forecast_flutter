class DailyUnits {
  String? time;
  String? weathercode;
  String? temperature2mMax;
  String? temperature2mMin;
  String? sunrise;
  String? sunset;
  String? precipitationSum;
  String? windspeed10mMax;

  DailyUnits(
      {this.time,
      this.weathercode,
      this.temperature2mMax,
      this.temperature2mMin,
      this.sunrise,
      this.sunset,
      this.precipitationSum,
      this.windspeed10mMax});

  DailyUnits.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    weathercode = json['weathercode'];
    temperature2mMax = json['temperature_2m_max'];
    temperature2mMin = json['temperature_2m_min'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
    precipitationSum = json['precipitation_sum'];
    windspeed10mMax = json['windspeed_10m_max'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['time'] = time;
    data['weathercode'] = weathercode;
    data['temperature_2m_max'] = temperature2mMax;
    data['temperature_2m_min'] = temperature2mMin;
    data['sunrise'] = sunrise;
    data['sunset'] = sunset;
    data['precipitation_sum'] = precipitationSum;
    data['windspeed_10m_max'] = windspeed10mMax;
    return data;
  }
}

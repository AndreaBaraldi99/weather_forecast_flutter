class Daily {
  List<String>? time;
  List<double>? weathercode;
  List<double>? temperature2mMax;
  List<double>? temperature2mMin;
  List<String>? sunrise;
  List<String>? sunset;
  List<int>? precipitationSum;
  List<double>? windspeed10mMax;
  late List<String> weatherIcon;

  Daily({
    this.time,
    this.weathercode,
    this.temperature2mMax,
    this.temperature2mMin,
    this.sunrise,
    this.sunset,
    this.precipitationSum,
    this.windspeed10mMax,
  });

  Daily.fromJson(Map<String, dynamic> json) {
    time = json['time'].cast<String>();
    weathercode = json['weathercode'].cast<double>();
    temperature2mMax = json['temperature_2m_max'].cast<double>();
    temperature2mMin = json['temperature_2m_min'].cast<double>();
    sunrise = json['sunrise'].cast<String>();
    sunset = json['sunset'].cast<String>();
    precipitationSum = json['precipitation_sum'].cast<int>();
    windspeed10mMax = json['windspeed_10m_max'].cast<double>();
    weatherIcon = List.empty(growable: true);
    createWeatherIcon();
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

  createWeatherIcon() {
    for (int i = 0; i < weathercode!.length; i++) {
      String icon;
      switch (weathercode![i].toInt()) {
        case 0:
          icon = "☀️";
          break;
        case 1:
        case 2:
          icon = "🌤️";
          break;
        case 3:
          icon = "☁️";
          break;
        case 45:
        case 48:
          icon = "🌫️";
          break;
        case 51:
        case 53:
        case 55:
        case 56:
        case 57:
          icon = "🌦️";
          break;
        case 61:
        case 63:
        case 65:
        case 66:
        case 67:
        case 80:
        case 81:
        case 82:
          icon = "🌧️";
          break;
        case 71:
        case 73:
        case 75:
        case 77:
        case 85:
        case 86:
          icon = "❄️";
          break;
        case 95:
        case 96:
        case 99:
          icon = "🌩️";
          break;
        default:
          icon = "No info";
          break;
      }
      weatherIcon.add(icon);
    }
  }
}

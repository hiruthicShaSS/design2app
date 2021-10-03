import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

FaIcon getIcon(String data) {
  if (data.toLowerCase().contains("heavy rain"))
    return FaIcon(FontAwesomeIcons.cloudRain, color: Colors.grey);
  else if (data.toLowerCase().contains("rain"))
    return FaIcon(FontAwesomeIcons.cloudShowersHeavy, color: Colors.grey);
  else if (data.toLowerCase().contains("cloud"))
    return FaIcon(FontAwesomeIcons.cloud, color: Colors.white);
  else if (data.toLowerCase().contains("sun"))
    return FaIcon(FontAwesomeIcons.sun, color: Colors.orange);
  else if (data.toLowerCase().contains("sky"))
    return FaIcon(FontAwesomeIcons.cloudSun, color: Colors.blue);

  return FaIcon(FontAwesomeIcons.borderNone);
}

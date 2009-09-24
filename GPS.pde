#ifdef ENABLE_GPS

/**
 * gpsdump
 * Derived from the example code included in the TinyGPS library
 */
void gpsdump(TinyGPS &gps)
{
  long lat, lon;
  float flat, flon;
  unsigned long age, date, time, chars;
  int year;
  byte month, day, hour, minute, second, hundredths;
  unsigned short sentences, failed;

  gps.get_position(&lat, &lon, &age);
  HOST.print("Lat/Long(10^-5 deg): "); HOST.print(lat); HOST.print(", "); HOST.print(lon); 
  HOST.print(" Fix age: "); HOST.print(age); HOST.println("ms.");
  
  feedgps(); // If we don't feed the gps during this long routine, we may drop characters and get checksum errors

  gps.f_get_position(&flat, &flon, &age);
  HOST.print("Lat/Long(float): "); printFloat(flat, 5); HOST.print(", "); printFloat(flon, 5);
  HOST.print(" Fix age: "); HOST.print(age); HOST.println("ms.");

  feedgps();

  gps.get_datetime(&date, &time, &age);
  HOST.print("Date(ddmmyy): "); HOST.print(date);
  HOST.print(" Time(hhmmsscc): "); HOST.print(time);
  HOST.print(" Fix age: "); HOST.print(age); HOST.println("ms.");

  feedgps();

  gps.crack_datetime(&year, &month, &day, &hour, &minute, &second, &hundredths, &age);
  HOST.print("Date: "); HOST.print(static_cast<int>(month));
  HOST.print("/"); HOST.print(static_cast<int>(day));
  HOST.print("/"); HOST.print(year);
  HOST.print("  Time: "); HOST.print(static_cast<int>(hour));
  HOST.print(":"); HOST.print(static_cast<int>(minute));
  HOST.print(":"); HOST.print(static_cast<int>(second));
  HOST.print("."); HOST.print(static_cast<int>(hundredths));
  HOST.print("  Fix age: ");  HOST.print(age); HOST.println("ms.");
  
  feedgps();

  HOST.print("Alt(cm): "); HOST.print(gps.altitude());
  HOST.print(" Course(10^-2 deg): "); HOST.print(gps.course());
  HOST.print(" Speed(10^-2 knots): "); HOST.print(gps.speed());
  HOST.println();
  HOST.print("Alt(float): "); printFloat(gps.f_altitude());
  HOST.print(" Course(float): "); printFloat(gps.f_course());
  HOST.println();
  HOST.print("Speed(knots): "); printFloat(gps.f_speed_knots());
  HOST.print(" (mph): ");  printFloat(gps.f_speed_mph());
  HOST.print(" (mps): "); printFloat(gps.f_speed_mps());
  HOST.print(" (kmph): "); printFloat(gps.f_speed_kmph());
  HOST.println();

  feedgps();

  gps.stats(&chars, &sentences, &failed);
  HOST.print("Stats: characters: "); HOST.print(chars);
  HOST.print(" sentences: "); HOST.print(sentences);
  HOST.print(" failed checksum: "); HOST.println(failed);
}

/**
 * feedgps
 */
bool feedgps()
{
  while (GPS.available())
  {
    if (gps.encode(GPS.read()))
      return true;
  }
  return false;
}

#endif

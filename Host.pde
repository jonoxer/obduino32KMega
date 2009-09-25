#ifdef MEGA

/**
 * processHostCommands
 */
void processHostCommands()
{
  // Check for state change from the front panel button
  if(logActive && !digitalRead(LOG_LED))
  {
    logActive = 0;
    digitalWrite(VDIP_STATUS_LED, LOW);
    VDIP.print("CLF ARDUINO.TXT");
    VDIP.print(13, BYTE);
    HOST.println("Stop logging");
  }
  if( !logActive && digitalRead(LOG_LED))
  {
    logActive = 1;
    digitalWrite(VDIP_STATUS_LED, HIGH);
    VDIP.print("OPW ARDUINO.TXT");
    VDIP.print(13, BYTE);
    HOST.println("Start logging");
  }
  
  // Check for commands from the host
  if( HOST.available() > 0)
  {
    char readChar = HOST.read();

    if(readChar == '1')
    {                                       // Open file and start logging
      HOST.println("Start logging");
      logActive = 1;
      digitalWrite(VDIP_STATUS_LED, HIGH);
      digitalWrite(LOG_LED, HIGH);
      VDIP.print("OPW ARDUINO.TXT");
      VDIP.print(13, BYTE);
    } else if( readChar == '2') {           // Stop logging and close file
      HOST.println("Stop logging");
      if(digitalRead(VDIP_RTS_PIN) == HIGH)
      {
        HOST.println("VDIP BUFFER FULL");
      }
      logActive = 0;
      digitalWrite(VDIP_STATUS_LED, LOW);
      digitalWrite(LOG_LED, LOW);
      VDIP.print("CLF ARDUINO.TXT");
      VDIP.print(13, BYTE);
    } else if (readChar == '3'){            // Display the file
      HOST.println("Reading file");
      VDIP.print("RD ARDUINO.TXT");
      VDIP.print(13, BYTE);
    } else if (readChar == '4'){            // Delete the file
      HOST.println("Deleting file");
      VDIP.print("DLF ARDUINO.TXT");
      VDIP.print(13, BYTE);
    } else if (readChar == '5'){            // Directory listing
      HOST.println("Directory listing");
      VDIP.print("DIR");
      VDIP.print(13, BYTE);  
    } else if (readChar == '6'){            // Reset the VDIP  
      HOST.print(" * Initialising flash storage   ");
      pinMode(VDIP_RESET, OUTPUT);
      digitalWrite(VDIP_RESET, LOW);
      delay( 100 );
      digitalWrite(VDIP_RESET, HIGH);
      delay( 100 );
      VDIP.print("IPA");  // Sets the VDIP to ASCII mode
      VDIP.print(13, BYTE);
      HOST.println("[OK]");
    } else {                                // HELP!
      HOST.print("Unrecognised command '");
      HOST.print(readChar);
      HOST.println("'");
      HOST.println("1 - Start logging");
      HOST.println("2 - Stop logging");
      HOST.println("3 - Display logfile");
      HOST.println("4 - Delete logfile");
      HOST.println("5 - Directory listing");
      HOST.println("6 - Reset VDIP module");
    }
  }
}

#endif

void hostPrint( char* message )
{
  #ifdef MEGA
  HOST.print(message);
  #endif
}
void hostPrintLn( char* message )
{
  #ifdef MEGA
  HOST.println(message);
  #endif
}

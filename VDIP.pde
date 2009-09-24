#ifdef ENABLE_VDIP

/**
 * initVdip
 */
void initVdip()
{
  // Set up the Vinculum flash storage device
  HOST.print(" * Initialising flash storage   ");
  pinMode(VDIP_STATUS_LED, OUTPUT);
  digitalWrite(VDIP_STATUS_LED, HIGH);

  pinMode(VDIP_WRITE_LED, OUTPUT);
  digitalWrite(VDIP_WRITE_LED, LOW);

  pinMode(VDIP_RTS_PIN, INPUT);

  pinMode(VDIP_RESET, OUTPUT);
  digitalWrite(VDIP_RESET, LOW);
  digitalWrite(VDIP_STATUS_LED, HIGH);
  digitalWrite(VDIP_WRITE_LED, HIGH);
  delay( 100 );
  digitalWrite(VDIP_RESET, HIGH);
  delay( 100 );
  VDIP.begin(9600);      // Port for connection to Vinculum flash memory module
  VDIP.print("IPA");     // Sets the VDIP to ASCII mode
  VDIP.print(13, BYTE);

  digitalWrite(VDIP_STATUS_LED, LOW);
  digitalWrite(VDIP_WRITE_LED, LOW);
  HOST.println("[OK]");
}


/**
 * processVdipBuffer
 */
void processVdipBuffer()
{
  byte incomingByte;
  
  while( VDIP.available() > 0 )
  {
    incomingByte = VDIP.read();
    if( incomingByte == 13 ) {
      HOST.println();
    }
    HOST.print( incomingByte, BYTE );
  }
}

#endif

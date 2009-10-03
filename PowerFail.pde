#ifdef ENABLE_PWRFAILDETECT
/**
 * Copyright 2009 Jonathan Oxer <jon@oxer.com.au>
 * Distributed under the same terms as OBDuino
 */

/**
 * powerFail
 * ISR attached to falling-edge interrupt 0 on digital pin 2
 */
void powerFail()
{
  VDIP.print("CLF OBDUINO.CSV");
  VDIP.print(13, BYTE);
  digitalWrite(LOG_LED, LOW);
  logActive = 0;
}

#endif

#ifdef ENABLE_PWRFAILDETECT

/**
 * powerFail
 * ISR attached to falling-edge interrupt 0 on digital pin 2
 */
void powerFail()
{
  HOST.println();
  HOST.println("     POWER FAIL!     ");
  /* while(1 == 1)
  {
    HOST.println(".");
  } */
}

#endif

//-------------------------------------------------------------------------------------//
// Library for Display data on 7-Segment by Timer 2 interrupt every 5 ms
//-------------------------------------------------------------------------------------//
#include <avr/io.h>	
#include <avr/interrupt.h>
#include <avr/signal.h>
#include <in_out.h>
unsigned char LED=0;
unsigned char LED_cnt;

SIGNAL (SIG_OVERFLOW2) 	// Interval 10 ms
{
	TCNT2 = 178;			// Reload interval 10 ms(TCNT2 = 178)  
	LED_cnt++;				// Increment Counter
	if (LED_cnt>30)		// Check Counter 10 ms X 30 
	{
		LED_cnt=0;			// Clear Counter
		if (LED==1) 		// Check LED1 Enable
		{
		  	toggle_c(5);	
		}
		else if (LED==2) 	// Check LED2 Enable
		{
		 	toggle_d(1);
		}
		else if (LED==3)	// Check LED1 and LED2 Enable
		{
			toggle_c(5);
			toggle_d(1);
		}
	}

}
	
void interval_init() // Config. and Start up timer 0 
{
   TCCR2 |= (1<<CS22)|(1<<CS21)|(1<<CS20); 	// Prescaler 1024,16 MHz,1 MC = 1024/16M = 64us/count 
	TIFR |= 1<<TOV2; 	//Clear TOV2 / clear
	TIMSK |= 1<<TOIE2; 		//Enable Timer2 Overflow Interrupt
	TCNT2 = 178;				// Interval 10 ms  	
   sei();						// Enable all interrupt
}

void led1_on()				// Start Blinking LED1
{
	interval_init();
	LED |= (1<<0) ;
}
void led1_off()			// Stop Blinking LED1
{
	LED &= ~_BV(0);
}
void led2_on()
{
	interval_init();		// Start Blinking LED2
	LED |= (1<<1) ;
}
void led2_off()
{
	LED &= ~_BV(1);		// Stop Blinking LED2
}

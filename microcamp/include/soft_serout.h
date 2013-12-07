#include <avr/io.h>
#include <in_out.h>
#ifndef _soft_serout_
#define _soft_serout_

#define PRESCALER_1		(1<<CS20)					// (1/16M) 0.0625 us per MC
#define PRESCALER_8		(1<<CS21)					// (8/16M) 0.5 us per MC
#define PRESCALER_32	(1<<CS21) | (1<<CS20)		// (32/16M) 2 us per MC
#define PRESCALER_64	(1<<CS22)					// (64/16M)	4 us per MC
#define OFFSET_DELAY1 	20							// for out function used 20 us

#define OFFSET_DELAY2 	18							// for out function used 20 us
unsigned int base=0;
unsigned char base_start_rcv=0;
unsigned char TCCR2_cal=0;
unsigned int base;
unsigned int baud=9600;

void soft_serout_init(char tx,unsigned long baud_) // Config. and Start up timer 2 
{
	unsigned long tick=0;
	out_c(tx,1);
	if(baud_<=4800)
	{	
		tick = ((1000000/baud_)-OFFSET_DELAY1)/4; 	// Calculate Delay for baudrate
		TCCR2_cal = PRESCALER_64;  
	}
	else if(baud_>4800 && baud_<=9600)
	{	
		tick = ((1000000/baud_)-OFFSET_DELAY2)/2;	// Calculate Delay for baudrate
		TCCR2_cal = PRESCALER_32;  
	}

	TCCR2 = 0;						// Stop timer
	TIFR |= 1<<TOV2; 				// Ensure Clear Overflow flag
	base = 255-tick;
	base_start_rcv = 255-(tick/2);	 		
}

// Delay For baudrate

void delay_baud(unsigned int _tick)
{
	TCNT2 = _tick;	 				// Load Prescaler form calculate
	TCCR2 = TCCR2_cal; 				// Load interval
	while(!(TIFR & (1<<TOV2)));		// Wait until count success
	TIFR |= 1<<TOV2;				// Ensure Clear Overflow flag
	TCCR2 = 0;						// Stop timer 2
}

// Send Data  1 Byte
void serout_byte(char tx,unsigned char dat)
{
	int i;
	out_c(tx,0);					// start bit
	delay_baud(base);				// Delay for start bit	
	for(i=0;i<8;i++)
	{
		out_c(tx,dat & 0x01);		// Send data bit
		delay_baud(base);			// Delay for calculate base
		dat=dat>>1;					// Shift for next bit
	}
	out_c(tx,1);					// stop bit
	delay_baud(base); 				// Delay for stop bit	
}

// Send More Than 1 byte 

void serout_text(char tx,unsigned char *p)
{
	while(*p)
	{ serout_byte(tx,*p++); }
}

#endif

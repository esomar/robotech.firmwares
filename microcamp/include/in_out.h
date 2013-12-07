#include <avr/io.h>	
#ifndef _IN_OUT_
#define _IN_OUT_

#define toggle_b(x)     DDRB |= _BV(x);	PORTB ^= _BV(x);
#define toggle_c(x)     DDRC |= _BV(x);	PORTC ^= _BV(x);
#define toggle_d(x)     DDRD |= _BV(x);	PORTD ^= _BV(x);
char in_b(char _bit)
{
	DDRB &= ~(1<<_bit);
	return((PINB & _BV(_bit))>>_bit);	
}
char in_c(char _bit)
{
	DDRC &= ~(1<<_bit);
	return((PINC & _BV(_bit))>>_bit);	
}
char in_d(char _bit)
{
	DDRD &= ~(1<<_bit);
	return((PIND & _BV(_bit))>>_bit);	
}


void out_b(char _bit,char _dat)
{
	DDRB |= _BV(_bit);
	if(_dat)
		PORTB |= _BV(_bit);
	else
		PORTB &= ~_BV(_bit);

}
void out_c(char _bit,char _dat)
{
	DDRC |= _BV(_bit);
	if(_dat)
		PORTC |= _BV(_bit);
	else
		PORTC &= ~_BV(_bit);
}
void out_d(char _bit,char _dat) 
{
	DDRD |= _BV(_bit);
	if(_dat)
		PORTD |= _BV(_bit);
	else
		PORTD &= ~_BV(_bit);
}

#endif





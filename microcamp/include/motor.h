/* Hardware Configuration

	MOTOR1
	- PD7 Connect to 1B 	port 
	- PD6 Connect to 1A	port
	- PB1 Connect to 1E	port

	MOTOR2
	- PB0 Connect to 2A port
	- PD5 Connect to 2B port
	- PB2 Connect to 2E port 

*/
#include <avr/io.h>						
#include <avr/signal.h>
#include <avr/interrupt.h>
#include <in_out.h>
#define ALL 3											// Clear all motor
#define all 3											// Clear all motor
unsigned char _duty1=0,_duty2=0; 				// duty cycle variable
char pwm_ini =0;										// Flag for check initial ?	

SIGNAL (SIG_OVERFLOW1) // Interval 1 ms
{
	OCR1AL = _duty1; 									// Duty Cycle 1 Read
	OCR1BL = _duty2;									// Duty Cycle 2 Read	
}

void pwm_init()
{
	TCCR1A |= (1<<WGM10);
	TCCR1B = (1<<CS12)|(1<<CS10)|(1<<WGM12);	// Set Prescaler
//	TCCR1B = (1<<CS12)|(1<<WGM12);				// Set Prescaler
	TIFR |= 1<<TOV1; 									//Clear TOV0 / clear
	TIMSK |= 1<<TOIE1; 								//Enable Timer0 Overflow Interrupt
	//timer_enable_int(_BV(TOIE1));
	sei();
}
void pwm(char channel,unsigned int duty)
{
	duty = (duty*255)/100;					// Convert 0-100 to 0-255
	if(pwm_ini==0)								// PWM Initial ? 
	{
		pwm_init();								// If no Intitial it
		pwm_ini=1;								// show now initial
	}
	if(channel==2)		
	{
		TCCR1A |= _BV(COM1A1);
		DDRB |= _BV(PB1);
		OCR1AL = duty;
		_duty1 = duty;
	}
	else if(channel==1)
	{
		TCCR1A |= _BV(COM1B1);
		DDRB |= _BV(PB2);
		OCR1BL = duty;
		_duty2 = duty;
	}
	else if(channel==3)		
	{
		TCCR1A |= _BV(COM1A1);
		DDRB |= _BV(PB1);
		OCR1AL = duty;
		_duty1 = duty;
		TCCR1A |= _BV(COM1B1);
		DDRB |= _BV(PB2);
		OCR1BL = duty;
		_duty2 = duty;
	}

}
void motor(char _channel,int _power)
{
	if(_power>0)
	{
		pwm(_channel,_power);
		if(_channel==2)
		{
			out_d(7,1);		
			out_d(6,0);
		}
		else if(_channel==1)
		{
			out_d(5,0);		
			out_b(0,1);
		}
	}
	else
	{
		pwm(_channel,abs(_power));
		if(_channel==2)
		{	
			out_d(7,0);
			out_d(6,1);
		}
		else if(_channel==1)
		{
			out_d(5,1);
			out_b(0,0);
		}	
	
	}
}
void motor_stop(char _channel)
{
	pwm(_channel,100);
	if(_channel==2 ||_channel==3)
	{
		out_d(7,0);		
		out_d(6,0);
	}
	if(_channel==1||_channel==3)
	{
		out_d(5,0);		
		out_b(0,0);
	}

	
}
void motor_off()
{
		pwm(3,0);
		out_d(7,0);		
		out_d(6,0);
		out_d(5,0);		
		out_b(0,0);
}
void forward(int speed)
{
	motor(1,speed);
	motor(2,speed);
}
void backward(int speed)
{
	motor(1,speed*-1);
	motor(2,speed*-1);
}
void s_left(int speed)
{
	motor(1,speed);
	motor(2,speed*-1);
}
void s_right(int speed)
{
	motor(1,speed*-1);
	motor(2,speed);
}


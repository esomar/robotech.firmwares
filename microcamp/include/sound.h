#include <avr/io.h>	
#include <in_out.h>
#include <sleep.h>
void delay_sound(unsigned int ms)
{
	unsigned int i,j;
	for(i=0;i<ms;i++)
		for(j=0;j<200;j++);
}

void sound(int freq,int time)
{
	int dt=0,m=0;	// Keep value and 
    dt = 5000/freq;   	// Keep active logic delay
	time = (5*time)/dt;	// Keep counter for generate sound
	for(m=0;m<time;m++) // Loop for generate sound(Toggle logic P0.12)   
	{
        out_d(4,1);
		delay_sound(dt);	// Delay for sound	
        out_d(4,0);
		delay_sound(dt);			// Delay for sound
	}		
}
void sound_cnt(unsigned char cnt,int freq,int time)
{
	unsigned char i;
	for (i=0;i<cnt;i++)	
	{
		sound(freq,time);
		sleep(300);
	}
}


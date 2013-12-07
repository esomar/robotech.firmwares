#ifndef _sleep_
#define _sleep_

void sleep(unsigned int ms)
{
	unsigned int i,j;
	for(i=0;i<ms;i++)
		for(j=0;j<795;j++);
}

#endif

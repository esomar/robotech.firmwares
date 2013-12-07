
unsigned int analog(unsigned char channel)
{
	unsigned int adc_val;
	ADMUX = 0x40; 
	ADMUX |= channel;	// Sigle end mode
	ADCSRA = 0xC6;
	while((ADCSRA & (1<<ADSC)));
	adc_val = ADCL; 
	adc_val += (ADCH*256);
	return(adc_val);
}


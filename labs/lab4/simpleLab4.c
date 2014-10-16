#include <msp430g2553.h>

typedef	unsigned short int16;

int16 func(int16 w, int16 x, int16 y, int16 z);

void main() {

	int16	a,b,c,d,e;

	a=1;
	b=2;
	c=3;
	d=4;

	while(1) {

		e = func(a,b,c,d);
		d = e+5;
		c = d+1;
		b = c+1;
		a = b+1;
	}
}


int16 func(int16 w, int16 x, int16 y, int16 z) {

	int16 sum;

	sum = w+x+y+z;
	sum = sum >> 2;

	return(sum);

}
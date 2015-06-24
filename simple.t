def turnandgo(turnvar, govar) {
	TURN turnvar;
	GO govar;
}

var x;
x = 0;

while (x <  +90) {
	x = x + 4;
	if (x < 45 && true) {
		turnandgo(2*x, 50);
		{
			var x;
			x = 0;
		}
	}
}

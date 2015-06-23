int x;
x = 0;

while x < 90 do {
	x = x + 4;
	if (x < 45 && true) then {
		TURN 2*x;
		GO 50;
	}
}
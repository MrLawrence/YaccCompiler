PROCEDURE square(size, angle)
BEGIN
GO size; TURN angle; 
GO size; TURN angle; 
GO size; TURN angle; 
GO size; TURN angle; 
END
VAR x;
x = 50;
square(x, x+40);
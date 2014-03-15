PI-Approximator
===============

A small flash application that approximates PI using randomly placed points on a circle.

The method used is the following: 
Draw a circle with radius 1, then draw an exactly fitting square around it. The area of this square is 4. The area of the circle is Pi (by definition).
Now you start placing random dots in the square. For each dot we can easily determine wether or not it's in the circle. The chance that such a dot will fall inside the circle is Pi/4.

So after placing a couple of million of those dots, we count the number of dots that ended up in the circle, and divide that by the total amount of dots. So now we can calculate the chance that a dot falls in the circle:

DotsInCircle / TotalDots = Pi / 4

And we can see that:
Pi = 4 * DotsInCircle / TotalDots

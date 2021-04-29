m = 5.6;
x = 0;
y = 0;
v = 0;
f = 0;
steering = 0;
heading = 0;
dt = 0.01;
input_f = 150;
input_steering = 150;

f = (input_f - 150)*2/3;
v = v + f*dt/m - 5*v*dt/m - 0.1*v^2*dt/m;

steering = (input_steering - 150)*0.45/50;
heading = heading + v*dt*tan(steering)/0.335;

x = x + v*dt*cos(heading);
y = y + v*dt*sin(heading);
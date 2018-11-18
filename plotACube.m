function h = plotACube()

figure(1);
format compact 
h(1) = axes('Position',[0.2 0.2 0.6 0.6]);
vert = [1 1 -1; 
        -1 1 -1; 
        -1 1 1; 
        1 1 1; 
        -1 -1 1;
        1 -1 1; 
        1 -1 -1;
        -1 -1 -1];

fac = [1 2 3 4; 
       4 3 5 6; 
       6 7 8 5; 
       1 2 8 7; 
       6 7 1 4; 
       2 3 5 8];

h = patch('Faces',fac,'Vertices',vert,'FaceColor','b');  % patch function
axis([-10, 10, -10, 10, -10, 10]);
axis equal;
material metal;
alpha('color');
alphamap('rampdown');
view(3);
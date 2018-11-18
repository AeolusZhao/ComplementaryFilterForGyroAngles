function p = plotCamera()

[verts, faces, cindex] = teapotGeometry;
figure;
p = patch('Faces',faces,'Vertices',verts,'FaceVertexCData',cindex,'FaceColor','interp');

view(-151,30)     % change the orientation
axis equal off    % make the axes equal and invisible

% p.FaceAlpha = 1;           % remove the transparency
% p.FaceColor = 'interp';    % set the face colors to be interpolated
% p.LineStyle = 'none';      % remove the lines
% colormap(copper)           % change the colormap
% 
% l = light('Position',[-0.4 0.2 0.9],'Style','infinite');

lighting gouraud
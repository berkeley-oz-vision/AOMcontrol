function CFG = TCA_RedGreenAlignment_gui()

% Get experimental parameters (CFG).

try
    load('lastTCA_RedGreenAlignment_CFG.mat');
catch
    CFG.initials = '';
    CFG.pixperdeg = 565;
    CFG.presentdur = 1; 
    CFG.stimshape ='Square';
    CFG.stimsize = 20;
    CFG.vidprefix = '';
    CFG.stimpath = 'C:\Programs\AOMcontrol\tempStimulus\';
    CFG.filename = 'lastTCA_RedGreenAlignment_CFG.mat';
    CFG.npresent = 10;
    CFG.intensity = 0.1;
    CFG.greenmax = 1;
    CFG.redmax = 1;
end


%  Construct the components
textbox_height = 0.08;
radio_height = 2*0.12; %was 0.12
row_y = [0.9 0.88, 0.76, 0.74, 0.62, 0.6, 0.5, 0.4, 0.3 0.2 0.1 0];


% ---- Figure handle
f = figure('Visible','on','Name','parameters',...
    'Position',[500, 500, 370, 390], 'Toolbar', 'none');

% ---- Panel
ph = uipanel('Parent',f, 'Title', 'Experiment parameters',...
    'Position',[.05 .05 .9 .9]);

% ---- Text boxes
uicontrol(ph,'Style','text',...
    'String','Subject ID',...
    'Units','normalized',...
    'Position',[.05 row_y(1) .25 .10]);

initials = uicontrol(ph,'Style','edit',...
    'Units','normalized',...
    'String', CFG.initials,...
    'Position', [.05 row_y(2) .25 textbox_height]);

uicontrol(ph,'Style','text',...
    'String','Num trials',...
    'Units','normalized',...
    'Position',[.05 row_y(3) .25 .10]);

npresent = uicontrol(ph,'Style','edit',...
    'Units','normalized',...
    'String', num2str(CFG.npresent),...
    'Position', [.05 row_y(4) .25 textbox_height]);


uicontrol(ph,'Style','text',...
    'String','Pix per deg',...
    'Units','normalized',...
    'Position',[.05 row_y(5) .25 .10]);

pixperdeg = uicontrol(ph,'Style','edit',...
    'Units','normalized',...
    'String', num2str(CFG.pixperdeg),...
    'Position', [.05 row_y(6) .25 textbox_height]);

uicontrol(ph,'Style','text',...
    'String','stim size (pix)',...
    'Units','normalized',...
    'Position',[.35 row_y(1) .25 .10]);

stimsize = uicontrol(ph,'Style','edit',...
    'Units','normalized',...
    'String', num2str(CFG.stimsize),...
    'Position', [.35 row_y(2) .25 textbox_height]);

uicontrol(ph,'Style','text',...
    'String','Red max (0 to 1)',...
    'Units','normalized',...
    'Position',[.35 row_y(3) .25 .10]);

redmax = uicontrol(ph,'Style','edit',...
    'Units','normalized',...
    'String', num2str(CFG.redmax),...
    'Position', [.35 row_y(4) .25 textbox_height]);

uicontrol(ph,'Style','text',...
    'String','Green Max (0-1)',...
    'Units','normalized',...
    'Position',[.35 row_y(5) .25 .10]);

greenmax = uicontrol(ph,'Style','edit',...
    'Units','normalized',...
    'String', num2str(CFG.greenmax),...
    'Position', [.35 row_y(6) .25 textbox_height]);


uicontrol(ph,'Style','text',...
    'String','Intensity',...
    'Units','normalized',...
    'Position',[.35 .478 .25 .10]);

intensity = uicontrol(ph,'Style','edit',...
    'Units','normalized',...
    'String', num2str(CFG.intensity),...
    'Position', [.35 .456 .25 textbox_height]);



uicontrol(ph,'Style','text',...
    'String','Stimulus Shape',...
    'Units','normalized',...
    'Position',[.05 row_y(7) .25 .07]);

stimshape = uibuttongroup(ph, 'Units','Normalized', ...
    'Position', [.05 (2/3)*row_y(8) .25 radio_height]);

b1 = uicontrol('Style','Radio', 'Parent', stimshape, ...
    'HandleVisibility','off', ...
    'Units','Normalized', ...
    'Position', [.1 .6 .8 .35], ...
    'String','Square', 'Tag','Square');

b2 = uicontrol('Style','Radio', 'Parent', stimshape, ...
    'HandleVisibility','off', ...
    'Units','Normalized', ...
    'Position',  [.1 .35 .8 .35], ...
    'String','Target', 'Tag','Target');

b3 = uicontrol('Style','Radio', 'Parent', stimshape, ...
    'HandleVisibility','off', ...
    'Units','Normalized', ...
    'Position',  [.1 .1 .8 .35], ...
    'String','Boxes', 'Tag','Boxes');

% set the default selected button.
if strcmpi(CFG.stimshape, 'Square')
    set(stimshape,'SelectedObject', b1);  % Set the object
elseif strcmpi(CFG.stimshape, 'Target')
    set(stimshape,'SelectedObject', b2);  % Set the object
else
    set(stimshape, 'SelectedObject', b3);
end

% ---- Buttons
uicontrol(ph,'Style','pushbutton','String','start',...
    'Units','normalized',...
    'Position', [.201*(2/3) .266*(2/3) .285 .08], ...
    'Callback', 'uiresume(gcbf)');

uiwait(f);

get_current_CFG();

close(f);

    function get_current_CFG()
        % commented lines are not input at the config window, but saved and
        % added in ExperimentScript.m
        CFG.stimshape = get(get(stimshape, 'SelectedObject'), 'Tag');
        CFG.initials = get(initials, 'String');
        CFG.stimsize = str2double(get(stimsize, 'String'));
        CFG.vidprefix = get(initials, 'String');
        CFG.system = 'aoslo';
        CFG.filename = 'lastTCA_RedGreenAlignment_CFG.mat';
        CFG.pixperdeg = str2double(get(pixperdeg, 'String'));
        CFG.npresent = str2double(get(npresent, 'String'));
        CFG.intensity = str2double(get(intensity,'String'));
        CFG.redmax = str2double(get(redmax,'String'));
        CFG.greenmax = str2double(get(greenmax,'String'));
         
        % save updated parameters for next time.
        save(fullfile('Experiments', CFG.filename), 'CFG');
        
    end

end
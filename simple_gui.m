function varargout = simple_gui(varargin)
% SIMPLE_GUI M-file for simple_gui.fig
%      SIMPLE_GUI, by itself, creates a new SIMPLE_GUI or raises the existing
%      singleton*.
%
%      H = SIMPLE_GUI returns the handle to a new SIMPLE_GUI or the handle to
%      the existing singleton*.
%
%      SIMPLE_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIMPLE_GUI.M with the given input arguments.
%
%      SIMPLE_GUI('Property','Value',...) creates a new SIMPLE_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before simple_gui_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to simple_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help simple_gui

% Copyright 2001-2003 The MathWorks, Inc.

% Last Modified by GUIDE v2.5 08-Dec-2019 14:38:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @simple_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @simple_gui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin & isstr(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before simple_gui is made visible.
function simple_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to simple_gui (see VARARGIN)
% Create the data to plot
handles.peaks=peaks(35);
handles.membrane=membrane;
[x,y] = meshgrid(-8:.5:8);
r = sqrt(x.^2+y.^2) + eps;
sinc = sin(r)./r;
handles.sinc = sinc;
handles.current_data = handles.peaks;
surf(handles.current_data)

% Choose default command line output for simple_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes simple_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = simple_gui_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function playOriginalButton_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Display surf plot of the currently selected data
surf(handles.current_data);
[x,Fs] = audioread(get(handles.browseTxt, 'String'));
clear sound;% stop other sounds
sound(x, Fs, 16);
% Plot the waveform.
tDouble = (1 : length(x)) / Fs; % Get time axis as a double.  Convert number of elements into actual seconds (still a double though).
tDouble = tDouble / 60; % Convert to minutes (still a double though).
tMin = datetime(0,0,0) + minutes(tDouble); % Convert variable class from "double" to "duration".
axes(handles.originalAxes); % select axes
plot(tMin, x(:, 1));  % Display waveform.

% --- Executes on button press in pushbutton2.
function mesh_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Display mesh plot of the currently selected data
mesh(handles.current_data);

% --- Executes on button press in pushbutton3.
function contour_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Display contour plot of the currently selected data
contour(handles.current_data);

% --- Executes on selection change in filterPopup.
function filterPopup_Callback(hObject, eventdata, handles)
% hObject    handle to filterPopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = get(hObject,'Value');
str = get(hObject, 'String');
switch str{val};
case 'peaks' % User selects peaks
	handles.current_data = handles.peaks;
case 'membrane' % User selects membrane
	handles.current_data = handles.membrane;
case 'sinc' % User selects sinc
	handles.current_data = handles.sinc;
end
guidata(hObject,handles)
% Hints: contents = get(hObject,'String') returns filterPopup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from filterPopup


% --- Executes during object creation, after setting all properties.
function filterPopup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filterPopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(groot,'defaultUicontrolBackgroundColor'));
end


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called





function aTxt_Callback(hObject, eventdata, handles)
% hObject    handle to aTxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of aTxt as text
%        str2double(get(hObject,'String')) returns contents of aTxt as a double


% --- Executes during object creation, after setting all properties.
function aTxt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to aTxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bTxt_Callback(hObject, eventdata, handles)
% hObject    handle to bTxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bTxt as text
%        str2double(get(hObject,'String')) returns contents of bTxt as a double


% --- Executes during object creation, after setting all properties.
function bTxt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bTxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function amplitudeTxt_Callback(hObject, eventdata, handles)
% hObject    handle to amplitudeTxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of amplitudeTxt as text
%        str2double(get(hObject,'String')) returns contents of amplitudeTxt as a double


% --- Executes during object creation, after setting all properties.
function amplitudeTxt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to amplitudeTxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function frequencyTxt_Callback(hObject, eventdata, handles)
% hObject    handle to frequencyTxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of frequencyTxt as text
%        str2double(get(hObject,'String')) returns contents of frequencyTxt as a double


% --- Executes during object creation, after setting all properties.
function frequencyTxt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frequencyTxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in playFilteredButton.
function playFilteredButton_Callback(hObject, eventdata, handles)
% hObject    handle to playFilteredButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[x,Fs] = audioread(get(handles.browseTxt, 'String'));
b = get(handles.bTxt, 'String')
a = get(handles.aTxt, 'String')
if isnan(str2double(b))
    warndlg('Please enter integer values to b','Warning');
elseif isnan(str2double(a))
    warndlg('Please enter integer values to a','Warning');
else
    y = filter(str2double(char(b)),str2double(char(a)),x);
    clear sound;% stop other sounds
    sound(y, Fs, 16);
    % Plot the waveform.
    tDouble = (1 : length(y)) / Fs; % Get time axis as a double.  Convert number of elements into actual seconds (still a double though).
    tDouble = tDouble / 60; % Convert to minutes (still a double though).
    tMin = datetime(0,0,0) + minutes(tDouble); % Convert variable class from "double" to "duration".
    axes(handles.filteredAxes); % select axes
    plot(tMin, y(:, 1));  % Display waveform.
    
    % filterexalpha.m örnek var!!!!
end

function browseTxt_Callback(hObject, eventdata, handles)
% hObject    handle to browseTxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of browseTxt as text
%        str2double(get(hObject,'String')) returns contents of browseTxt as a double


% --- Executes during object creation, after setting all properties.
function browseTxt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to browseTxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in openButton.
function openButton_Callback(hObject, eventdata, handles)
% hObject    handle to openButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file,path] = uigetfile('*.wav');
if isequal(file,0)
   disp('User selected Cancel');
else
   disp(['User selected ', fullfile(path,file)]);
   set(handles.browseTxt, 'String', fullfile(path,file));
end


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
clear sound;
delete(hObject);

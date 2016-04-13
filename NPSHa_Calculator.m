
function varargout = NPSHa_Calculator(varargin)

% NPSHA_CALCULATOR MATLAB code for NPSHa_Calculator.fig
%      NPSHA_CALCULATOR, by itself, creates a new NPSHA_CALCULATOR or raises the existing
%      singleton*.
%
%      H = NPSHA_CALCULATOR returns the handle to a new NPSHA_CALCULATOR or the handle to
%      the existing singleton*.
%
%      NPSHA_CALCULATOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NPSHA_CALCULATOR.M with the given input arguments.
%
%      NPSHA_CALCULATOR('Property','Value',...) creates a new NPSHA_CALCULATOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NPSHa_Calculator_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NPSHa_Calculator_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NPSHa_Calculator

% Last Modified by GUIDE v2.5 11-Apr-2016 23:29:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NPSHa_Calculator_OpeningFcn, ...
                   'gui_OutputFcn',  @NPSHa_Calculator_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before NPSHa_Calculator is made visible.
function NPSHa_Calculator_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NPSHa_Calculator (see VARARGIN)

% Choose default command line output for NPSHa_Calculator
handles.output = hObject;
guidata(hObject, handles);

% UIWAIT makes NPSHa_Calculator wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = NPSHa_Calculator_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
   Compound_list = cellstr(get(hObject,'String'));
   Compound = Compound_list{get(hObject,'Value')};
   [a,b] = size(handles.Fluid_names);

   for i = 1:b
       
       if strcmp(Compound,handles.Fluid_names(1,i)) == 1
           display('yes')
           handles.Fluid_vec(i) = 1;
           handles.Fluid_vec
           Compound
           handles.comp_name{1} =  Compound;
           edit6_Callback(hObject, eventdata, handles)
           
           handles.Vapour_Pressure = anton_calc(handles.Fluid_prop,handles.Fluid_temp);
           handles.mol_frac
           handles.Real_mol_frac = handles.Fluid_vec.*handles.mol_frac;
           Total_pressure = dot(handles.Vapour_Pressure,handles.Real_mol_frac );
           textLabel = sprintf('%g', Total_pressure);
           set(handles.text15, 'string', textLabel);
           
           
           Total_fluid_density = dot(handles.Fluid_density,handles.Real_mol_frac);
           textLabel = sprintf('%g',Total_fluid_density);
           set(handles.text14, 'string', textLabel);
           
           guidata(hObject, handles);
       end
   end
%    textLabel = sprintf( Compound_1);
%    set(handles.text14, 'String', textLabel);
   

% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.



if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2
   Compound_list = cellstr(get(hObject,'String'));
   Compound = Compound_list{get(hObject,'Value')};
   [a,b] = size(handles.Fluid_names);
   for i = 1:b
       if strcmp(Compound,handles.Fluid_names(1,i)) == 1
           handles.Fluid_vec(i) = 1;
handles.comp_name{2} =  Compound;
           handles.Vapour_Pressure = anton_calc(handles.Fluid_prop,handles.Fluid_temp);
           
           handles.Real_mol_frac = handles.Fluid_vec.*handles.mol_frac;

           Total_pressure = dot(handles.Vapour_Pressure,handles.Real_mol_frac );
           textLabel = sprintf('%g', Total_pressure);
           set(handles.text15, 'string', textLabel);
           
           
           Total_fluid_density = dot(handles.Fluid_density,handles.Real_mol_frac);
           textLabel = sprintf('%g',Total_fluid_density);
           set(handles.text14, 'string', textLabel);
           
           guidata(hObject, handles);
       end
   end

% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3
   Compound_list = cellstr(get(hObject,'String'));
   Compound = Compound_list{get(hObject,'Value')};
   [a,b] = size(handles.Fluid_names);
   for i = 1:b
       if strcmp(Compound,handles.Fluid_names(1,i)) == 1
           handles.Fluid_vec(i) = 1;
handles.comp_name{3} =  Compound;
           handles.Vapour_Pressure = anton_calc(handles.Fluid_prop,handles.Fluid_temp);
           
           handles.Real_mol_frac = handles.Fluid_vec.*handles.mol_frac;

           Total_pressure = dot(handles.Vapour_Pressure,handles.Real_mol_frac );
           textLabel = sprintf('%g', Total_pressure);
           set(handles.text15, 'string', textLabel);
           
           
           Total_fluid_density = dot(handles.Fluid_density,handles.Real_mol_frac);
           textLabel = sprintf('%g',Total_fluid_density);
           set(handles.text14, 'string', textLabel);
           
           guidata(hObject, handles);
       end
   end

% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4
   Compound_list = cellstr(get(hObject,'String'));
   Compound = Compound_list{get(hObject,'Value')};
   [a,b] = size(handles.Fluid_names);
   for i = 1:b
       if strcmp(Compound,handles.Fluid_names(1,i)) == 1
           handles.Fluid_vec(i) = 1;
handles.comp_name{4} =  Compound;
           handles.Vapour_Pressure = anton_calc(handles.Fluid_prop,handles.Fluid_temp);
           
           handles.Real_mol_frac = handles.Fluid_vec.*handles.mol_frac;

           Total_pressure = dot(handles.Vapour_Pressure,handles.Real_mol_frac );
           textLabel = sprintf('%g', Total_pressure);
           set(handles.text15, 'string', textLabel);
           
           
           Total_fluid_density = dot(handles.Fluid_density,handles.Real_mol_frac);
           textLabel = sprintf('%g',Total_fluid_density);
           set(handles.text14, 'string', textLabel);
           
           guidata(hObject, handles);
       end
   end

% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu5.
function popupmenu5_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu5
   Compound_list = cellstr(get(hObject,'String'));
   Compound = Compound_list{get(hObject,'Value')};
   [a,b] = size(handles.Fluid_names);
   for i = 1:b
       if strcmp(Compound,handles.Fluid_names(1,i)) == 1
           handles.Fluid_vec(i) = 1;
handles.comp_name{5} =  Compound;
           handles.Vapour_Pressure = anton_calc(handles.Fluid_prop,handles.Fluid_temp);
           
           handles.Real_mol_frac = handles.Fluid_vec.*handles.mol_frac;

           Total_pressure = dot(handles.Vapour_Pressure,handles.Real_mol_frac );
           textLabel = sprintf('%g', Total_pressure);
           set(handles.text15, 'string', textLabel);
           
           
           Total_fluid_density = dot(handles.Fluid_density,handles.Real_mol_frac);
           textLabel = sprintf('%g',Total_fluid_density);
           set(handles.text14, 'string', textLabel);
           
           guidata(hObject, handles);
       end
   end

% --- Executes during object creation, after setting all properties.
function popupmenu5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu6.
function popupmenu6_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu6 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu6
   Compound_list = cellstr(get(hObject,'String'));
   Compound = Compound_list{get(hObject,'Value')};
   [a,b] = size(handles.Fluid_names);
   for i = 1:b
       if strcmp(Compound,handles.Fluid_names(1,i)) == 1
           handles.Fluid_vec(i) = 1;
handles.comp_name{6} =  Compound;
           handles.Vapour_Pressure = anton_calc(handles.Fluid_prop,handles.Fluid_temp);
           
           handles.Real_mol_frac = handles.Fluid_vec.*handles.mol_frac;

           Total_pressure = dot(handles.Vapour_Pressure,handles.Real_mol_frac );
           textLabel = sprintf('%g', Total_pressure);
           set(handles.text15, 'string', textLabel);
           
           
           Total_fluid_density = dot(handles.Fluid_density,handles.Real_mol_frac);
           textLabel = sprintf('%g',Total_fluid_density);
           set(handles.text14, 'string', textLabel);
           
           guidata(hObject, handles);
       end
   end

% --- Executes during object creation, after setting all properties.
function popupmenu6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu7.
function popupmenu7_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu7 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu7
   Compound_list = cellstr(get(hObject,'String'));
   Compound = Compound_list{get(hObject,'Value')};
   [a,b] = size(handles.Fluid_names);
   for i = 1:b
       if strcmp(Compound,handles.Fluid_names(1,i)) == 1
           handles.Fluid_vec(i) = 1;
handles.comp_name{7}=  Compound;
           handles.Vapour_Pressure = anton_calc(handles.Fluid_prop,handles.Fluid_temp);
           
           handles.Real_mol_frac = handles.Fluid_vec.*handles.mol_frac;

           Total_pressure = dot(handles.Vapour_Pressure,handles.Real_mol_frac );
           textLabel = sprintf('%g', Total_pressure);
           set(handles.text15, 'string', textLabel);
           
           
           Total_fluid_density = dot(handles.Fluid_density,handles.Real_mol_frac);
           textLabel = sprintf('%g',Total_fluid_density);
           set(handles.text14, 'string', textLabel);
           
           guidata(hObject, handles);
       end
   end

% --- Executes during object creation, after setting all properties.
function popupmenu7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu8.
function popupmenu8_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu8 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu8
   Compound_list = cellstr(get(hObject,'String'));
   Compound = Compound_list{get(hObject,'Value')};
   [a,b] = size(handles.Fluid_names);
   for i = 1:b
        if strcmp(Compound,handles.Fluid_names(1,i)) == 1
           handles.Fluid_vec(i) = 1;
handles.comp_name{8} =  Compound;
           handles.Vapour_Pressure = anton_calc(handles.Fluid_prop,handles.Fluid_temp);
           
           handles.Real_mol_frac = handles.Fluid_vec.*handles.mol_frac;

           Total_pressure = dot(handles.Vapour_Pressure,handles.Real_mol_frac );
           textLabel = sprintf('%g', Total_pressure);
           set(handles.text15, 'string', textLabel);
           
           
           Total_fluid_density = dot(handles.Fluid_density,handles.Real_mol_frac);
           textLabel = sprintf('%g',Total_fluid_density);
           set(handles.text14, 'string', textLabel);
           
           guidata(hObject, handles);
       end
   end

% --- Executes during object creation, after setting all properties.
function popupmenu8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
%     Fluid_temp =  str2double(get(hObject,'String'));
%     handles.Fluid_temp = Fluid_temp;
%     guidata(hObject, handles);

    handles.Fluid_temp = str2double(get(hObject,'String'));
    
    handles.Vapour_Pressure = anton_calc(handles.Fluid_prop,handles.Fluid_temp);
    
    
    Total_pressure = dot(handles.Vapour_Pressure,handles.Real_mol_frac);
    textLabel = sprintf('%g', Total_pressure);
    
    if sum(handles.Real_mol_frac) > .01
        
        set(handles.text15, 'string', textLabel);
    end
    guidata(hObject, handles);
    
    

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
    edit1_Callback(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double
    Atm_pres =  str2double(get(hObject,'String'));
    handles.Atm_pres = Atm_pres;
    guidata(hObject, handles);
%  

% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
edit2_Callback(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
    
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double
    Liq_height =  str2double(get(hObject,'String'));
    handles.Liq_height = Liq_height;
    guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
edit3_Callback(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double
    pipe_length =  str2double(get(hObject,'String'));
    handles.pipe_length = pipe_length;
    guidata(hObject, handles);
    
% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
edit4_Callback(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu9.
function popupmenu9_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu9 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu9


% --- Executes during object creation, after setting all properties.
function popupmenu9_CreateFcn(hObject, ~, handles)
% hObject    handle to popupmenu9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double
    roughness =  str2double(get(hObject,'String'));
    handles.roughness = roughness;
    guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
edit5_Callback(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pres = anton_calc(ant_const,temp)
        
    [a,b] =size(ant_const);
     pres = zeros(1,b);   
    for i = 1: b
        pres(i) = exp(ant_const(1,i)-(ant_const(2,i)/(temp+ant_const(3,i))));
    end
    
    

function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double

     [a,b] = size(handles.Fluid_names);
     
   for i = 1:b
       if strcmp(handles.comp_name(1),handles.Fluid_names(1,i)) == 1
           
            display('i run')
            str2double(get(hObject,'String'))
            handles.mol_frac(i) = str2double(get(hObject,'String'));
            handles.mol_frac(i)
            guidata(hObject, handles)
       else
        display('i didnt run')
       end
   end

    guidata(hObject, handles)
    

% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
edit6_Callback(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double
     [a,b] = size(handles.Fluid_names);
     
   for i = 1:b
       if strcmp(handles.comp_name(2),handles.Fluid_names(1,i)) == 1
            handles.mol_frac(i) = str2double(get(hObject,'String'));
       end
   end
guidata(hObject, handles)

% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
edit7_Callback(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double
     [a,b] = size(handles.Fluid_names);
     
   for i = 1:b
       if strcmp(handles.comp_name(3),handles.Fluid_names(1,i)) == 1
            handles.mol_frac(i) = str2double(get(hObject,'String'));
       end
   end
guidata(hObject, handles)

% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
edit8_Callback(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double
     [a,b] = size(handles.Fluid_names);
     
   for i = 1:b
       if strcmp(handles.comp_name(4),handles.Fluid_names(1,i)) == 1
            handles.mol_frac(i) = str2double(get(hObject,'String'));
       end
   end
guidata(hObject, handles)

% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
edit9_Callback(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double
     [a,b] = size(handles.Fluid_names);
     
   for i = 1:b
       if strcmp(handles.comp_name(5),handles.Fluid_names(1,i)) == 1
            handles.mol_frac(i) = str2double(get(hObject,'String'));
       end
   end
guidata(hObject, handles)

% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
edit10_Callback(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double
     [a,b] = size(handles.Fluid_names);
     
   for i = 1:b
       if strcmp(handles.comp_name(6),handles.Fluid_names(1,i)) == 1
            handles.mol_frac(i) = str2double(get(hObject,'String'));
       end
   end
guidata(hObject, handles)

% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
edit11_Callback(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double
     [a,b] = size(handles.Fluid_names);
     
   for i = 1:b
       if strcmp(handles.comp_name(7),handles.Fluid_names(1,i)) == 1
            handles.mol_frac(i) = str2double(get(hObject,'String'));
       end
   end
guidata(hObject, handles)

% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
edit12_Callback(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double
     [a,b] = size(handles.Fluid_names);
     
   for i = 1:b
       if strcmp(handles.comp_name(8),handles.Fluid_names(1,i)) == 1
           
            handles.mol_frac(i) = str2double(get(hObject,'String'));
       end
   end
guidata(hObject, handles)

% --- Executes during object creation, after setting all properties.

    

function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
clc
currentdir = cd;
[data,ext,raw] = xlsread('Data.xlsx','Sheet1','C2:AR7');
[a,b] =size(raw);
handles.mol_frac = zeros(1,b);
handles.Fluid_vec = zeros(1,b);
handles.Fluid_names = raw(1,:);
handles.Fluid_prop = data;
handles.comp_name = cell(1,8);
handles.comp_name{1} = 'Water';
handles.Real_mol_frac = zeros(1,b);
% handles.Vapour_Pressure = zeros(1,8);
handles.Fluid_density = data(4,:);
guidata(hObject, handles);
edit13_Callback(hObject, eventdata, handles);
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

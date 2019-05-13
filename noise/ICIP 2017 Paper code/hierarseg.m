function varargout = hierarseg(varargin)
% HIERARSEG MATLAB code for hierarseg.fig
%      HIERARSEG, by itself, creates a new HIERARSEG or raises the existing
%      singleton*.
%
%      H = HIERARSEG returns the handle to a new HIERARSEG or the handle to
%      the existing singleton*.
%
%      HIERARSEG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HIERARSEG.M with the given input arguments.
%
%      HIERARSEG('Property','Value',...) creates a new HIERARSEG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before hierarseg_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to hierarseg_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help hierarseg

% Last Modified by GUIDE v2.5 26-Nov-2016 18:48:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @hierarseg_OpeningFcn, ...
                   'gui_OutputFcn',  @hierarseg_OutputFcn, ...
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


% --- Executes just before hierarseg is made visible.
function hierarseg_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to hierarseg (see VARARGIN)

% Choose default command line output for hierarseg
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes hierarseg wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = hierarseg_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

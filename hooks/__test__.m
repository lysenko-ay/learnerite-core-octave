function __test__(varargin)
  % input stack
  global __input_stack__;
  __input_stack__ = {};

  % get functions handles
  master = varargin{end-1};
  varargin(end-1) = [];
  user = varargin{end};
  varargin(end) = [];

  % run solution
  x = master(varargin{2:2:length(varargin)});

  % push variables to input stack
  for idx = 2:2:length(varargin)
    value = varargin{idx};
    __push_input__(value);
  endfor

  % format task values
  values = varargin(2:2:end);
  fields = varargin(1:2:end);
  parameters = jsonencode(cell2struct(values, fields, 2));

  % execute user code
  warning('off', 'Octave:shadowed-function')
  addpath('overrides')
  warning('on', 'Octave:shadowed-function')
  y = user();
  rmpath('overrides')

  % check if all inputs are consumed
  if numel(__input_stack__) ~= 0
    error("error, input stack is not empty (%d value(s) left)", numel(__input_stack__));
  endif

  % display result
  disp([__getenv__('OCC_MAGIC', '187'), parameters, '|', jsonencode(x), '|', jsonencode(y)]);
endfunction

function __push_input__(value)
  global __input_stack__;

  if isnumeric(value) == 1
    value = num2str(value);
  end

  __input_stack__{end + 1} = value;
endfunction

function [result] = __getenv__(key, default_value)
  var = getenv(key);
  if isempty(var)
    var = default_value;
  endif

  result = char(str2num(var));
endfunction

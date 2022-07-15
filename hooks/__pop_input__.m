function [value] = __pop_input__()
  global __input_stack__;

  if numel(__input_stack__) > 0
    value = __input_stack__{1};
    __input_stack__(1) = [];
  else
    value = NaN;
    error('input stack is empty')
  end
endfunction

function m = fac(n)
% returns the factorial of n
% 
% Example:
%   fac(6)
%   %|| 720
%

if n<0
   error("Input n must be nonnegative."); 
end

if n - floor(n) > n*eps
    error("Input n must be an integer value")
end

if n == 0 || n == 1
    % 0! = 1! = 1
    m = 1;
else
    % calculate via recursion
    m = n.*fac(n-1);
end
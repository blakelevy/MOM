function [ y ] = mom_cycle( i, N )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
if i < 0
    y = N+i;
elseif i >= N
    y = i-N;
else
    y = i;
end
end


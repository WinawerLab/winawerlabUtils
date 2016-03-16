function [m n]=subplotsize(numsubplots)


% [m n]=subplotsize(numsubplots)

%take the number of subplots and figure out the arguments to subplot m and
%n for subplot(m,n,i)  while satisfying the two criteria
% m and n are close together in value
% y = m*n - numsubplots is as small as possible
% m will always be sqrt(numsubplots)

%starting guess can be the square root of numsubplots

m = ceil(sqrt(numsubplots));
n=m;
%initial error
y = m^2-numsubplots;

% make a search space, lets make it so that |m-n|<=3

for i = m-3:1:m-1
    %check the value for a new difference
    newy = m*i-numsubplots;
    %if that value is less than y and greater than or = to 0
    %that is all the plots can fit, then return the new value
    if (newy<y  && newy >=0)
%set the new best error
        y=newy;
        %change the value of n
        n=i;
    end
end



end
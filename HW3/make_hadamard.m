function H = make_hadamard(n,classname)
    if nargin < 2, classname = 'double'; end

    [f,e] = log2([n n/12 n/20]);
    k = find(f==1/2 & e>0);
    if min(size(n)) > 1 || isempty(k)
       error(message('MATLAB:hadamard:InvalidInput'));
    end
    e = e(k)-1;

    if k == 1        
       H = ones(classname);

    elseif k == 2 
       H = [ones(1,12,classname); ones(11,1,classname) ...
            toeplitz([-1 -1 1 -1 -1 -1 1 1 1 -1 1],[-1 1 -1 1 1 1 -1 -1 -1 1 -1])];

    elseif k == 3 
       H = [ones(1,20,classname); ones(19,1,classname)   ...
            hankel([-1 -1 1 1 -1 -1 -1 -1 1 -1 1 -1 1 1 1 1 -1 -1 1], ...
                   [1 -1 -1 1 1 -1 -1 -1 -1 1 -1 1 -1 1 1 1 1 -1 -1])];
    end

    for i = 1:e
        H = [H  H
             H -H];
    end
end

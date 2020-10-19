function sigma = Myvar(X)
    [col, row] = size(X);
    for a = 1:row
        sigma(a) = ((sum(X(:,a).^2)) - (sum(X(:,a))^2)/col)/(col - 1);
    end
end





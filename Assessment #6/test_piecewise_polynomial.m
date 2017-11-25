function [p] = test_piecewise_polynomial()
    p(1) = piecewise_polynomial([-2,-1,2],[polynomial([0,0,-2,3]),polynomial([0])]);
    p(2) = piecewise_polynomial([-2,-1,1,2],[polynomial([0]),polynomial([0,1]),polynomial([0])]);
    p(3) = piecewise_polynomial([-2,-1,2],[polynomial([0]),polynomial([-3,0,1])]);
    p(4) = p(1)+p(2)+p(3);
    p(5) = p(1)-p(2)-p(3);
    p(6) = p(4)*p(5);
    p(7) = p(2)^3;
    p(8) = integrate(p(4));
    p(9) = differentiate(p(8));
end
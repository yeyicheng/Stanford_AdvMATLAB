classdef piecewise_polynomial
    properties
        xi = [];
        npoly = 0;
        polys = [];
    end
    
    methods(Access = private, Static = true)
        function [index] = get_index(v, p_xi)
            index = -1;
            for i = 1:length(p_xi)-1
                if v >= p_xi(i) && v <= p_xi(i + 1) 
                    index = i;
                    break;
                end
            end
        end
    end
    
    methods
        function [self] = piecewise_polynomial(arg1, arg2)
            if nargin == 0
                self.xi = [];
                self.npoly = 0;
                self.polys = [];
            elseif nargin == 1
                if isa(arg1,'piecewise_polynomial')
                    self.xi = arg1.xi;
                    self.npoly = arg1.npoly;
                    self.polys = arg1.polys;
                elseif isa(arg1,'double')
                    self.xi = arg1;
                    self.npoly = length(arg1) - 1;
                    self.polys = [];
                end
            elseif nargin == 2
                self.xi = arg1;
                self.npoly = length(arg2);
                self.polys = arg2;
            end
        end

        function [poly] = uplus(p)
            poly = p;
        end
        
        function [poly] = plus(p, q) 
            pp = [];
            pp_xi = union(p.xi,q.xi);
            for i = 2:length(pp_xi)
                p_i = piecewise_polynomial.get_index(pp_xi(i),p.xi);
                q_i = piecewise_polynomial.get_index(pp_xi(i),q.xi);
                pp = [pp p.polys(p_i) + q.polys(q_i)];
            end
            poly = piecewise_polynomial(pp_xi,pp);
        end
        
        function [poly] = uminus(p)
            pp = [];
            for i = 1:p.npoly
                pp = [pp -q.polys(i)];   
            end
            poly = piecewise_polynomial(p.xi, pp);
        end
        
        function [poly] = minus(p, q)
            pp = [];
            pp_xi = union(p.xi,q.xi);
            for i = 2:length(pp_xi)
                p_i = piecewise_polynomial.get_index(pp_xi(i),p.xi);
                q_i = piecewise_polynomial.get_index(pp_xi(i),q.xi);
                pp = [pp p.polys(p_i) - q.polys(q_i)];
            end
            poly = piecewise_polynomial(pp_xi,pp);
        end
        
        function [poly] = mtimes(p, q)
            pp = [];
            for i = 1:p.npoly
                pp = [pp p.polys(i) * q.polys(i)];   
            end
            poly = piecewise_polynomial(p.xi, pp);
        end
        
        function [poly] = mpower(p, c)
            pp = [];
            for i = 1:p.npoly
                pp = [pp p.polys(i) ^ c];   
            end
            poly = piecewise_polynomial(p.xi, pp);
        end
        
        function [iseq] = eq(p, q)
            if p.npoly ~= q.npoly
               iseq = 0;
               return;
            end
            for i = 1:p.npoly
            	if ~eq(p.polys(i), q.polys(i))
                   iseq = 0;
                   return;
            	end
            end
            iseq = 1;
        end
        
        function [poly] = integrate(p)
            pp = [];
            for i = 1:p.npoly
            	pp = [pp integrate(p.polys(i))];   
            end
            poly = piecewise_polynomial(p.xi, pp);
        end
        
        function [poly] = differentiate(p)
            pp = [];
            for i = 1:p.npoly
                pp = [pp differentiate(p.polys(i))];
            end
            poly = piecewise_polynomial(p.xi, pp);
        end
        
        function [output] = evaluate(p, v)
            output = [];
            for i = 1:length(v)
                index = piecewise_polynomial.get_index(v(i), p.xi);
                output = [output, evaluate(p.polys(index), v)];
            end
        end
        
        function [] = plot_it(p)
            ax = axes('nextplot','add');
            for i = 1:p.npoly
            	plot_it(p.polys(i),linspace(p.xi(i),p.xi(i+1),100),{'r--','linewi',2},ax);
            end
        end
    end
    
end
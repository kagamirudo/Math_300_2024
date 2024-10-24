function bisect_method(f, a, b, tol, N)
    done = false; # changing this to false in the function will mean we have reached a stopping criteria
    i = 1;
    p = 0;
    while (done == false) && (i <= N) # "if no stopping criteria yet and we havent gone over max iterations..."
        FA = f(a)
        p = (a + b)/2 # bisection point
        FP = f(p)
        b_old = b # this will help with outputing the error for this iteration
        a_old = a # this will help with outputing the error for this iteration
        if FA * FP < 0.0 # see if sign changed in first half of interval
            a = a
            b = p
        elseif FA * FP > 0.0 # see if sign changed in second half of interval
            a = p 
            b = b
        else # FA * FP = 0, so this means we found the root exactly.
            @printf("Iteration %d: Root found exactly at x=%g.\n",i, p)
            done = true
        end

        if (b-a)/2 <= tol && done == false # we're within the tol but we didnt find the root exactly
            @printf("Iteration %d: Root found at x=%g. With error %g.\n",i, p, (b-a)/2)
            done = true
        elseif (b-a)/2 > tol && done == false # we're not within the tol and we didnt find the root exactly, so keep going.
            @printf("Iteration %d: Root approximation is x=%g with error %g.\n", i, (a_old+b_old)/2, (b_old-a_old)/2)
            i += 1
        end
    end

    return p # makes the function output p
end


function fixed_point_iteration(g, p, n_max, rel_tol)
    p_old = p; # initialize p_old.
    for i in 1:n_max
        p = g(p); # set our new p to g(p)
        @printf("Iteration %d: p = %g\n", i, p);
        if (i > 1) # only do this loop after the first iteration
            if abs(p_old - p)/abs(p) < rel_tol # check to see if error is within rel tol
                break; # if it is, break the loop
            end
        end
        p_old = p # set old_p as p that we just calculated.
    end

    return p
end


function newton(f, df, p0, n_max=100, rel_tol=10^-4; verbose = true) # verbose being true will create outputs on each iteration
    
    converged = false;
    p = p0; # initialize p so it will live outside of the loop
    p_old = p0; # initialize p_old and we will use it to find p in the loop

    for i in 1:n_max

        p = p_old - f(p_old)/df(p_old); # calculate p
        
        if verbose
            @printf(" %d: p = %.15g, f(p) = %g\n", i, p, f(p));
        end

        
        if (i>1)
            if abs(p-p_old)/abs(p)< rel_tol # Check to see if we're within tolerance.
                converged = true;
                if verbose
                    @printf("Found Root within tolerance on Iteration %d: p = %.15g, f(p) = %g\n", i, p, f(p));
                end
                break
            end
        end

        p_old = p; # store the new p as p_old to be used in the next iteration.

    end
    
    if !converged
        @printf("ERROR: Did not converge after %d iterations\n", n_max);
    end

    return p
    
end
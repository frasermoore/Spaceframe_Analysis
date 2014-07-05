function [Guess] = GaussSeidel(A, B, Accuracy, Guess)

[n,m] = size(A);

Error = zeros(n,1);

done = 0;

while done == 0

    for i = 1 : n

        NewVal = (B(i) ...
            -sum(A(i,1:(i-1))*Guess(1:(i-1))) ...
            -sum(A(i,(i+1):n)*Guess((i+1):n)))/A(i,i);
 
        Error(i) = Guess(i) - NewVal;
    
        Guess(i) = NewVal;
    
    end
    
    done = 1;
    
    if(abs(max(Error))>Accuracy)

        done = 0;

    end
    
end

end


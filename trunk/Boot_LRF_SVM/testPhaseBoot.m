function [missData] = testPhaseBoot( threshold ,SOL, B , nonPedTest )
%TESTPHASE Function used to test the classifer on the boostrap data. 

    missData = zeros(size(nonPedTest,1),size(nonPedTest,2)+2);
    size(missData)
    errorNonPed =0;
    for i=1 : size(nonPedTest,1)  
        value = nonPedTest(i,:) * SOL + B ;
        if value > threshold
            errorNonPed = errorNonPed + 1;
            missData(i,:) = [ abs(value-threshold) -1 nonPedTest(i,:)];
       
        else
            missData(i,:) = [ abs(value-threshold) -1 nonPedTest(i,:)];
           
        end
            
    end  
    errorNonPed
end


function [missData correctData] = testPhaseBoot( SOL, B , nonPedTest )
%TESTPHASE Function used to test the classifer on the boostrap data. 

    missData = [];
    correctData = [];
    errorNonPed =0;
    for i=1 : size(nonPedTest,1)  
        value = nonPedTest(i,:) * SOL + B ;
        if value > 0
            errorNonPed = errorNonPed + 1;
            missData = [missData; value -1 nonPedTest(i,:)];
       
        else
            correctData = [ correctData; value -1 nonPedTest(i,:)];
        end
            
    end  
    errorNonPed
end


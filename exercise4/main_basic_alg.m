%for threshold = 0 
%percentPed_avg =    0.0980
% percentNonPed_avg =    0.3260
% percentPed_max =    0.2360
% percentNonPed_max =    0.1420
% percentErrorPed_ideal =    0.2360
% percentErrorNonPed_ideal =    0.0420

hold all
    
    for i = -3.6 : 0.2: 4
    [percentPed_avg, percentNonPed_avg,percentPed_max, percentNonPed_max percentErrorPed_ideal percentErrorNonPed_ideal] = basic_SVM_compare(i);
 
    plot(percentPed_avg,1 - percentNonPed_avg,'--rs','LineWidth',2,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','g',...
                'MarkerSize',5);
   plot(percentPed_max,1 - percentNonPed_max,'--rs','LineWidth',2,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','r',...
                'MarkerSize',5);
   plot(percentErrorPed_ideal,1 - percentErrorNonPed_ideal,'--rs','LineWidth',2,...
                'MarkerEdgeColor','b',...
                'MarkerFaceColor','g',...
                'MarkerSize',5);
    end

 
    ylabel('Pedestrian detection rate');
    xlabel('Non-pedestrians detected as pedestrians') ;

  [percentPed_avg, percentNonPed_avg,percentPed_max, percentNonPed_max percentErrorPed_ideal percentErrorNonPed_ideal] = basic_SVM_compare(0)
 
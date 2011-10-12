 
    hold all
    
    for i = -3.6 : 0.2: 4
    [percentPed_avg, percentNonPed_avg,percentPed_max, percentNonPed_max] = basic_SVM_compare(i);
 
    plot(percentPed_avg,1 - percentNonPed_avg,'--rs','LineWidth',2,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','g',...
                'MarkerSize',5);
            plot(percentPed_max,1 - percentNonPed_max,'--rs','LineWidth',2,...
                'MarkerEdgeColor','b',...
                'MarkerFaceColor','g',...
                'MarkerSize',5);
    end

 
    ylabel('Pedestrian detection rate');
    xlabel('Non-pedestrians detected as pedestrians') ;


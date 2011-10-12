% cu trash la 0
% before boot 
% percentPed =     0.3200
% percentNonPed =     0.1900

% after bootstraping  random 
% percentPed =     0.3460
% percentNonPed =     0.1680

load ..\mlpr_data\data_hog.mat;
load ..\mlpr_data\data_bootstrap.mat;

pedTrain = ped_train_hog;
nonPedTrain= garb_train_hog;

nonPedBootTest = garb_bootstrap_hog(:,2:1153);

pedTest = ped_test_hog(:,2:1153);
nonPedTest = garb_test_hog(:,2:1153);

[SOL_hog_init, B_hog_init] = hog_svm_compute( pedTrain,nonPedTrain);

save('..\hogSVM.mat','SOL_hog_init', 'B_hog_init');

% test on bostrap data
[missclassifiedData correctData] = testPhaseBoot( SOL_hog_init, B_hog_init, nonPedBootTest);
 
%  size(correctData)
newDataLen = size(missclassifiedData,1)
newTraining = zeros(250,1153);
for i=1:250 
     index = random('unid', 1000 ); % Pick the index at random
     newTraining(i,:) = garb_bootstrap_hog(index,:); % Add random point 
end

nonPedTrain = [ nonPedTrain; newTraining];
     
size(nonPedTrain)
[SOL_hog_boot, B_hog_boot] = hog_svm_compute( pedTrain,nonPedTrain);
 save('..\hogSVM.mat','SOL_hog_boot', 'B_hog_boot','-append');

hold all; 
for i = -3.6 : 0.2: 4
[percentPed, percentNonPed] = testPhase(i, SOL_hog_init, B_hog_init,pedTest, nonPedTest);
  
    plot(percentNonPed,1 - percentPed,'--rs','LineWidth',2,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','g',...
                'MarkerSize',5);

  [percentPed, percentNonPed] = testPhase(i, SOL_hog_boot, B_hog_boot ,pedTest, nonPedTest);
   plot(percentNonPed,1 - percentPed,'--rs','LineWidth',2,...
                'MarkerEdgeColor','b',...
                'MarkerFaceColor','r',...
                'MarkerSize',5);
  
end

    ylabel('Pedestrian detection rate');
    xlabel('Non-pedestrians detected as pedestrians') ;  

 [percentPed, percentNonPed] = testPhase(0, SOL_hog_init, B_hog_init,pedTest, nonPedTest)
 [percentPed, percentNonPed] = testPhase(0, SOL_hog_boot, B_hog_boot ,pedTest, nonPedTest)

 
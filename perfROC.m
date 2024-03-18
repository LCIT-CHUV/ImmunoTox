function [returnTable] = perfROC(biomarkerTable,cutoffTable,doDisp)
%PERFROC Return matrix with accuracy,positive predictive value and negative
%predictive value.
% 
% Take two table as input :
% biomarkerTable : n*m with n measurement of m biomarkers
% cutoffTable : m*3 table with eachline biomarker name, cutoff value and
% sign for cutoff (> or <).


if nargin > 2
  doDisp = doDisp;
else
  doDisp = false;
end


% loop constants
realDiagnosis=biomarkerTable{:,1};
returnTable=zeros(size(biomarkerTable, 2)-1,3);

x=1;


%loop BM
for i=2:size(biomarkerTable, 2)
    %Loop constants
    cutoffVal=cutoffTable{i-1,2};
    cutoffSign=cutoffTable{i-1,3};
    biomarkerVal=biomarkerTable(:,i);
    
    truePositive = 0;
    trueNegative = 0;
    falsePositive = 0;
    falseNegative = 0;

    

    for j=1:size(biomarkerVal,1)
        % Test
        if(not(isnan(biomarkerVal{j,1})))
            if (cutoffSign{1} == '<' && biomarkerVal{j,1} > cutoffVal) || (cutoffSign{1} == '>' && biomarkerVal{j,1} < cutoffVal)
                predictedDiag = 1;
            else
                predictedDiag = 0;
            end
            trueDiag=realDiagnosis(j);

            %Comparaison switch 
            if predictedDiag == 1 && trueDiag == 1
                truePositive = truePositive + 1;
            elseif predictedDiag == 0 && trueDiag == 0
                trueNegative = trueNegative + 1;
            elseif predictedDiag == 1 && trueDiag == 0
                falsePositive = falsePositive + 1;
            elseif predictedDiag == 0 && trueDiag == 1
                falseNegative = falseNegative + 1;
            end
        end
    end

    % Calculate metrics
    accuracy = (truePositive + trueNegative) / (truePositive + trueNegative + falsePositive + falseNegative);
    ppv = truePositive / (truePositive + falsePositive);
    npv = trueNegative / (trueNegative + falseNegative);

    % Optional Display results
    if(doDisp==true)
        disp(['Biomarker: ' cutoffTable{i-1,1}{1}]);
        disp(['Accuracy: ' num2str(accuracy)]);
        disp(['Positive Predictive Value (PPV): ' num2str(ppv)]);
        disp(['Negative Predictive Value (NPV): ' num2str(npv)]);
    end




    returnTable(x,1)=accuracy;
    returnTable(x,2)=ppv;
    returnTable(x,3)=npv;


    x=x+1;
end

end




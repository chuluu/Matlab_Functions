function Correct_percent = Percentage_Samples_Correct(Solution)
    correct = find(Solution == 1);
    incorrect = find(Solution == 0);

    total_samples = length(correct) + length(incorrect);
    Correct_percent = (length(correct)/total_samples)*100;
end
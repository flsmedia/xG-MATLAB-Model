xG MATLAB Model


    To run: 
 
    make sure you have soccer_workspace.mat,  (**ANY OTHER WORKSPACES**)
    
    import Oxy shot data as a table 

    run main file: Project_main.m
    
--------------------------------------------------------
    This zip file should contain:
 
    soccer_workspace.mat, (**ANY OTHER WORKSPACES**)
    
    removeNAN- this function removes data entries with NAN values in the
    relevant feature columns
 
    splitData- splits data and labels into training, development,and test sets
        also randomizes order
 
    EstablishPerceptron- this is my perceptron function from project one.
    takes in data and labels, trains a perceptron assuming linear
    separability
 
    AdjustWeight- called in EstablishPerceptron, adjusts weights 
    and b simultaneously
 
    Perceive- tests perceptron (or SVM). uses decision boundary from EstablishPerceptron to predict y
    values for an unknown dataset
 
    establishSVM- turns decision boundary from EstablishPerceptron into support 
    vector machine. uses gradient descent to loop through data, updating weights and b
 
    CrossVal- cross validates SVM across 8 folds
 
   OptimizeSVM- calls all the former functions to train an optimal SVM and
   test it
 
bootstrap- gives 20 sets of test results for two input models across 1
bootstrapped test set
 
ttestForestSVM- gives statistical analysis of bootstapped test outputs
 
ForstVsSVM- the SVM poo-bah script, which compares the results of the
optimized SVM to the pre-trained optimized random forest using the above
methods
 
preProcess- a script w collection of methods which was used to process data
 
SVMtester- a script previously used to compare results from SVM's tested on
datasets with different degrees of balance

gamePerf – a function that performs xG analysis on each recorded game (16 total) by splitting up the input shot data based on each events game ID. It outputs information about the each game’s expected and actual outcome. 

goalPerf – a function that performs broad xG analysis for all input shot data, outputting information about total goals scored against expectation throughout the season, as well as the average number of goals scored per game against expectation. 

Organize – Sorts and organizes input data for use in xG analysis later on. 


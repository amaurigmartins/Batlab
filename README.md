[![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=amaurigmartins/ATPBatlab ) 

# ATP-Batlab

Helper tool for batch ATP simulations, parametrics analyses and dataset generation using MATLAB. ATP-Batlab is designed to read a template ATP file supplied by the user and extract the model variables defined in the $PARAMETER section. A friendly GUI enables the user to specify ranges or conditional values for each variable set in ATP/ATPDraw. Then, the program will refactor the original ATP template and write the requested case files, changing the $PARAMETER values as per user entry. A Windows script (batch file) is created to run and post-process all cases at once. The result files may be kept in PL4 format, written to MATLAB matfiles or converted into COMTRADE. ATP. Batch. MATLAB.  Batlab. Got it? 

### Highlight of the main features

- Parametric simulations made easy: you can vary component values, switch statuses, circuit node where a disturbance occurs, fault location along a line and basically whatever can be declared as a $PARAMETER in ATP.
- Values can be set as hard-coded data or MATLAB functions, numeric or string. You can specify several variables, the program will write all the possible input combinations.
- Conditionally-defined variables, according to other $PARAMETER values, are possible - all you gotta do is define a valid expression that returns a boolean outcome.
- Post-processing features: save the outputs as PL4, matfiles or ASCII COMTRADE.
- Run recovery features: you are in the middle of a thousand-cases batch and the power goes out... Ironic, but fear not: the batch is programmed to recover from where it stopped. Also, progress is recorded to logfiles. You are welcome.
- ATP-Batlab is distributed with a GUI designed to aid data entry. You can save your projects in matfiles and recover them for later use.

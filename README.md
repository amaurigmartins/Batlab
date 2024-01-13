[![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=amaurigmartins/ATPBatlab) 

# ATP-Batlab

Helper tool for batch ATP simulations, parametric analyses and dataset generation using MATLAB. ATP-Batlab is designed to read a template ATP file supplied by the user and extract the model variables defined in the $PARAMETER section. A friendly GUI enables the user to specify ranges or conditional values for each variable set in ATP/ATPDraw. Then, the program will refactor the original ATP template and write the requested case files, changing the $PARAMETER values as per user entry. A Windows script (batch file) is created to run and post-process all cases at once. The result files may be kept in PL4 format, written to MATLAB matfiles or converted into COMTRADE. 

ATP. Batch. MATLAB.  Batlab. Got it? 

### Highlight of the main features

- Parametric simulations made easy: you can vary component values, switch statuses, circuit node where a disturbance occurs, fault location along a line and basically whatever can be declared as a $PARAMETER in ATP.
- Values can be set as hard-coded data or MATLAB functions, numeric or string. You can specify several variables, the program will write all the possible input combinations.
- Conditionally-defined variables, according to other $PARAMETER values, are possible - all you gotta do is define a valid expression that returns a boolean outcome.
- Post-processing features: save the outputs as PL4, matfiles or ASCII COMTRADE.
- Run recovery features: you are in the middle of a thousand-cases batch and the power goes out... Ironic, but fear not: the batch is programmed to recover from where it stopped. Also, progress is recorded to logfiles. You are welcome.
- ATP-Batlab is distributed with a GUI designed to aid data entry. You can save your projects in matfiles and recover them for later use.

### Basic instructions

The use of the program is relatively straightforward if you are able to work with $PARAMETER values in ATP. Create your model normally in ATPDraw. Specify the values you want to vary as $PARAMETER variables in ATPDraw (make sure that the internal parser of ATPDraw is DISABLED). Hit ATP → Sub-process → Make ATP file. This is your template file. Launch the file 'atpbatlab.mlapp' from MATLAB workspace and load the newly-created ATP file. All valid $PARAMETERS will be parsed and displayed in the 'Model variables' window. The field 'Newvalues' contain the values you want to specify. Set numeric data as row vectors ([1 2 3]), string data as cell arrays ({'str1' 'str2' 'str3'}) or any MATLAB function returning these data types. You can save your design by clicking 'Save input session' or recover an existing design by clicking 'Load input session'. You will be prompted to specify a JobID and this is **mandatory**. The JobID is a text string which will be used to identify all the output files and folders. For instructions on the conditional variables, hover the mouse over the corresponding window in the 'Refactor' tab. Right-click over a $PARAMETER for shortcuts. Define what tasks you want to perform and hit Run!

[![Screenshot #1](https://github.com/amaurigmartins/ATPBatlab/blob/main/Screenshot.png?raw=true)](https://github.com/amaurigmartins/ATPBatlab/blob/main/Screenshot.png?raw=true) 

### Important information

ATP-Batlab requires the external binary Pl42mat.exe to perform conversions from the ATP PL4 format into matfiles. To make things easier, this program is made available in the 'tools' folder. Note that Pl42mat is intelectual property of prof. Massimo Ceraolo from University of Pisa (Italy), with all due credits given. Observe any restrictions and licensing/usage requirements in his website:  [http://ceraolo-plotxy.ing.unipi.it/default.htm](http://ceraolo-plotxy.ing.unipi.it/default.htm).

## Restrictions of use

We appreciate the interest in our work and we invite the interested users to use our codes as necessary, as long as they are not embedded in any commercial software, which is **strictly prohibited**. However, if you use the ATP-Batlab as a part of scientific research, we kindly ask you to refer to our published papers as per the CITATION.cff file.



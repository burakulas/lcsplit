

LCSPLIT is a short bash script for splitting the long astronomical light curve data into "one-period-long sub-light curves" to investigate them separately. It is aimed to apply to Kepler light curve data, however, it can be applied all time-related data, technically, by entering the appropriate period value. The code first removes non-numeric values and sorts the data according to time column. Then extracts time and flux (or magnitude, luminosity etc.) columns from the input file, creates a new two-column data file and splits the new data file according to period value entered by the user. The script also asks minimum desired number which allows the user to select the sub-light curves having enough data points that are generally suitable for further analysis. This could be useful, for instance, when splitting a whole binary light curve into hundreds of sub-light curves to analyze and investigate them one-by-one.

- HOW TO RUN
The data file and the script (lcsplit.sh) must be put in the same directory. First, set the permission by typing:

chmod a+x lcsplit.sh

with the root privileges. Then run the script with:

./lcsplit.sh

in bash.

Depending on your entries, the sub-light curves are extracted in a folder named LightCurves created by the script.

The script asks the user:

1) "Name of the data file", when it expects that the user enters the name of the data file and hit the enter. It must be a tab delimited file.
2) "The column number of the time data" refers the column number containing the time data.
3) "The column number of the flux data" which refers the column number containing the flux (or magnitude, luminosity etc.) data.
4) "Period value", the value which bases the splitting process. The script cuts long data according to this value and it must be greater than zero.
5) "The minimum desired number of data points in each sub-light curve"; the script ignores the sub-light curves which do not contain the number of data points smaller than this value. Therefore, small values allow the script to create more sub-light curves.

- NOTES:
1) .tpl file extension is used by the script for the temporary lists and .slc file extension is used for sub-light curves. Therefore, it is adviced not to use these extensions as your data file extension to avoid it from removing or overwriting at the end of the run.
2) Re-running the script warns the user about removing the old sub-light curve folder called "LightCurves" (and "work" folder if exist). Take a backup or change the folder name if you believe that you need it.
3) Be sure that you can run AWK. If not, install it by following the installation procedure of your Linux distribution. (http://www.cs.princeton.edu/~bwk/btl.mirror/)
4) The columns in the data file must separaeted by tab delimiter in order to script runs without error message.  
4) The Line Feed (LF) type, which is widely used by Unix operating systems, works fine as the end of line control character of the data file while the other types may cause the script not to create temporary list files and finalize the process correctly.
5) A sample input file input.in (531009 lines, ~45 MB) can be downloaded from https://yadi.sk/d/_1AWYE5q3RjxMg. It was constructed by combining all short cadence data of KIC10661783 in fit files provided by MAST (https://archive.stsci.edu/kepler/data_search/search.php)
6) Check the related GitHub address for updated versions.

When used the script, you may want to give reference to its GitHub address: https://github.com/burakulas/lcsplit

For comments and further questions: bulash@gmail.com


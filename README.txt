 

LCSPLIT is a short bash script for splitting long two-column data into parts based on given period value. The original aim of the script is to split long astronomical data sets like Kepler light curve data of binary stars into several sub-light curves to investigate them separately. However, technically, it can be applied all time related two-column data by entering the appropriate period value. The code first sorts the long data and then split it according to period entered by the user. It also asks minimum desired number which allows the user to select the sub-light curves having enough data points that are generally suitable for further analysis. This could be useful, for instance, when splitting a whole binary light curve into hundreds of sub-light curves to analyze and investigate them one-by-one.

- HOW TO RUN
The user is advised to put the two-column data and the script (lcsplit.sh) in the same directory. First, set the permission by typing:

chmod a+x lcsplit.sh

with the root privileges. Then run the script with:

./lcsplit.sh

in bash.

Depending on your entries, the sub-lightcurves are extracted in a folder named LightCurves created by the script.

The script asks the user:

1) Name of the data file, when it expects that the user enters the name of the data file and hit the enter.
2) Period value, the value which bases the splitting process. The script cuts long data according to this value and it must be greater than zero.
3) The minimum desired number of data points in each sub-light curve; the script ignores the sub-light curves which do not contain the number of data points smaller than this value. Therefore, small values allow the script to create more sub-light curves.

- NOTES:
1) .tpl file extension is used by the script for the temporary lists and .scl file extension is used for sub-light curves. Therefore, it is adviced not to use these extensions as your data file extension to avoid it from removing or overwriting at the end of the run.
2) Re-running the script warns the user about removing the old sub-light curve folder. Take a backup or change the folder name if you believe that you need it.
3) The script runs without any problem in the following Linux distributions:
   . Ubuntu 16.04, 17.10
   . Fedora

When used you may want to refer the script by giving its GitHub address as the reference.

For comments and further questions: bulash@gmail.com


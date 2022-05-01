This requires the global file from here: https://github.com/smirarab/global

to be installed in order to run any of the measure scripts !

In addition in the command prompt or wherever make sure to set the following 
before running measure_all.sh/measure_st.sh/measure_app.sh or anything that 
uses compareTrees.missingBranch :

WS_HOME='./' ; export WS_HOME

where ./ is the directory containing the global file !

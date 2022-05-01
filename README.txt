This requires the global file from here: https://github.com/smirarab/global

to be installed in order to run any of the measure scripts !

In addition in the command prompt or wherever make sure to set the following 
before running measure_all.sh/measure_st.sh/measure_app.sh or anything that 
uses compareTrees.missingBranch :

WS_HOME='./' ; export WS_HOME

where ./ is the directory containing the global file !

I did not write many of these scripts but have them listed here together for
ease of use when testing the SCAMPP framework --

Proper attributions are below:
 nw_prune 
 nw_labels
 nw_topology  are all from newick utils: 
    https://github.com/tjunier/newick_utils
 
 faSomeRecords  is from kentUtils and can be found at: 
    https://github.com/ENCODE-DCC/kentUtils/blob/master/bin/linux.x86_64/faSomeRecords
 
 compareTrees.missingBrach
 CompareTree.pl 
 CompareToBootstrap.pl  are all from 
    https://github.com/smirarab/global/tree/master/src/shell
 
 measure_app.sh  is from the RNAsim variable_size datasets at 
    https://datadryad.org/stash/dataset/doi:10.5061/dryad.78nf7dq.
    The other measure scripts are modified from this. 
    
Dependencies for backbone.py and select_queries.py:
  TreeSwift: https://github.com/niemasd/TreeSwift

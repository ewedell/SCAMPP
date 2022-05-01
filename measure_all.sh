
#!/bin/bash
#$1 dir
#$2 backbone tree size
#$3 threads
#$4 query #


export dir=$1
export threads=$3


f() {
    query=$1
        if [ ! -f "${dir}/${query}/pplacer.tree" ] || [ ! -f "${dir}/${query}/pplacer-XR.tree" ] ; then
		n2=`compareTrees.missingBranch ${dir}/true_topo.tree <(nw_topology ${dir}/${query}/backbone_pp.tree) -simplify | awk '{printf $2}'`
	        echo ${query}

		if [ -f "${dir}/${query}/pplacer.jplace" ]; then
		        R1=${dir}/${query}/result_pplacer.csv
			echo -n "" > ${dir}/${query}/result_pplacer.csv
      	
	        	./guppy tog -o ${dir}/${query}/pplacer.tree ${dir}/${query}/pplacer.jplace
			n1=`compareTrees.missingBranch ${dir}/true_topo.tree <(nw_topology ${dir}/${query}/pplacer.tree) -simplify | awk '{printf $2}'`
		        ((n3=n1-n2))
		        python -c "print(\"%d,%s\"%($n3,\"${query}\"))" >> $R1
		else
			rm ${dir}/${query}/result_pplacer.csv
		fi
		if [ ! -f "${dir}/${query}/pplacer.tree" ]; then
			rm ${dir}/${query}/result_pplacer.csv
		fi
		if [ -f "${dir}/${query}/pplacer-XR.jplace" ]; then
		        R1=${dir}/${query}/result_pplacer-XR.csv
			echo -n "" > ${dir}/${query}/result_pplacer-XR.csv
    	
	        	./guppy tog -o ${dir}/${query}/pplacer-XR.tree ${dir}/${query}/pplacer-XR.jplace
			n1=`compareTrees.missingBranch ${dir}/true_topo.tree <(nw_topology ${dir}/${query}/pplacer-XR.tree) -simplify | awk '{printf $2}'`
		        ((n3=n1-n2))
		        python -c "print(\"%d,%s\"%($n3,\"${query}\"))" >> $R1
		else
			rm ${dir}/${query}/result_pplacer-XR.csv
		fi		
		if [ ! -f "${dir}/${query}/pplacer-XR.tree" ]; then
			rm ${dir}/${query}/result_pplacer-XR.csv
		fi
        fi
        if [ ! -f "${dir}/${query}/result_EPA-ng.csv" ] || [ ! -f "${dir}/${query}/result_EPA-ng-XR.csv" ] ; then
		n2=`compareTrees.missingBranch ${dir}/true_topo.tree <(nw_topology ${dir}/${query}/backbone_epa.tree) -simplify | awk '{printf $2}'`
		echo ${query}
                
		if [ -f "${dir}/${query}/epa_result.jplace" ]; then
	                R4=${dir}/${query}/"result_EPA-ng.csv"
	                echo -n "" > ${dir}/${query}/"result_EPA-ng.csv"
	                ./guppy tog -o ${dir}/${query}/"EPA-ng.tree" ${dir}/${query}/"epa_result.jplace"
	                n1=`compareTrees.missingBranch ${dir}/true_topo.tree <(nw_topology ${dir}/${query}/"EPA-ng.tree") -simplify | awk '{printf $2}'`
	                ((n3=n1-n2))
	                python -c "print(\"%d,%s\"%($n3,\"${query}\"))" >> $R4
	        else
	        	rm ${dir}/${query}/result_EPA-ng.csv		
	        fi
        	
		if [ ! -f "${dir}/${query}/EPA-ng.tree" ]; then
			rm ${dir}/${query}/result_EPA-ng.csv
		fi
		if [ -f "${dir}/${query}/EPA-ng-XR.jplace" ]; then
	                R4=${dir}/${query}/"result_EPA-ng-XR.csv"
	                echo -n "" > ${dir}/${query}/"result_EPA-ng-XR.csv"

	                ./guppy tog -o ${dir}/${query}/"EPA-ng-XR.tree" ${dir}/${query}/"EPA-ng-XR.jplace"
	                n1=`compareTrees.missingBranch ${dir}/true_topo.tree <(nw_topology ${dir}/${query}/"EPA-ng-XR.tree") -simplify | awk '{printf $2}'`
	                ((n3=n1-n2))
	                python -c "print(\"%d,%s\"%($n3,\"${query}\"))" >> $R4
	        else
	        	rm ${dir}/${query}/result_EPA-ng-XR.csv
		fi
		if [ ! -f "${dir}/${query}/EPA-ng-XR.tree" ]; then
			rm ${dir}/${query}/result_EPA-ng-XR.csv
		fi
	fi
        if [ ! -f "${dir}/${query}/APPLES-2.tree" ] ; then
		n2=`compareTrees.missingBranch ${dir}/true_topo.tree <(nw_topology ${dir}/${query}/backbone_app.tree) -simplify | awk '{printf $2}'`
		echo ${query}
                
		if [ -f "${dir}/${query}/APPLES-2.jplace" ]; then
	                R4=${dir}/${query}/"result_APPLES-2.csv"
	                echo -n "" > ${dir}/${query}/"result_APPLES-2.csv"
	                #./guppy tog -o ${dir}/${query}/"APPLES-2.tree" ${dir}/${query}/"APPLES-2.jplace"
			./gappa examine graft --jplace-path ${dir}/${query}/"APPLES-2.jplace" --out-dir ${dir}/${query} --allow-file-overwriting
			mv ${dir}/${query}/APPLES-2.newick ${dir}/${query}/APPLES-2.tree
	                n1=`compareTrees.missingBranch ${dir}/true_topo.tree <(nw_topology ${dir}/${query}/"APPLES-2.tree") -simplify | awk '{printf $2}'`
	                ((n3=n1-n2))
	                python -c "print(\"%d,%s\"%($n3,\"${query}\"))" >> $R4
	        else
	        	rm ${dir}/${query}/result_APPLES-2.csv
		fi
		if [ ! -f "${dir}/${query}/APPLES-2.tree" ]; then
			rm ${dir}/${query}/result_APPLES-2.csv
		fi
	fi
  }
  export -f f; xargs -P 6 -I@ bash -c 'f @' < ${dir}/queries.txt

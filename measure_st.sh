
#!/bin/bash
#$1 dir
#$2 backbone tree size
#$3 threads
#$4 query #


export dir=$1
export threads=$3


f() {
	query=$1
	n2=`compareTrees.missingBranch ${dir}/true_topo.tree <(nw_topology ${dir}/${query}/backbone_pp.tree) -simplify | awk '{printf $2}'`
	echo ${query}

	while read subtreeSize; do
	
		if [ ! -f "${dir}/${query}/result_pplacer-XR_${subtreeSize}.csv" ]; then
			#n2=`compareTrees.missingBranch ${dir}/true_topo.tree <(nw_topology ${dir}/${query}/backbone_pp.tree) -simplify | awk '{printf $2}'`
			#echo ${query}

			R1=${dir}/${query}/result_pplacer-XR_${subtreeSize}.csv
			echo -n "" > ${dir}/${query}/result_pplacer-XR_${subtreeSize}.csv
    	
			./guppy tog -o ${dir}/${query}/pplacer-XR_${subtreeSize}.tree ${dir}/${query}/pplacer-XR_${subtreeSize}.jplace
			n1=`compareTrees.missingBranch ${dir}/true_topo.tree <(nw_topology ${dir}/${query}/pplacer-XR_${subtreeSize}.tree) -simplify | awk '{printf $2}'`
			((n3=n1-n2))
			echo $n3
			python -c "print(\"%d,%s\"%($n3,\"${query}\"))" >> $R1
		fi
		if [ ! -f "${dir}/${query}/pplacer-XR_${subtreeSize}.tree" ]; then
			rm ${dir}/${query}/result_pplacer-XR_${subtreeSize}.csv
		fi
	done < ${dir}/subtreeSizes.txt
  }
  export -f f; xargs -P 6 -I@ bash -c 'f @' < ${dir}/queries.txt

import sys
import os
import treeswift

if __name__ == "__main__":
    tree_path = str(sys.argv[1])
    output = str(sys.argv[2])
    query_file = str(sys.argv[3])

    # tree, output, query

    tree = treeswift.read_tree_newick(tree_path)
    tree.deroot()
    
    removal_list = []   
    leaf_dict = tree.label_to_node(selection='leaves')  
    if '' in leaf_dict:
        removal_list.append('')
    
    with open(query_file, 'r') as queries:
       for query in queries:
           query = query.strip()
           if query in leaf_dict:
               removal_list.append(query)
    
    subtree = tree.extract_tree_without(removal_list, suppress_unifurcations=True)
    print(removal_list, subtree.num_nodes(leaves=True), tree.num_nodes(leaves=True))
    subtree.write_tree_newick(output, hide_rooted_prefix=True)
    
   

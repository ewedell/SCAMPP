
import sys
import os
import shutil
import json
import time
import argparse
import treeswift
import random

def main(args):
    output = args.output
    aln = args.alignment


    ref_dict = read_data(aln)
    seqs = list(ref_dict.keys())


    f = open(output, "w")
    for _ in range(200):
        seq = seqs.pop(random.randint(0,len(seqs)-1))
        f.write(seq+"\n")
    f.close()

def read_data(aln):
    """ Load the query and reference sequence from the alignment file
    
    Parameters
    ----------
    aln : multiple sequence alignment containing reference taxa and query sequence
    
    Returns
    -------
    dictionary containing sequences with taxon label keys
    
    """
    f = open(aln)
    result = dict()

    taxa = ""
    seq = ""
    for line in f:
        if line[0] == '>':
            if taxa != "":
                result[taxa] = seq
            taxa = line[1:-1]
            seq = ""

        elif line == "/n":
            continue
        else:
            seq += line[:-1]

    if taxa != "":
        result[taxa] = seq

    return result

    
def parseArgs():
    parser = argparse.ArgumentParser()
    
    parser.add_argument("-a", "--alignment", type=str,
                        help="Path for query and reference sequence alignment in fasta format", required=True, default=None)

    parser.add_argument("-o", "--output", type=str,
                        help="Output file name", required=False, default="./queries.txt")
    

    parser.add_argument("-v", "--version", action="version", version="1.0.0", help="show the version number and exit")
                       
    return parser.parse_args()

if __name__ == "__main__":
    main(parseArgs())

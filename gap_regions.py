"""
Adapted from solution in https://www.biostars.org/p/133742/
Parallelized by fasta record.
"""
import sys
import gzip
from Bio import SeqIO
from joblib import Parallel, delayed

def get_gap_regions(record):
    regions = []
    start_pos = 0
    counter = 0
    gap = False
    gap_length = 0
    for char in record.seq:
        if char == "N":
            if gap_length == 0:
                start_pos = counter
                gap_length = 1
                gap = True
            else:
                gap_length += 1
        else:
            if gap:
                regions.append([record.id, str(start_pos),
                                str(start_pos + gap_length)])
                gap_length = 0
                gap = False
        counter += 1
    return regions

if __name__ == "__main__":
    fasta = sys.argv[1]
    processes = int(sys.argv[2])
    with gzip.open(fasta, mode="rt") as fasta_handle:
        gap_regions = Parallel(n_jobs=processes)(delayed(get_gap_regions)(record)
            for record in SeqIO.parse(fasta_handle, "fasta"))
        for regions in gap_regions:
            for r in regions:
                print('\t'.join(r))

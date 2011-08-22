from mwmatching import maxWeightMatching
import fileinput

edges = []
for line in fileinput.input():
  e = line.rstrip('\r\n').split(" ")
  edges.append([ int(e[0]), int(e[1]), int(e[2]) ])

# negate the edge weights to get minimum weight perfect matching
neg_edges = [(i,j,-wt) for i,j,wt in edges]

# Return a list "mate", such that mate[i] == j if vertex i is matched to
# vertex j, and mate[i] == -1 if vertex i is not matched.
match = maxWeightMatching(neg_edges, maxcardinality=True)

# print "the match has the following edges:"
x = 0
for e in match:
  print str(x), str(e)
  x = x + 1

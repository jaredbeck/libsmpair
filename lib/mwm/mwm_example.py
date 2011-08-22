from mwmatching import maxWeightMatching

"""
Given the following example graph with 4 vertices,

v0----1----v2
|\        /|
|  3    /  |
2    \/    2
|   3  \   |
| /      \ |
v1----1----v3

the obvious minimum weight perfect matching is:
v0 to v2 with weight of 1
v1 to v3 with weight of 1
"""

edges = []
edges.append([0, 2, 1])
edges.append([1, 3, 1])
edges.append([0, 1, 2])
edges.append([2, 3, 2])
edges.append([0, 3, 3])
edges.append([1, 2, 3])

# negate the edge weights to get minimum weight perfect matching
neg_edges = [(i,j,-wt) for i,j,wt in edges]

# Return a list "mate", such that mate[i] == j if vertex i is matched to
# vertex j, and mate[i] == -1 if vertex i is not matched.
match = maxWeightMatching(neg_edges, maxcardinality=True)

match_wt_sum = sum([wt for (i,j,wt) in edges if match[i] == j])
print "match weight sum is " + str(match_wt_sum)

print "the match has the following edges:"
x = 0
for e in match:
  print str(x), str(e)
  x = x + 1



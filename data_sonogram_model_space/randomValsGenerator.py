import numpy as np
import pandas as pd

randomVals = []

for x in range(1, 100):
    randomVals.append(np.random.randint(0,100))

for x in randomVals:
    x = int(x)

randomVals
# flat_list = []
# for sublist in randomVals:
#     for item in sublist:
#         flat_list.append(item)
#
# flat_list

np.savetxt("data.csv", randomVals, delimiter=",", fmt="%s")

# %%

df = pd.read_table('../data/extent_n_19720101-20181231_amsr2.txt', delim_whitespace=True, names=('A', 'B', 'C', 'D'))

df
df['D'].to_csv('output.csv')

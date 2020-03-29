import pandas as pd
import numpy as np

# %% prepare data: export extent column from dataset
headers = ['year', 'month', 'day', 'extent']

data = pd.read_table('extent_n_19720101-20181231_amsr2.txt',
                     delim_whitespace=True, names=headers)
print(data)
data.extent.size

# %%
# sample_data = data.extent.sample(n=1).iloc[0]
max_val = max(data.extent)  # 16698700.0
min_val = min(data.extent)  # 3274138.0
diff = max_val - min_val

normalized_data = (data.extent - min_val) / diff
print(normalized_data)

np.savetxt('normalizedExtentOnly_n_19720101-20181231_amsr2.txt',
           normalized_data, fmt="%1.12f")

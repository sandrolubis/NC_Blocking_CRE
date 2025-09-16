from matplotlib import pyplot as plt
import seaborn as sns
import numpy as np
import xarray as xr
import pandas as pd
import cftime

plt.rcParams['font.family'] = 'Halvetica'

sns.set_style('white')
iris = xr.open_dataset('../../NatComm_CRE_Bocking_Lubis/Figure1/data-diff_box_Euro.nc')
diff = iris['euro']
df = diff.to_dataframe().reset_index()
df['name'] = np.where(df['model'] == 1, 'CLOCK - CTL', 'LWOFF - CTL')
print(df)

plt.figure(figsize=(6, 8))

palette = 'Set2'
ax = sns.violinplot(x="name", y="euro", data=df, hue="model", dodge=False,
                    palette=palette,
                    scale="width", inner=None)
xlim = ax.get_xlim()
ylim = ax.get_ylim()
for violin in ax.collections:
    bbox = violin.get_paths()[0].get_extents()
    x0, y0, width, height = bbox.bounds
    violin.set_clip_path(plt.Rectangle((x0, y0), width / 2, height, transform=ax.transData))

old_len_collections = len(ax.collections)
sns.stripplot(x="name", y="euro", data=df, hue="model", palette=palette, dodge=False, size=2., ax=ax)
for dots in ax.collections[old_len_collections:]:
    dots.set_offsets(dots.get_offsets() + np.array([0.12, 0]))
    
sns.boxplot(x="name", y="euro", data=df, saturation=1, showfliers=False,
            width=0.3, boxprops={'zorder': 3, 'facecolor': 'none'}, ax=ax)
    
ax.set_xlim(xlim)
ax.set_ylim(-10, 4)
ax.axhline(y=0, color='black', linestyle='--', linewidth=1)

ax.set_title('(a) Euro-Atlantic Sector', fontsize=20)
ax.set_xlabel('')
ax.set_ylabel('Changes in Blocked days (%)', fontsize=20)
ax.tick_params(axis='both', which='major', labelsize=17)
ax.legend_.remove()

grouped_means = df.groupby(['name', 'model'])['euro'].mean().reset_index()
for i, row in grouped_means.iterrows():
    x = row['name']
    hue = row['model']
    y = row['euro']
    
    hue_offset = 0 if hue == '1' else 0.2  
    pos = list(df['name'].unique()).index(x)
    
    ax.plot(pos, y, 'X', color='black', markersize=15, label='Mean' if i == 0 else "", zorder=5)
ax.set_aspect(aspect='auto', adjustable='datalim')
ax.set_box_aspect(1.8)

plt.savefig("dots_euro_15yr.pdf", format='pdf')
#plt.show()

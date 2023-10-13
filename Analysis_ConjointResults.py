# -*- coding: utf-8 -*-
"""
Created on Tue Apr 11 09:47:12 2023

@author: penpo
"""
import pandas as pd
import matplotlib.pyplot as plt



df=pd.read_csv('Analyse.csv')


#display settings
pd.options.display.max_rows = None
pd.options.display.max_columns = None


#interpret clsuters
df.groupby('Clusters').mean() 

c1 = df.loc[df['Clusters']==1]
c1.describe()
#min age is 20 and max age is 70
above_60_percentage = (c1['Age'] > 60).mean() * 100
#about 19% people are above age 60
#9 out of 21 ar related to internet/computer

cluster_1_df = df[df['Clusters'] == 1]
occupation_cluster_1 = cluster_1_df['Occupation']

columns_to_drop = ['Notice a pop-up what do you do','New signup option', 'Gender', 'Occupation']
cluster_1_df.drop(columns=columns_to_drop, inplace=True)

avg_values = cluster_1_df.mean()
min_values = cluster_1_df.min()
max_values = cluster_1_df.max()

# Create a new dataframe to store the results
result_df = pd.DataFrame({'Average': avg_values, 'Minimum': min_values, 'Maximum': max_values})

# Save the result dataframe to an Excel file
result_df.to_excel('c1_result.xlsx', index=False)

c2 = df.loc[df['Clusters']==2]
c2.describe()
#age is 21 to 80

c2.drop(columns=columns_to_drop, inplace=True)
avg_values = c2.mean()
min_values = c2.min()
max_values = c2.max()

# Create a new dataframe to store the results
result_df = pd.DataFrame({'Average': avg_values, 'Minimum': min_values, 'Maximum': max_values})

# Save the result dataframe to an Excel file
result_df.to_excel('c2_result.xlsx', index=False)


c3 = df.loc[df['Clusters']==3]
c3.describe()
#age range is 19 to 64

c3.drop(columns=columns_to_drop, inplace=True)
avg_values = c3.mean()
min_values = c3.min()
max_values = c3.max()

# Create a new dataframe to store the results
result_df = pd.DataFrame({'Average': avg_values, 'Minimum': min_values, 'Maximum': max_values})

# Save the result dataframe to an Excel file
result_df.to_excel('c3_result.xlsx', index=False)


cluster_3_df = df[df['Clusters'] == 3]
occupation_cluster_3 = cluster_3_df['Occupation']
#17 out of 23 have occupation not related to internet /computer

c4 = df.loc[df['Clusters']==4]
c4.describe()
#age range is 20 to 58

c4.drop(columns=columns_to_drop, inplace=True)
avg_values = c4.mean()
min_values = c4.min()
max_values = c4.max()

# Create a new dataframe to store the results
result_df = pd.DataFrame({'Average': avg_values, 'Minimum': min_values, 'Maximum': max_values})

# Save the result dataframe to an Excel file
result_df.to_excel('c4_result.xlsx', index=False)




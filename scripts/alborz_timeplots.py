import pandas as pd
import matplotlib.pyplot as plt

# Load the CSV and parse 'Time' as datetime
path = 'C:\\Users\\Piyus\\OneDrive\\Desktop\\Alborz_project\\Third_casestudy\\Thirdcase_oigg.csv'

df = pd.read_csv(path)

# Replace underscore with space and parse the datetime
df['Time'] = pd.to_datetime(df['Time'].str.replace('_', ' '))

# Sort just in case
df = df.sort_values('Time')

# Example: plot air temperature (T2) and dewpoint (TD2)
plt.figure(figsize=(10, 5))
plt.plot(df['Time'], df['WD10'], label='T2 (°C)',
         color='royalblue', linewidth=2)
# plt.plot(df['Time'], df['TD2'], label='TD2 (°C)',
#         color='royalblue', linewidth=2)

plt.title('10m Wind Direction Over Time (OIGG)', fontsize=14)
plt.xlabel('Time (UTC)', fontsize=12)
plt.ylabel('Wind direction (°)', fontsize=12)
plt.grid(True, linestyle='--', alpha=0.6)
# plt.legend()
plt.tight_layout()
plt.show()

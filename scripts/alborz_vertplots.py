import pandas as pd
import matplotlib.pyplot as plt

# Load the CSV and parse 'Time' as datetime
df = pd.read_csv(
    'C:\\Users\\Piyus\\OneDrive\\Desktop\\Alborz_project\\Third_casestudy\\kerman31th_profile.csv')

# --- Plot Wind Speed profile ---
plt.figure(figsize=(7, 8))
plt.plot(df["Td(C)"], df["Z(m)"], color="tomato", linewidth=2)

# --- Labels and style ---
plt.xlabel("Dewpoint Temperature (C)")
plt.ylabel("Log Scale for Height (m)")
# plt.yscale("symlog", linthresh=5000)
plt.yscale("log")

# Define custom tick marks for clarity
tick_vals = [1200, 2000, 3000, 4000, 5000, 6000, 7000,
             10000, 12000, 15000, 17000, 20000, 23000, 26000]
plt.yticks(tick_vals, [str(v) for v in tick_vals])

# plt.ylim(1200, 10000)
plt.title(
    "Kermanshah on 31st 00Z\nVertical Profile of Dewpoint Temperature", fontsize=11)
plt.grid(True, which="both", linestyle="--", alpha=0.6)

plt.show()

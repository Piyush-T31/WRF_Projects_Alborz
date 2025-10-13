import pandas as pd
import matplotlib.pyplot as plt

# Load the CSV and parse 'Time' as datetime
df = pd.read_csv("kerman17th_profile.csv")

# --- Plot Wind Speed profile ---
plt.figure(figsize=(7, 8))
plt.plot(df["WD(deg)"], df["Z(m)"], color="navy", linewidth=2)

# --- Labels and style ---
plt.xlabel("Wind Direction (deg)")
plt.ylabel("Log Scale for Height (m)")
# plt.yscale("symlog", linthresh=5000)
plt.yscale("log")

# Define custom tick marks for clarity
tick_vals = [1200, 2000, 3000, 4000, 5000, 6000, 7000,
             10000, 12000, 15000, 17000, 20000, 23000, 26000]
plt.yticks(tick_vals, [str(v) for v in tick_vals])

# plt.ylim(1200, 10000)
plt.title(
    "Kermanshah on 17th 00Z\nVertical Profile of Wind Direction", fontsize=11)
plt.grid(True, which="both", linestyle="--", alpha=0.6)

plt.show()

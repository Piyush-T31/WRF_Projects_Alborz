
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from metpy.plots import SkewT
from metpy.units import units
import metpy.calc as mpcalc

# --- Load your data ---
df = pd.read_csv("kerman15th_profile.csv")

# --- Convert height (Z) to pressure (approximation) ---
df['Pressure'] = 1013.25 * (1 - 2.25577e-5 * df['Z(m)']) ** 5.2559

# --- Extract variables ---
p = df['Pressure'].values * units.hPa
T = df['T(C)'].values * units.degC
Td = df['Td(C)'].values * units.degC
ws = df['WS(knots)'].values * units.knots
wd = df['WD(deg)'].values * units.degrees

# --- Convert wind speed/direction to u/v components ---
u, v = mpcalc.wind_components(ws, wd)

# --- Create Skew-T plot ---
fig = plt.figure(figsize=(7, 7))
skew = SkewT(fig, rotation=45)

# --- Plot data ---
skew.plot(p, T, 'r', label='Temperature')
skew.plot(p, Td, 'g', label='Dewpoint')
skew.plot_barbs(p[::3], u[::3], v[::3])

# --- Set limits ---
skew.ax.set_ylim(1000, 50)    # adjust depending on your vertical range
skew.ax.set_xlim(-40, 40)

# --- Add dry/moist adiabats and mixing ratio lines ---
skew.plot_dry_adiabats()
skew.plot_moist_adiabats()
skew.plot_mixing_lines()

plt.title("Skew-T Log-P Diagram at Kermanshah (14 Jan 00Z)")
plt.legend(loc='best')
plt.show()

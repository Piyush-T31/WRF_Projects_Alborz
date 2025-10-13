# Investigating Foehn Winds over the Alborz Mountains

## 🌄 Project Overview
This project investigates **foehn wind events** over the **Alborz Mountains, Iran**, using the **Weather Research and Forecasting (WRF)** model.  
The objective is to understand the **mechanisms and local impacts** of foehn winds, including their relationship with mountain topography, temperature gradients, and wind flow structure.

---

## 🧭 Methodology

### 1. Topography Setup
- A high-resolution **Digital Elevation Model (DEM)** was used to represent the complex terrain of the Alborz region.  
- The processed terrain data was visualized using WRF output variables (e.g., `ter`).  
- Below is an example of the topography from the innermost domain (`d03`), with the selected cross-section line marked for vertical analysis:

![Topography and Cross Section](images/wrf_topo2.png)

---

### 2. Model Configuration
The simulations were conducted using **WRF v4.7.1**.

#### Simulation Setup
- **Domains:** 3 nested domains (`d01` → `d02` → `d03`)
- **Resolution:** 9 km → 3 km → 1 km  
- **Vertical levels:** 50  
- **Physics options:**
  - Microphysics: WSM6 scheme  
  - Cumulus parameterization: Kain–Fritsch (outer domains only)  
  - Planetary Boundary Layer: YSU scheme  
  - Land Surface Model: Noah LSM  
  - Radiation: RRTMG shortwave and longwave schemes  

#### Case Studies
Four case studies were selected based on observed foehn events.  
The **first case** runs from **January 13th 2021, 12 UTC** to **January 16th 2021, 12 UTC**.

---

### 3. Diagnostics and Visualization
- Vertical cross-sections of wind speed, temperature, and potential temperature were extracted using **NCL** (`wrf_user_vert_cross`).
- Height profiles at specific locations (e.g., **Kermanshah**) were generated from model output using NCL and plotted in Python.
- Example outputs include:
  - Vertical cross-sections of wind and temperature along a transect.
  - Time series and vertical profiles of thermodynamic variables.

---

## ⚙️ Tools and Environment
- **WRF v4.7.1**
- **NCL 6.6.2** – for diagnostics and plotting
- **Python 3.11 (Matplotlib, Pandas, NumPy)** – for post-processing
- **VS Code + WSL2** – workflow environment
- **DEM Source:** SRTM 30m (resampled for model grid)

---

## 📊 Example Output

![Vertical Cross Section](images/vert_cross_example.png)
![Temperature Profile](images/vertical_profile_kerman.png)

---

## 🧩 Next Steps
- Analyze remaining three case studies.  
- Compare modeled foehn events with observed station data (temperature, wind, RH).  
- Quantify the strength and frequency of downslope warming.

---

## 📁 Repository Structure

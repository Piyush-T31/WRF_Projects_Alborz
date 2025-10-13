import rasterio
import matplotlib.pyplot as plt
import numpy as np
from matplotlib.colors import LightSource

dem_path = "Copernicus_Alborz.tif"

with rasterio.open(dem_path) as src:
    dem = src.read(1)
    extent = (src.bounds.left, src.bounds.right,
              src.bounds.bottom, src.bounds.top)
    nodata = src.nodata

# Replace nodata with NaN
dem = np.where(dem == nodata, np.nan, dem)

# --- Basic DEM plot ---
plt.figure(figsize=(10, 8))
plt.imshow(dem, cmap="terrain", extent=extent)
plt.colorbar(label="Elevation (m)")
plt.title("Copernicus GLO-30 DEM – Alborz Mountains")
plt.xlabel("Longitude")
plt.ylabel("Latitude")

# Save instead of show
plt.savefig("Alborz_DEM.png", dpi=300, bbox_inches="tight")
plt.close()

# --- Hillshade plot ---
ls = LightSource(azdeg=315, altdeg=45)
hillshade = ls.shade(dem, cmap=plt.cm.terrain,
                     vert_exag=1, blend_mode="overlay")

plt.figure(figsize=(10, 8))
plt.imshow(hillshade, extent=extent)
plt.title("Hillshaded DEM – Alborz Mountains")
plt.colorbar(label="Elevation (m)")
plt.xlabel("Longitude")
plt.ylabel("Latitude")

plt.savefig("Alborz_Hillshade.png", dpi=300, bbox_inches="tight")
plt.close()

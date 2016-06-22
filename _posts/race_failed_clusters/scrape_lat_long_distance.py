
# import libraries and geocoders lat/long finder
import pandas as pd
from geopy.geocoders import Nominatim; geolocator = Nominatim()
from geopy.distance import vincenty

# load data
#df = pd.read_csv("city_state_data.csv")
df = pd.read_csv("python_returned.csv", sep=";")

# find approx. race centers
loc_parkway = (geolocator.geocode("Kansas City, MO").latitude, geolocator.geocode("Kansas City, MO").longitude)
loc_garmin = (geolocator.geocode("Olathe, KS").latitude, geolocator.geocode("Olathe, KS").longitude)
loc_cows = (geolocator.geocode("Bucyrus, KS").latitude, geolocator.geocode("Bucyrus, KS").longitude)

# initiate (approximate) distance from race centers
df['Dist_Parkway'] = 0.0
df['Dist_Garmin'] = 0.0
df['Dist_Cows'] = 0.0

# find approximate lat/long for each runner
for i in range(0, len(df)):
    location = geolocator.geocode(df['Actual'][i]) ##Tagging
    df['Lat'][i] = location.latitude
    df['Long'][i] = location.longitude
    
# find distance from each race
for i in range(0, len(df)):
    loc_point = str(df.loc[i,'Lat']) + "," + str(df.loc[i,'Long'])
    df.loc[i,'Dist_Parkway'] = vincenty(loc_point, loc_parkway).miles
    df.loc[i,'Dist_Garmin'] = vincenty(loc_point, loc_garmin).miles
    df.loc[i,'Dist_Cows'] = vincenty(loc_point, loc_cows).miles
    del(loc_point)

# save out
df.to_csv("python_returned.csv")


function dist = distanceInKmBetweenEarthCoordinates(lat1_in, lon1_in, ...
    lat2_in, lon2_in)
% dist = distanceInKmBetweenEarthCoordinates(lat1_in, lon1_in, lat2_in, lon2_in)
% Inputs:
% lat1_in = latitude array for coordinates pt1
% lon1_in = longitude array for coordinates pt1
% lat2_in = latitude array for coordinates pt2
% lon2_in = longitude array for coordinates pt2
% Outputs:
% dist    = distance between pts in km
% Info:
% By: Matthew Luu 
% Last edit: 10/7/2020
 
%Begin Code:
  earthRadiusKm = 6371;
  lat1 = lat1_in(3)/(60*60) + lat1_in(2)/(60) + lat1_in(1);
  lon1 = lon1_in(3)/(60*60) + lon1_in(2)/(60) + lon1_in(1);
  lat2 = lat2_in(3)/(60*60) + lat2_in(2)/(60) + lat2_in(1);
  lon2 = lon2_in(3)/(60*60) + lon2_in(2)/(60) + lon2_in(1);
  
  dLat = deg2rad(lat2-lat1);
  dLon = deg2rad(lon2-lon1);
  
  lon1 = deg2rad(lon1);
  lon2 = deg2rad(lon2);
  lat1 = deg2rad(lat1);
  lat2 = deg2rad(lat2);

  a = sin(dLat/2) * sin(dLat/2) + ... 
          sin(dLon/2) * sin(dLon/2) * cos(lat1) * cos(lat2); 
  c = 2 * atan2(sqrt(a), sqrt(1-a)); 
  dist = earthRadiusKm * c;
end
# Ignis


![IMG_5826](https://github.com/heidischultz/Ignis/assets/99668295/80cbf587-e193-4df6-a7f1-69e1bb444c2d)



Ignis is a mobile app designed to assist people detect and track wildfires while promoting fire safety. By acting as a centralized hub, Ignis notifies users of potential wildfire threats to their home. Additionally, Ignis offers a fire plan feature that provides a secure space for families and loved ones to collaborate on fire safety planning. Ignis uses a physics-driven algorithm that issues a percentage chance on whether an address will be impacted, helping users make informed decisions quickly. Ignis provides customized information on fire risks and safety measures based on the user's location.


## Fire Prediction Algorithm Diagrams
*(Ignis1/Erra/Views/Components /PredictionAlgorithm .swift)*


![2mi](https://github.com/heidischultz/Ignis/assets/99668295/8cce7357-5b21-43bc-8d9d-11c25a342830)


 
- isWithinCircle() iterates through each fire's latitude and longitude in the old fire dataset (which is 2 hours old) and creates a 2-mile radius circle around each of these fire locations.

- Subsequently, the function checks for any coordinates in the new fire dataset that fall within the defined 2-mile interaction threshold of every old fire.

- If another, new, fire is found within this interaction threshold, the function calculates the distance between the two fires. If there is no change in the movement of a fire, it returns a distance of 0.0.

- After determining the distance, the function "draws" a vector from the old fire location to the new fire location. This line extends 50 miles past the new fire location.

- A cone is then formed with a radius of 20 miles and a height of 50 miles. The tip of the cone is positioned at the same angle as the vector drawn from the old fire location to the new fire location, with the tip of the cone touching the new fire location. This arrangement ensures that the cone encompasses the area where the fire may potentially spread, with its tip aligned to the direction of fire movement from the old fire location to the new fire location.

- Then isAddressWithinCone() checks whether the user's address falls within the cone. If the address is within the cone, it calculates a percentage risk based on the distance of the address from the tip of the cone.

 **DISCLAIMER**
 I have been constantly tweaking my code and adding new features, so as of now, the calculation of percentage risk has some bugs. However, I plan on continuing to improve/fix my code
 
## Fire Prediction Flow Chart
While reading the flow chart, keep in mind:
- **"fires"** is the JSON node that all of the newly fetched fires are stored under
- **"fires1"** is the JSON node that all of the 2-hour-old fetches fires are stored under
- **New fire** refers to any fire that is in the "fires" node
- **fireLocations[]** is an array with all of the latitudes and longitudes of every fire stored in *"fires"*
- **fireLocations1[]** is an array with all of the latitudes and longitudes of every fire stored in *"fires1"*



![okokokokt](https://github.com/heidischultz/Ignis/assets/99668295/7346a935-293f-4fa8-9de2-13c0455b5371)



## Built With

* [Swift/SwiftUI](https://www.swift.org/) - Backend/Frontend Language
* [Python](https://www.python.org/) - Backend language
* [NASA FIRMS API](https://firms.modaps.eosdis.nasa.gov/api/) - Wildfire data source 
* [MapKit](https://developer.apple.com/documentation/mapkit/) - Map Framework
* [Firebase Firestore](https://firebase.google.com/docs/firestore) - Cloud database used for storing user info/authentication
* [Firebase Realtime](https://firebase.google.com/docs/database) - Cloud realtime database used for storing API data
* [Google Cloud Functions](https://cloud.google.com/functions#) - Cloud functions used for deploying/scheduling reoccurring API call
* [CoreLocation](https://developer.apple.com/documentation/corelocation) - Geocoding
* [Foundation](https://developer.apple.com/documentation/foundation) - Base Framework
* [UIKit](https://developer.apple.com/documentation/uikit) - Frontend Framework
* [Requests](https://pypi.org/project/requests/) - HTTP requests Python library
* [Csv](https://docs.python.org/3/library/csv.html) - CSV tools, standard Python library
* [JSON](https://docs.python.org/3/library/json.html) - JSON tools, standard Python library


## Contributors 

Kush Mirchandani - UI, design, and geocoding help

## Acknowledgments

*Melissa Fernandez
*Swiftful Thinking Youtube Tutorials
*Sean Alan Youtube YouTube Tutorials
*StackOverFlow









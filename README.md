# Ignis

Hello MIT Maker Portfolio reader(s)!

This is a copy of the explanation of the fire prediction algorithim (Ignis1/Erra/Views/Components /PredictionAlgorithm .swift):

 
 This is how the algorithim works:
 
 - isWithinCircle (function) iterates through each fire's latitude and longitude in the old fire dataset (2 hours old) and draws a circle with a 2mi radius around it.
 - Then the same function searches for any coordinate in the new fire dataset that falls within the defined 2mi interaction threshold
 - If there is another fire within the interaction threshold, the distance between the two fires is returned. If there is no change in the movement of a fire, 0.0 is returned
 
 - Next, a line is "drawn" from the old fire location to the new fire location. This line then continues past the new fire location by 50 miles
 - A cone is then made with a radius of 20 mi and height of 50 mi
 - If the address falls within that cone, then a percentage risk is assigned based of how far the address is from the tip of the cone.
 
 
 **DISCLAIMER**
 I have been constantly tweaking my code and adding new features, so as of now, the calculation of percentage risk has some bugs. However, I plan on continuing to improve/fix my code
 



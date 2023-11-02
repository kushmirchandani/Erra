# Ignis

One Paragraph of project description goes here

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

What things you need to install the software and how to install them

```
Give examples
```

### Installing

A step by step series of examples that tell you how to get a development env running

Say what the step will be

```
Give the example
```

And repeat

```
until finished
```

End with an example of getting some data out of the system or using it for a little demo

## Running the tests

Explain how to run the automated tests for this system

### Break down into end to end tests

Explain what these tests test and why

```
Give an example
```

### And coding style tests

Explain what these tests test and why

```
Give an example
```

## Deployment

Add additional notes about how to deploy this on a live system

## Built With

* [Dropwizard](http://www.dropwizard.io/1.0.2/docs/) - The web framework used
* [Maven](https://maven.apache.org/) - Dependency Management
* [ROME](https://rometools.github.io/rome/) - Used to generate RSS Feeds

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags). 

## Authors

* **Billie Thompson** - *Initial work* - [PurpleBooth](https://github.com/PurpleBooth)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Hat tip to anyone whose code was used
* Inspiration
* etc

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
 



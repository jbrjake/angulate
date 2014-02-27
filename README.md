angulate
========

Finding common ground

Map multiple positions, find the shortest paths between them, and identify the center point by temporal distance.

Features
--------

* Display a map view
* Accept a single POI
* Display POI in map view
* Accept multiple POI
* Display multiple POI in map view
* Support rearranging POI
* Identify routes between POI in arrangement order 
* Display routes between POI
* Identify the point closest to all POI (center point)
	* Raw distance
	* Distance by car or foot
	* Time by car or foot

Architecture
------------

* Point
	* Location
	
* PointController
	* Points
	* Routes
	* Center
		
Logic
-----

1. Find the geographic center point
2. Find the mean and median time from centerpoint to endpoints, use as the default scores
3. Find the greatest geographic distance between any two points
4. Make a box of the points +- half that geographic distance from the midpoint
5. If the mean and median times from any of those box endpoints is lower than the center score, use that as a new center and repeat
6. When the times from the center are lower, then repeat with a box a quarter of the geographic distance
7. Repeat, reducing the size of the geographic distance box, until the scores stop improving.
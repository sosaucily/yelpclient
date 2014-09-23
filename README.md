Yelp Client
==============

![Alt text](./yelp.gif?raw=true "Optional Title")

Project Requirements
Search results page
* Table rows should be dynamic height according to the content height
* Custom cells should have the proper Auto Layout constraints
* Search bar should be in the navigation bar (doesn't have to expand to show location like the real Yelp app does).

Filter page. Unfortunately, not all the filters are supported in the Yelp API.
* The filters you should actually have are: category, sort (best match, distance, highest rated), radius (meters), deals (on/off).
* The filters table should be organized into sections as in the mock.
* You can use the default UISwitch for on/off states. Optional: implement a custom switch
* Categories should show a subset of the full list with a "See All" row to expand.  When changing the sort method, this updates the results.
* Clicking on the "Search" button should dismiss the filters page and trigger the search w/ the new filter settings.

The only missing feature: Radius filter should expand as in the real Yelp app.  I'm not exactly sure what this was, but I believe I captured the spirit of this feature.  Let me know if there is anything else.

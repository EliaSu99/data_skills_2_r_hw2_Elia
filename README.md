# Data Skills 2 - R
## Autumn Quarter 2022

## Homework 2
## Due: Sunday October 23rd before midnight on GitHub Classroom

__Question 1 (10%):__ Complete the final project quiz on Canvas.  Full points for answering the questions with anything of substance.  Note that your ideas can evolve as we approach the project presentations.

__Question 2 (40%):__ For this question, you will be using the City of Chicago [Data Portal](https://data.cityofchicago.org) to create a choropleth using the ggplot and sf libraries.  You should:
  * Download two [datasets](https://data.cityofchicago.org/browse?limitTo=datasets) that interest you
  * Download one or more [shapefiles](https://data.cityofchicago.org/browse?tags=shapefiles)

Do not use the Major Streets shapefile, since we will use it in question 3.  Use this to create two choropleths, one for each data file.  At a minimum you should use the "fill" aes in ggplot to color based on your selected data, but you are free to use others as well.  Include 2-4 sentences in a comment describing what research question your choropleths begin to address or display.

Effort to improve the appearnce of your plots relative to the default will be rewarded, as will proper usage of tidyverse style, and loops/containers/functions should they be appropriate for your code.

Save this code as "question_2.R", and include your downloads from the Data Portal in your repo.  Save your choropleths as .png files and commit them as well.

__Question 3 (40%):__ Using what you created for question 2, convert it into a Shiny app.  Allow at least two elements to be controlled in the UI.  Then add the option to toggle streets on and off in your choropleth, using the [Major Streets shapefile](https://data.cityofchicago.org/Transportation/Major-Streets/ueqs-5wr6).  

Save this code as "app.R", and include the Major Streets shapefile in your repo.

__Question 4 (10%):__ Create a free account on [shinyapps.io](https://www.shinyapps.io/) and upload your app.R file and data files from question 3 to it.  Check that the url it generates is working, and include the url to your Shiny app in a comment at the top of your app.R file.

General note: Mind the size of the data you pick, particularly the shapefiles.  If it becomes quite large you may have issues comitting it to GitHub or uploading it to the shinyapps.io website, so lower resolution is generally preferred, and test the upload steps early.

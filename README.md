# Movie Search App

## Overview
The Movie Search App allows users to search for movies by title and view detailed information about each movie. 
The app follows a Clean Architecture approach, uses PromiseKit for handling asynchronous tasks, and is covered by Unit Tests.

## Features
  Search for Movies: Users can search for movies by title.

  View Top Rated Movies: Displays a list of top-rated movies.

  Detailed Movie Information: Each movie item displays details such as title, rating, release date, and overview.

  Error Handling: Users are informed when no results are found or if an error occurs during the search process.

## Architecture
  This app uses Clean Architecture, a software design pattern that divides the app into layers for better separation of concerns and maintainability. The primary layers of the app are:

  ### Presentation Layer:

  Contains ViewControllers and ViewModels.

  Responsible for user interaction and displaying data.

  ### Domain Layer:

  Contains business logic.

  Includes the UseCases that retrieve movies either by search or by top-rated list.

  ### Data Layer:

  Handles data retrieval and parsing.

  Contains Repositories and NetworkClient that interact with external data sources (.. an API).

  ### Model Layer:

  Handles Data Type Objects and its mapping to response object.

  ### Utilities:

  Helper functions giving Constants, ErrorHandling, Loggers, Image Handling.
  

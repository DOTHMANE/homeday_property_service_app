# Property Service API

This is a Ruby on Rails API-based property service that provides functionality to search and retrieve properties. The service returns similar properties within a 5km radius based on parameters such as latitude, longitude, property type, and marketing type. It uses PostgreSQL with the PostGIS extension for geospatial data handling.

## Features

- **Property Search:** Search for properties based on various filters, including property type and location.
- **Geospatial Search:** Calculate distances between properties using the PostGIS extension and the `earthdistance` module.

## Technologies Used

- **Ruby on Rails API **
- **PostgreSQL** with **PostGIS** and **earthdistance** extensions

## Installation

### Requirements

- Ruby 3.3.0
- Rails 7.2.2

### Steps

1. Clone the repository:

   ```bash
   git clone https://github.com/DOTHMANE/homeday_property_service_app.git
   cd homeday_property_service_app

2. Install dependencies:
   ```bash
   bundle install


3. Set up the database:
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed

4. Start the Rails server:
   ```bash
   rails serve

5. Property Search:
   ```bash
   GET /properties/similar
   Query parameters:
   latitude (required): Latitude of the location.
   longitude (required): Longitude of the location.
   property_type (required): Type of property (e.g., apartment, house).
   marketing_type (required): Marketing type (e.g., sell, rent). 
   radius (optional): to change the radius
   page: to navigate through th pages
   
6. Running Tests:
   ```bash
   rails db:migrate RAILS_ENV=test (in case it didn't run)
   rspec

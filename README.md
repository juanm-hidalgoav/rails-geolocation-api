
# **Geolocation API Project**

## **Overview**

This project is a Ruby on Rails-based API that provides geolocation functionality. The API allows you to store, retrieve, and manage geolocation data based on IP addresses. It is built with a focus on modularity and extensibility, using best practices like service-oriented architecture and RESTful API design. This project is designed with scalability and modularity in mind. By separating the concerns into models, services, and controllers, it allows for easy maintenance and future extensions. The application is ready to handle geolocation data securely and efficiently, providing a solid foundation for building more complex features on top of it.

### **Key Features:**

- **Geolocation Management:** Store and retrieve geolocation data based on IP addresses.
- **API Key Management:** Secure API endpoints with API keys that can be created, revoked, and managed.
- **User Management:** Create and manage users who are associated with API keys.
- **Country and Region Normalization:** Associate geolocations with specific countries and regions for easier data organization.

## **Table of Contents**

1. [Installation](#installation)
2. [Usage](#usage)
3. [Controllers](#controllers)
4. [Services](#services)
5. [Models](#models)
6. [Testing](#testing)

## **Installation**

### **Prerequisites:**

- Ruby 3.3.4
- Rails 7.12.0
- Docker 4.32.0

### **Steps:**

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/juanm-hidalgoav/geolocation-api.git
   cd geolocation-api
   ```
2. **Crearte .env file:**

   ```bash
   POSTGRES_PASSWORD=
   POSTGRES_USER=
   POSTGRES_DB=
   IPSTACK_API_KEY=
   MAXMIND_API_KEY=
   ```
3. **Build the Docker Containers:**

   ```bash
   docker compose build
   docker compose run web bundle install
   docker compose up
   ```

4. **Set Up the Database:**

   ```bash
   docker compose run web rails db:migrate
   docker compose run web rails db:seed
   ```

5. **Retrieve API key for use with protected routes:**
   ```bash
   http://localhost:3000/api/v1/api_keys
   ```

6. **Import Postman collection and variables to start testing endpoints**
    ```bash
    https://1drv.ms/u/c/aeb335efd1403f7f/EYelAcNcXUxMr3LRa7wN7hEBHDK6heWq_m4C6Pb5Hr67YA?e=hXXyvH
    https://1drv.ms/u/c/aeb335efd1403f7f/ESuMiu_e5k5LhmzV-ILE00wBUn-Wtqmb44wJ63XJo_dt4w?e=XbtSV8   
    ```

7. **Run Tests:**

   ```bash
   docker compose run web rspec
   ```


## **Usage**

### **API Endpoints:**

- **Geolocations:**
  - `GET /api/v1/geolocations`: Retrieve all geolocations.
  - `POST /api/v1/geolocations`: Create a new geolocation.
  - `GET /api/v1/geolocations/:id`: Retrieve a specific geolocation by Id.
  - `GET /api/v1/geolocations/:IP`: Retrieve a specific geolocation by IP Address.
  - `DELETE /api/v1/geolocations/:id`: Delete a specific geolocation.

- **API Keys:**
  - `GET /api/v1/api_keys`: Retrieve all API keys.
  - `POST /api/v1/api_keys`: Create a new API key.
  - `DELETE /api/v1/api_keys/:id`: Revoke an API key.

- **Users:**
  - `GET /api/v1/users`: Retrieve all users.
  - `POST /api/v1/users`: Create a new user.
  - `GET /api/v1/users/:id`: Retrieve a specific user.
  - `DELETE /api/v1/users/:id`: Delete a specific user.

- **Countries and Regions:**
  - `GET /api/v1/countries`: Retrieve all countries.
  - `GET /api/v1/regions`: Retrieve all regions.

## **Controllers**

The controllers are responsible for handling incoming HTTP requests, processing them through the services, and returning appropriate responses.

### **Api::V1::GeolocationsController**

- **Purpose:** Manages geolocation data.
- **Key Actions:**
  - `index`: List all geolocations.
  - `show`: Retrieve a specific geolocation by ID.
  - `create`: Add a new geolocation.
  - `destroy`: Delete a geolocation by ID.

### **Api::V1::ApiKeysController**

- **Purpose:** Handles API key creation, management, and revocation.
- **Key Actions:**
  - `index`: List all API keys for the authenticated user.
  - `create`: Generate a new API key.
  - `destroy`: Revoke an API key by ID.

### **Api::V1::UsersController**

- **Purpose:** Manages user accounts.
- **Key Actions:**
  - `index`: List all users.
  - `show`: Retrieve a specific user by ID.
  - `create`: Create a new user.
  - `destroy`: Delete a user by ID.

### **Api::V1::CountriesController**

- **Purpose:** Provides access to country data.
- **Key Actions:**
  - `index`: List all countries.
  - `show`: Retrieve a specific country by ID.

### **Api::V1::RegionsController**

- **Purpose:** Provides access to region data.
- **Key Actions:**
  - `index`: List all regions.
  - `show`: Retrieve a specific region by ID.

## **Services**

Services encapsulate the business logic of the application and are used by controllers to perform specific tasks.

### **GeolocationService**

- **Purpose:** Abstracts the logic of fetching geolocation data from an external API (like ipstack) and normalizes it for storage in the database.
- **Key Methods:**
  - `get_geolocation(ip_or_url)`: Fetches geolocation data for a given IP address or URL.

### **IpstackService**

- **Purpose:** Interacts directly with the ipstack API to fetch geolocation data.
- **Key Methods:**
  - `fetch_geolocation(ip_or_url)`: Sends a request to the ipstack API and returns the parsed geolocation data.

## **Models**

Models represent the data structures and relationships within the application.

### **User**

- **Associations:**
  - `has_many :api_keys`
- **Validations:**
  - `validates :email, presence: true, uniqueness: true`
  - `validates :encrypted_password, presence: true`

### **ApiKey**

- **Associations:**
  - `belongs_to :user`
  - `has_many :geolocations`
- **Validations:**
  - `validates :key, presence: true, uniqueness: true`
  - `validates :user_id, presence: true`

### **Geolocation**

- **Associations:**
  - `belongs_to :country`
  - `belongs_to :region`
  - `belongs_to :api_key`
- **Validations:**
  - `validates :ip_or_url, presence: true`
  - `validates :latitude, presence: true`
  - `validates :longitude, presence: true`

### **Country**

- **Associations:**
  - `has_many :regions`
  - `has_many :geolocations`
- **Validations:**
  - `validates :code, presence: true, uniqueness: true`
  - `validates :name, presence: true`

### **Region**

- **Associations:**
  - `belongs_to :country`
  - `has_many :geolocations`
- **Validations:**
  - `validates :name, presence: true`
  - `validates :country_id, presence: true`

## **Testing**

### **RSpec**

The project uses RSpec for testing.

### **Running Tests**

To run the test suite, use the following command:

```bash
docker compose run web rspec
```

The test coverage includes:

- **Controller Tests:** Ensure that API endpoints return correct responses and handle edge cases.
- **Service Tests:** Confirm that services behave as expected under various conditions.


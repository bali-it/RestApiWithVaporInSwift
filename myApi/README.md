## Description

In this project, I have created APIs to be used in my application. I used vapor framework with swift lanauge
## Installation

Install package
   ```bash
brew install vapor
``` 

## Usage

## Usage

To use this project, follow these steps:

1. Clone this repository:
   ```bash
   git clone ssh://git@scm.adesso-mobile.de:7999/~al-ali/swiftvaporapi.git
   ```

2. Navigate to the project folder:
   ```bash
   cd navigate/to/project/folder
   ```

3. Migrate your database by running the following command:
   ```bash
   swift run App migrate
   ```

4. Run the project:
   ```bash
   swift run
   ```


Now you can use the following routes to interact with the API:

- `GET /users`: Get a list of users.
- `POST /user`: Create a new user.
- `DELETE /user`: Delete a user.
- `GET /user/getUserId`: get user id by username.
- `GET /user/getUserData`: Get user data by ID.
- `PATCH /user`: Update a user.

## Packages
 * Vapor:  Vapor is a web framework for Swift, allowing you to write backends, web apps APIs and HTTP servers in Swift. Vapor is written in Swift, which is a modern, powerful and safe language providing a number of benefits over the more traditional server languages. https://vapor.codes/
 * Fluent: Fluent is an ORM framework for Swift. It takes advantage of Swift's strong type system to provide an easy-to-use interface for your database. Using Fluent centers around the creation of model types which represent data structures in your database. These models are then used to perform create, read, update, and delete operations instead of writing raw queries. 




   



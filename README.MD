
# Introduction


# Running

The application is configured to use an sqlite3 database in order to get it run quickly.

Run the following commands on the console in order to prepare the application

```
bundle
rake db:create
rake de:migrate
rake db:seed
rails s
```

Then load the application on a browser with the url: ```http://localhost:30000```

You can login with a test user with credentials:
- email: test@test.com
- pass: 12345678


# Testing

To test the application code run the following command on the console:

```
rake rubocop spec
```

Currently not passing all tests due lack of time :(


# Pending

- Localization of JavaScript code
- Show success and error information to the end user
- Improve error management on the server
- Improve presentation (for example sorting by field, modal confirmation buttons, ...)
- Check and fix tests
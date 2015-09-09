### Important urls
* Admin area: `/admin`
* Admin login: `/admin/login`

### How to create Admin
Run Heroku console and type:
`Admin.create(email: "youremail@example.com", password: "yourpassword")`

### Admin configurations
If an admin fails his/her login 10 times, his/her account will be locked for 1 hour.

### Specs
* Ruby 2.2.2
* Rails 4.2
* Postgesql 9.4

### Docs TODO:
* System dependencies
* Configuration
* Database creation
* Database initialization
* How to run the test suite
* Services (job queues, cache servers, search engines, etc.)
* Deployment instructions
* ...
#### Update admin password
Run Heroku console and type:

`Admin.all`

Note the id of the admin. If the id of admin is 1, run:

`Admin.find(1).update!(password: "newpassword")`

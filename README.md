# GeniusPass

GeniusPass is a webapp that can be used by parents to book unlimited classes or activities for their children via a monthly subscription.

Admin's role:

* add cities & activities via the Settings page
* add partners
* add classes for each partner
* add schedules for each class
* check for incoming reservations on the admin dashboard
* view names of children that reserve a particular schedule
* archive a schedule after copying the children's names

User's role:

* sign up with email and choose a subscription plan
* add children
* find schedules to reserve by finding them in either Schedules or Partners page
* reserve their children to a class's schedule
* see upcoming reserved classes in user's dashboard

## Deployment

* Ruby 2.2.2
* Rails 4.2
* Postgesql 9.4

### Running Locally

To run this on your local machine, make sure you have the above installed. Then run:

    rake db:migrate
    rake db:seed

### Production

Hosting: 

    Server: Heroku (Hobby dyno)
    Database: Heroku Postgres (Hobby)
    DNS: Cloudflare

Configurations:

    Server: geniuspass.herokuapp.com
    DNS: CNAME geniuspass.com aliased to geniuspass.herokuapp.com (TTL Automatic)

To push code to production, make sure to have Heroku toolbelt installed, setup authentication, and run the command below from the master branch:

    git push production master

## Admin

Admin area: `/admin`

Admin login: `/admin/login`

If an admin fails his/her login 10 times, the account will be locked for 1 hour.

#### Create admin

On local machine, running `rake db:seed` will create one admin account that you can use to login:

* Email: admin@example.com
* Password: 123456

To create another admin, just run rails console:

    rails console
    Admin.create!(email: "youremail@yourdomain.com", password: "yourpassword")
    
On Heroku server , you can create an admin by running Heroku's rails console:

    heroku run rails console
    Admin.create!(email: "youremail@yourdomain.com", password: "yourpassword")

#### Update admin password

Run `rails console` and type:

    Admin.all

Note the id of the admin. If the id of admin that contains your email is 1, run:

    Admin.find(1).update!(password: "yournewpassword")
    
For Heroku server, run Heroku's rails console and repeat the above commands:

    heroku run rails console
    Admin.all
    Admin.find(1).update!(password: "yournewpassword")

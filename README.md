# Open Graph Example

Enter URLs, and this site will read the Facebook OpenGraph tags to find additional information about the page including
* Title
* Description (in detail view)
* Image 

_Note: Not all pages include the OG tags so don't get upset if any of these values do not display in the table._

![Screenshot](https://website1-screenshots.s3.amazonaws.com/OpenGraphScreenshot.png)

Things you may want to cover:

## System dependencies

URL lookups are processed asynchronously in a background job using Sidekiq.  Therefore a redis server must be installed locally.
If redis is not installed, first follow the instructions here

https://redis.io/docs/latest/operate/oss_and_stack/install/install-redis/

## Dependencies

-   Ruby 3.2.3 - Installed by you before attempting to run using your favorite ruby version manager (I use RVM)
-   Rails 7.1.3.4 - Installed by bundler
-   Postgresql - I used 12.18 but anything above version 9.0 should work
-   Bundler 2.5.9

## Setup
              
These instructions are for mac or any *nix variant. 

After installing ruby...
  - Change to your development directory and...
  - ```git clone git@github.com:dsadaka/opengraph.git``` # copy down this repository
  - ```cd opengraph```
  - ```gem install bundler -v=2.5.9```
  - ``bundle``
  - ``cd config``
  - cp -p 
  - ``vim config/database.yml`` # or whatever editor you prefer
    - enter username and password under development section 
  - ```bin/setup``` # Create empty Postgresql database luna_development

## Go

## Approach

As usual, I try not to load up my stack with unnecessary code and extra steps.  Therefore I always look at the requirements before 
creating a new project and go with the minimums.

### Front End: I elected to use the simplest configuration possible for front-end development.  
- ImportMaps over Esbuilder: No transpiling required so no need for all that overhead.
- Bootstrap: Used to simplify styling
- jQuery: Not needed so not used
                                    
### Asynchronous handling
In the old days, I would have had to use...

- input form: remote: true to submit the users url via an ajax call.
- grid update: javascript: setTimeout function to poll backend for updates and rewrite table

But today, life is easier...
- input form: Turbo frame so hotwire intercepts form submit and sends to back end via ajax. It then 
parses the response and extracts only the form section, throws out most everything else and replaces only the 
Turbo Frame containing the form
- grid update: Turbo Streams so hotwire uses ActionCable (web socket) to send a newly added URL record to the front-end
which then prepends it to the existing table.
### Background job Processor:
- Sidekiq over Resque: Sidekiq is faster and simpler and this application called for quick response, as opposed to, for instance batch emailing or clearing credit card payments.
                      
## Changes for a real production environment
- Add User Authentication
- Allow editing a grid row in place.  (Currently editing is done on the details (show) page and the index page is redrawn)
- Pagination
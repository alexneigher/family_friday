## Alex's Lunch Grouper

This application randomly matches employees for lunches.

#### How to run locally:
---
- Clone the repository 
- Install requisite gems
  -  `bundle install`

- Seed a local database
  - `rake db:create db:migrate db:seed`  (this adds employees)

- Run local webserver
  - `rails server` 

#### How it works:
---

The homepage will randomly generate groups based on all of your employees. If you do not like these groups for whatever reason, click "shuffle". 

Once you like the groupings click "Save & Send Notifications". This persists this group, as well as sends out emails to all of the members (#todo on the email part).

You can view previous lunch groupings by clicking the menu in the top nav.

To add/edit/delete employees click on the employees nav item.
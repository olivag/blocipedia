# [Blocipedia](https://olivag-blocipedia.herokuapp.com/): SaaS Wiki Collaboration Tool.
##### Blocipedia allows users to create and collaborate on their own wikis privately or publicly.
![alt tag](https://olivag.github.io/img/blocipedia.png "Blocipedia")

### What Users/Developers can do
***
1.  As a user, sign up for a free account by providing a name, password, and email
2. As a user, sign in and out of Blocipedia
3. As a developer, offer three user roles: admin, standard, or premium
4. Users default to the standard role when they are first created
5. Database pre-seeded with fake users and wikis
6. Users can edit wikis using Markdown syntax
7. Standard can upgrade to premium service and create private wikis
8. Premium users can downgrade to standard service
9. Premium users can add and remove collaborators for their private wikis

### Tools used
***
* Devise gem for authentication
* Pundit gem for authorization
* Faker gem to simulate a users and wikis
* Stripe for credit card payment process
* Redcarpet gem to parse Markdown syntax
* Collaborator table joins Wiki and User tables to add/delete collaborators for private wikis
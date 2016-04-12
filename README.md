# GroceryGnome

To start your Phoenix app:

  1. Install dependencies with `mix deps.get`
  2. Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  3. Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: http://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix


## DATABASE NOTES
Fooditems is a simple/test database relation currently
You must create your database locally with mix ecto.create
any further updates to the databse requires mix.migrate

if there is any database errors or some updates to migration files. I recommend doing ecto.drop . This can only be done when the the server is not running. Otherwise you will need to manually drop the tables in either psql or a GUI tool such as pgadmin3 or adminer.



## New Model

Food Catalog - /foodcatalog

Pantry Item - /pantryitems

Recipes - /recipes

Days - /days
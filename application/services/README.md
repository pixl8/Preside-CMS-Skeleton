Services directory
==================
The services directory is the place to put any of your application's service layer objects (CFC files). PresideCMS will automatically scan then and process them with Wirebox. i.e. a file called /services/news/NewsService.cfc will be available to you in a handler with `getModel( 'NewsService' )`.
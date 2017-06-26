# CookBooks
Chef CookBooks
Author: jeancarloschavez@gmail.com
This is a set of recipes to automate different tasks on CentOS.

You have to create a cookbook structure with this command from your home directory (cd ~):
chef generate cookbook cookbooks/COOKBOOK_NAME

Note. COOKBOOK_NAME is any name you want.

After that please select and download the recipe file you need and copy the <recipe_name>.rb file in the recipes folder into your cookbooks/COOKBOOK_NAME directory.

You have to upload your cookbook with this command:
knife cookbook upload COOKBOOK_NAME

Now, you can bootstrap a node and apply this cookbook/recipe:
knife bootstrap ADDRESS --ssh-user USER --sudo --identity-file IDENTITY_FILE --node-name node1 --run-list 'recipe[COOKBOOK_NAME]'

For example:
knife bootstrap X.X.X.X --ssh-user ec2-user --sudo --identity-file ~/.ssh/pemfile/jeanchavez.pem --node-name web-server --run-list 'recipe[COOKBOOK_NAME]'

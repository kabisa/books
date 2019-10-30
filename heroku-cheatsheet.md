Deploy `develop` to staging:

```
git push staging develop:master
```

Run rake on staging:

```
heroku run rake db:migrate --remote staging
```
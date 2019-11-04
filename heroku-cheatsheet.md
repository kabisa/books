## Staging

Deploy `develop`:

```
git push staging develop:master
```

Run rake:

```
heroku run rake db:migrate --remote staging
```

## Production

Deploy `master`:

```
git push production master
```

Run rake:

```
heroku run rake db:migrate --remote production
```
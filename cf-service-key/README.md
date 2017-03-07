# Interact with PostgreSQL via Service Keys

Each Cloud Foundry service binding is for an application's specific use. If an app developer wants to directly interact with a service instance, such as a PostgreSQL database, then use Service Keys.

For example:

```
cf create-service dingo-postgresql cluster mydb
cf create-service-key mydb mydb-key
cf service-key mydb mydb-key
```

For convenience, there is a `./db-contents.sh` script that does all of this and passes any arguments thru to `psql`:

```
./db-contents.sh ghost-pg
Arguments provided will be passed to 'psql'. Defaulting to "-c '\dt;'
                    List of relations
 Schema |          Name          | Type  |     Owner
--------+------------------------+-------+----------------
 public | accesstokens           | table | dvw7DJgqzFBJC8
 public | app_fields             | table | dvw7DJgqzFBJC8
 public | app_settings           | table | dvw7DJgqzFBJC8
 public | apps                   | table | dvw7DJgqzFBJC8
 public | client_trusted_domains | table | dvw7DJgqzFBJC8
 public | clients                | table | dvw7DJgqzFBJC8
...
 public | users                  | table | dvw7DJgqzFBJC8
(19 rows)
```

Or pass arguments:

```
./db-contents.sh ghost-pg -c "select name from users;"
```

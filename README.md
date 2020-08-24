
### local-db.env file example 

```
POSTGRES_USER=super_user 
POSTGRES_PASSWORD=super_user_key
POSTGRES_MULTIPLE_DATABASES=st_db,one_usr:nd_db,other_usr:rd_db,another_usr:4th_db,other_usr
POSTGRES_MULTIPLE_USERS=one_usr,keyOfOneUser:other_usr,keyOfOtherUser:another_usr,keyOfAnotherUser
PG_SYSTEM_SHARED_BUFFERS=256MB
PG_SYSTEM_MAINTENANCE_WORK_MEM=256MB
PG_SYSTEM_WAL_BUFFERS=8MB
PG_SYSTEM_EFFECTIVE_CACHE_SIZE=1024MB
```

#### run with command

``` docker-compose -f docker-compose-local-db.yml up ```
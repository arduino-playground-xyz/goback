(**Work in progress**)  

# goback  
Go backend for arduino watering system

## Prerequisites  
+ go >=1.14  
+ Docker and docker-compose (or local MySql instance)  

## Run
+ Run MySql instance and apply schema  
```
docker-compose up -d
(wait until mysql is started)
./scripts/execute_sql.sh scripts/create_schema.sql
```  
+ Run server  
```
go run cmd/server/main.go config/config-test.json
```
or  
```
go build cmd/server/main.go 
./main config/config-test.json
```
## Database schema

![image](https://user-images.githubusercontent.com/12186457/118371052-64cf1b00-b5b3-11eb-9449-8b6f3bd6b59c.png)

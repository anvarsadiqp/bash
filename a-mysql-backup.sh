#!/bin/bash
MYSQL_USER="root"
MYSQL_PASS="YOUR_PASS"

echo "-- START --"

echo "SET autocommit=0;SET unique_checks=0;SET foreign_key_checks=0;" > tmp_sqlhead.sql
echo "SET autocommit=1;SET unique_checks=1;SET foreign_key_checks=1;" > tmp_sqlend.sql

if [ -z "$1" ]
  then
    echo "-- Dumping all DB ..."
    for I in $(mysql -u $MYSQL_USER --password=$MYSQL_PASS -e 'show databases' -s --skip-column-names); 
    do
      if [ "$I" = information_schema ] || [ "$I" =  mysql ] || [ "$I" =  phpmyadmin ] || [ "$I" =  performance_schema ]  # exclude this DB
      then
         echo "-- Skip $I ..."
       continue
      fi
      echo "-- Dumping $I ..."
      # Pipe compress and concat the head/end with the stoutput of mysqlump ( '-' cat argument)
      mysqldump -u $MYSQL_USER --password=$MYSQL_PASS $I | cat tmp_sqlhead.sql - tmp_sqlend.sql | gzip -fc > "$I.sql.gz" 
    done

else
      I=$1;
      echo "-- Dumping $I ..."
      # Pipe compress and concat the head/end with the stoutput of mysqlump ( '-' cat argument)
      mysqldump -u $MYSQL_USER --password=$MYSQL_PASS $I | cat tmp_sqlhead.sql - tmp_sqlend.sql | gzip -fc > "$I.sql.gz" 
fi

# remove tmp files
rm tmp_sqlhead.sql
rm tmp_sqlend.sql

echo "-- FINISH --"

#! /bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"
#echo "Conectado"
#fixed with rename the column weight to atomic mass
#fixed with rename the column melting_point column to melting_point_celsius and the boiling_point column to boiling_point_celsius
#fixed melting_point_celsius and boiling_point_celsius columns should not accept null values
#add add the UNIQUE constraint to the symbol and name columns from the elements table
#fixed symbol and name columns should have the NOT NULL constraint
#add set the atomic_number column from the properties table as a foreign key that references the column of the same name in the elements table
#add create a types table that will store the three types of elements
#add types table should have a type_id column that is an integer and the primary key
#add types table should have a type column that's a VARCHAR and cannot be null. It will store the different types from the type column in the properties table
#add three rows to your types table whose values are the three different types from the properties table
#properties table should have a type_id foreign key column that references the type_id column from the types table. It should be an INT with the NOT NULL constraint
#properties table should have a type_id value that links to the correct type from the types table
#You should capitalize the first letter of all the symbol values in the elements table. Be careful to only capitalize the letter and not change any others
#remove all the trailing zeros after the decimals from each row of the atomic_mass column. You may need to adjust a data type to DECIMAL for this. Be careful not to change the value
#display_titles of proyect
#echo -e "\n~~~~~~ Table Periodic Proyect ~~~~~\n"
 NO_ARGUMENT() {
          echo -e "Please provide an element as an argument."
 }

          QUERY_BY_NAME() {
          RESULT_QUERYS_BY_NAME=$($PSQL "SELECT elements.atomic_number, symbol, name, atomic_mass, melting_point_celsius, boiling_point_celsius, types.type FROM elements INNER JOIN properties ON elements.atomic_number = properties.atomic_number INNER JOIN types USING(type_id) WHERE elements.name = '$NAME_ARGUMENT'")
          echo $RESULT_QUERYS_BY_NAME | while read ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR ATOMIC_MASS BAR MELTING_POINT_CELSIUS BAR BOILING_POINT_CELSIUS BAR TYPE_NAME
          do
          if [[  -z $RESULT_QUERYS_BY_NAME  ]]
           then
           echo "I could not find that element in the database."
           else
           echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE_NAME, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
         fi
         done
        }
        QUERY_BY_ATOMIC_NUMBER() {
         QUERY_TO_DATABASE=$($PSQL "SELECT elements.atomic_number, symbol, name, atomic_mass, melting_point_celsius, boiling_point_celsius, types.type FROM elements INNER JOIN properties ON elements.atomic_number = properties.atomic_number INNER JOIN types USING(type_id) WHERE elements.atomic_number = $ATOMIC_NUMBER_ARGUMENT")  
         echo $QUERY_TO_DATABASE | while read ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR ATOMIC_MASS BAR MELTING_POINT_CELSIUS BAR BOILING_POINT_CELSIUS BAR TYPE_NAME
         do
         if [[  -z $QUERY_TO_DATABASE  ]]
           then
           echo "I could not find that element in the database."
           else
           echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE_NAME, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
         fi
         done
      }
      QUERY_BY_SYMBOL() {

        RESULT_QUERY_BY_SYMBOL=$($PSQL "SELECT elements.atomic_number, symbol, name, atomic_mass, melting_point_celsius, boiling_point_celsius, types.type FROM elements INNER JOIN properties ON elements.atomic_number = properties.atomic_number INNER JOIN types USING(type_id) WHERE elements.symbol ='$SYMBOL_ARGUMENT'")
        echo $RESULT_QUERY_BY_SYMBOL | while read ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR ATOMIC_MASS BAR MELTING_POINT_CELSIUS BAR BOILING_POINT_CELSIUS BAR TYPE_NAME
         do
         if [[  -z $RESULT_QUERY_BY_SYMBOL  ]]
           then
             echo "I could not find that element in the database."
            else
            echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE_NAME, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
         fi
        done
            }

         if [[ -z $1 ]]
           then
           NO_ARGUMENT
         fi
         if [[ $1 =~ ^[0-9]+$ ]]
           then
           ATOMIC_NUMBER_ARGUMENT=$1
           QUERY_BY_ATOMIC_NUMBER
         fi
         if [[ $1 =~ ^[a-zA-Z]+$ ]]
           then
            if [[ ${#1} -le 2 ]]
             then
              SYMBOL_ARGUMENT=$1
              QUERY_BY_SYMBOL
             else
              NAME_ARGUMENT=$1
              QUERY_BY_NAME
            fi
         fi

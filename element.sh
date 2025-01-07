#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument." 
else 
  #check if argument is a number
  if [[ "$1" =~ ^[0-9]+$ ]]
  then
  # $1 is a number
  ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$1" )
  else
  # $1 is a text
  ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements INNER JOIN properties USING(atomic_number) WHERE name='$1' OR symbol='$1' " )
  fi
  if [[ -z $ATOMIC_NUMBER ]]
  then
    echo "I could not find that element in the database."
  else
    # get name
    NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$ATOMIC_NUMBER")
    # get symbol
    SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$ATOMIC_NUMBER")
    # get atomic mass
    ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
    # get boiling_point
    BOILING=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
    # get melting_point
    MELTING=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
    # get type
    TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
    TYPE=$($PSQL "SELECT type FROM types WHERE type_id=$TYPE_ID" )

    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
  fi


fi

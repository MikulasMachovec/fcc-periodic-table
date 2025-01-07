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
  echo $ATOMIC_NUMBER
  # get name
  #NAME=$($PSQL "SELECT FROM WHERE atomic")
  # get symbol
  # get boiling_point
  # get melting_point
  # get type


fi
  
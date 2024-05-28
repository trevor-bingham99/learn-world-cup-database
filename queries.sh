#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# Do not change code above this line. Use the PSQL variable above to query your database.

echo -e "\nTotal number of goals in all games from winning teams:"
echo "$($PSQL "SELECT SUM(winner_goals) FROM games")"

echo -e "\nTotal number of goals in all games from both teams combined:"
echo "$($PSQL "select SUM(winner_goals + opponent_goals) from games;")"

echo -e "\nAverage number of goals in all games from the winning teams:"
echo "$($PSQL "")"

echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
echo "$($PSQL "")"

echo -e "\nAverage number of goals in all games from both teams:"
echo "$($PSQL "")"

echo -e "\nMost goals scored in a single game by one team:"
echo "$($PSQL "")"

echo -e "\nNumber of games where the winning team scored more than two goals:"
echo "$($PSQL "")"

echo -e "\nWinner of the 2018 tournament team name:"
echo "$($PSQL "")"

echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:"
echo "$($PSQL "")"

echo -e "\nList of unique winning team names in the whole data set:"
echo "$($PSQL "")"

echo -e "\nYear and team name of all the champions:"
echo "$($PSQL "")"

echo -e "\nList of teams that start with 'Co':"
echo "$($PSQL "")"

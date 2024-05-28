#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
echo $($PSQL "TRUNCATE teams,games")

insert_team() {
  TEAM_NAME=$1
  TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$TEAM_NAME'")
  if [[ -z $TEAM_ID ]]
  then
    INSERT_TEAM_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$TEAM_NAME')")
    if [[ $INSERT_TEAM_RESULT == "INSERT 0 1" ]]
    then
      echo "Inserted team: $TEAM_NAME"
    fi
  fi
}

# Read the games.csv file
cat games.csv | while IFS="," read YEAR ROUND WINNING_TEAM OPPONENT_TEAM WINNING_GOALS OPPONENT_GOALS
do
  # Skip the header row
  if [[ $YEAR != "year" ]]
  then
    # Insert the winning team
    insert_team "$WINNING_TEAM"

    # Insert the opponent team
    insert_team "$OPPONENT_TEAM"

    # Get team IDs
    WINNING_TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNING_TEAM'")
    OPPONENT_TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT_TEAM'")
    
    # Insert the game information
    INSERT_GAME_RESULT=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $WINNING_TEAM_ID, $OPPONENT_TEAM_ID, $WINNING_GOALS, $OPPONENT_GOALS)")
    if [[ $INSERT_GAME_RESULT == "INSERT 0 1" ]]
    then
      echo "Inserted game: $YEAR, $ROUND, $WINNING_TEAM vs $OPPONENT_TEAM"
    fi
  fi
done

for name in "$@"
do

echo ------ Trying to setup permissions for $name

file=$(basename $name)
team="${file%.*}"

teamid=`curl -# -u $GITHUB_USER:$GITHUB_PWD https://api.github.com/orgs/jbdevstudio/teams | grep "name...*$team" -A1  | grep id | sed -e 's/.*\"id...\(.*\),/\1/g'`

echo Found $team having $teamid as id

cat $team.team | xargs -n 1 -I {} bash -c "echo Adding {} to $team && curl -u $GITHUB_USER:$GITHUB_PWD -X PUT -d ''  https://api.github.com/teams/$teamid/members/{}"

if [[ $team == jbdevstudio-* ]] ;
then 
    echo Adding repo $team to team $team
    curl -# -u $GITHUB_USER:$GITHUB_PWD -X PUT -d "" https://api.github.com/teams/$teamid/repos/jbdevstudio/$team
fi

curl -# -u $GITHUB_USER:$GITHUB_PWD https://api.github.com/teams/$teamid/members | grep \"login\"\: | sed -e 's/.*login":.*"\(.*\)",/\1/g' | sort > $team.existingmembers

# ensure hand written team is actually sorted.
sort $team.team -o $team.team

echo Comparing...
diff=`diff $team.existingmembers $team.team`
if [ "$diff" != "" ]
then
   echo WARNING: Team $team does not have the exact members expected! Please check.
   echo "$diff"
fi

done






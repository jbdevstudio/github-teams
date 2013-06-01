
team=$1

teamid=`curl -u $GITHUB_USER:$GITHUB_PWD https://api.github.com/orgs/jbdevstudio/teams | grep "name...*$team" -A1  | grep id | sed -e 's/.*\"id...\(.*\),/\1/g'`

echo Found $team having $teamid as id

cat $1.team | xargs -n 1 -I {} bash -c "echo Adding {} to $team && curl -u $GITHUB_USER:$GITHUB_PWD -X PUT -d ''  https://api.github.com/teams/$teamid/members/{}"

echo Add repo with same name as team to this repo
curl -u $GITHUB_USER:$GITHUB_PWD -X PUT -d '' https://api.github.com/teams/$teamid/repos/jbdevstudio/$team








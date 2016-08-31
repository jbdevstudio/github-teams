# script that adds $1 user to QE relevant groups in jira
userid=$1

echo Adding $userid to Developer groups. If Error 500 then user most likely is already in the group.
jira --action addUserToGroup --group "DevStudio Dev" --userId $userid
jira --action addUserToGroup --group "JBoss Employee" --userId $userid
jira --action addUserToGroup --group "Red Hat" --userId $userid

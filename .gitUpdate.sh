#!/bin/sh
git remote | grep github &> /dev/null && remote_name="github" || remote_name="origin"
git fetch ${remote_name} 
git merge ${remote_name}/master master

set d=%date:~0,10%
set t=%time:~0,8%
echo %d% %t%


git pull

git add --all

git commit -m "%1 - %d% %t%"

git push origin master

all:git-push

git-pull:
	bash automate.sh git_pull

git-push:
	bash automate.sh git_push

refresh-wordpress:
	bash automate.sh refresh_wordpress

refresh-wordpress-all:
	MAX_DAYS=730 bash automate.sh refresh_wordpress

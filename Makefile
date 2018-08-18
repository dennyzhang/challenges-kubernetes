all:git-push

git-pull:
	git submodule update

git-push:
	bash automate.sh git_push

refresh-wordpress:
	bash automate.sh refresh_wordpress

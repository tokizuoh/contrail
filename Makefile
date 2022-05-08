set-git-hooks-commit-msg:
	cp ./.git-hooks/commit-msg .git/hooks/commit-msg
	chmod +x .git/hooks/commit-msg
set-git-hooks-post-checkout:
	cp ./.git-hooks/commit-msg .git/hooks/post-checkout
	chmod +x .git/hooks/post-checkout
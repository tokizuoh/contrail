set-git-hooks-commit-msg:
	cp ./.git-hooks/commit-msg .git/hooks/commit-msg
	chmod +x .git/hooks/commit-msg
remove-merged-branch:
	git branch --merged | xargs -n 1 | egrep -v "develop|\*" | xargs git branch -d
xcodegen:
	sh ./scripts/xcodegen.sh
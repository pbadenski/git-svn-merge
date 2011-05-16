#!/bin/zsh
source helper.sh

{
setup_svn_repository

git svn clone -T trunk -b branches file:///$SVN_REPO_DIR/svn-project git-svn-project

cd git-svn-project
	git co feature
		touch beta
		git add beta
		git commit -m "Beta"
		git svn dcommit

		touch gamma
		git add gamma
		git commit -m "Gamma"
		git svn dcommit

	git co trunk
		git svn merge `git rev-list --reverse feature -2`
		git log -1
		git svn dcommit
		git svn propget svn:mergeinfo
} > $0.log 2>&1
		assert_equals `git svn propget svn:mergeinfo` "/svn-project/branches/feature:4-5,8,9"
cd ..


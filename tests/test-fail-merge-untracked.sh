#!/bin/zsh
source test-helper.sh

setup_svn_repository

git svn clone -T trunk -b branches file:///$SVN_REPO_DIR/svn-project git-svn-project

cd git-svn-project
	git co feature
		echo "Branch" > beta
		git add beta
		git commit -m "Beta"
		git svn dcommit

		echo "Gamma" > gamma
		git add gamma
		git commit -m "Gamma"
		git svn dcommit

	git co trunk
		echo "Trunk" > beta
		git svn merge `git rev-list --reverse feature -2`
		cat .git/svn/SVN_MERGE
		cat .git/svn/SVN_MERGE_MSG
		rm beta
		git svn merge --continue
		git log -1
		git svn propget svn:mergeinfo
		git svn dcommit
		git log -1
		assert_equals `git svn propget svn:mergeinfo` "/svn-project/branches/feature:4-5,8,9"
cd ..

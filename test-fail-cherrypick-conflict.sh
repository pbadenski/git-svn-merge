#!/bin/bash
. test-helper.sh

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
		git add beta
		git commit -m "Trunk beta"

		git svn merge `git rev-list --reverse feature -2`
		echo "SVN_MERGE contents: "
		cat .git/svn/SVN_MERGE && echo \n
		echo "SVN_MERGE_MSG contents: "
		cat .git/svn/SVN_MERGE_MSG
		echo "Branch\nTrunk" > Beta
		git add beta
		git svn merge --edit --continue
		git log -1
		git svn propget svn:mergeinfo
		git svn dcommit
		git log -1
		git svn propget svn:mergeinfo
		echo "Expected: /svn-project/branches/feature:4-5,7,8" 
		echo "Actual:   `git svn propget svn:mergeinfo`"
cd ..

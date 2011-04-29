#!/bin/bash
. test-helper.sh

setup_svn_repository

git svn clone -T trunk -b branches file:///home/pbadenski/git-svn-merge/svn-repository/svn-project git-svn-project

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
		git svn merge `git rev-list feature -2`
		cat .git/svn/SVN_MERGE
		cat .git/svn/SVN_MERGE_MSG
		rm beta
		git svn merge --continue
		git log -1
		git svn propget svn:mergeinfo
		git svn dcommit
		git log -1
		echo "Expected: /svn-project/branches/feature:4-5,8,7" 
		echo "Actual:   `git svn propget svn:mergeinfo`"
cd ..


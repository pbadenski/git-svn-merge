#!/bin/zsh
BASE_LOG_DIR=`pwd`
source helper.sh

{
setup_svn_repository

git svn clone -T trunk -b branches file:///$SVN_REPO_DIR/svn-project git-svn-project

cd git-svn-project
	git co trunk
		touch beta
		git add beta
		git commit -m "Beta"
		git svn dcommit
		
	git co feature
		git svn cherry-pick `git rev-list --reverse trunk -1`
		git log -1
		git svn dcommit
		git svn propget svn:mergeinfo
} > $BASE_LOG_DIR/$0.log 2>&1
		assert_equals `git svn propget svn:mergeinfo` "/svn-project/trunk:8"

{
	git co feature_2
		git svn cherry-pick -m 1 `git rev-list --reverse feature -1`
		git log -1
		git svn dcommit
		git svn propget svn:mergeinfo
} > $BASE_LOG_DIR/$0.log 2>&1
		assert_contains "`git svn propget svn:mergeinfo`" "/svn-project/trunk:8"
		assert_contains "`git svn propget svn:mergeinfo`" "/svn-project/branches/feature:4-5,9"
cd ..


#!/bin/zsh
for file in test-*.sh; do
	echo "Running '$file'.\n"
	./$file
	rm -rf git* svn*
done

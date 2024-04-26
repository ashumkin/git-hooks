#!/bin/bash
# vim: set shiftwidth=4 tabstop=4 noexpandtab:

while test "$#" -gt 0
do
	arg="$1"
	shift
	case "$arg" in
		-s)
			JIRA="$1"
			shift
			;;
		--id)
			ISSUE="$1"
			shift
			;;
		*)
			;;
	esac
done
curl --location --netrc --silent --fail \
	$CURL_OPTS \
	"$JIRA/rest/api/latest/issue/$ISSUE?fields=summary" \
	| jq --monochrome-output '.fields.summary' \
	| sed -e 's/^"\|"$//g'

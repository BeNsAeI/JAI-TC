#!/bin/bash

wget --spider --quiet http://www.google.com
if [ "$?" != 0 ]; then
	echo "Internet access failed."
else
	echo "System has internet access."
fi

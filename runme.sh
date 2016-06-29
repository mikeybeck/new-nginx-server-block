#!/bin/bash

# Set these.. Make sure to set config values in other file also
SERVER="" # IP or URL of server
USER="" # Username


sed -i 's/\r$//' makenewserverblock.sh # Prevent any newline script breaking silliness

cat makenewserverblock.sh | ssh $USER@SERVER

echo "Now go update the DNS!"
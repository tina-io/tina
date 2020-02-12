#!/bin/bash

rm ./out.txt;

exec () {
  echo -e "##$1"  |& tee -a $PWD/out.txt;
  $1 |& tee -a $PWD/out.txt;
}

# INTRODUCTION
#
# This script is meant as a helper to debug installation processes
# in Linux (tested on CentOS) when several commands are needed and
# an output bigger than the console buffer is expected.
# It creates a comprehensive log (out.txt) containing the commands
# run and all (or most of) the output.
#
# It has been used for running Drupal installations, and this is why
# you can see Drupal related commands in the OTHER EXAMPLES section
# below.
# Note that some commands require a ';' at the end, others don't.

# HOW TO USE
#
# Commands that don't require double quotes are prefixed by a blank
# space and added in between double quotes as items in
# CommandsStringArray.
# Example:
# " date"
#
# It will output the command prefixed by "## " followed by its output:
# ## date
# Fri Jan 17 17:03:06 CET 2020
#
# Commands that require quotes have their log entries manually added.
# They are prefixed by ": " and sufixed by a line break \n, and have
# the quotes escaped. The command as-is is then added again in a
# variable according to the following pattern:
# ": date \"+%A %d-%B, %Y\"\n$(date "+%A %d-%B, %Y")"
#
# This will output the text before \n prefixed by "##: ", followed
# by the output of the command after the line break:
# ##: date "+%A %d-%B, %Y"
# Friday 17-January, 2020
#
# If the command does not return an output there will be only the
# line break.
#
# Examples with a line break as output:
# " date > /dev/null"
# Will write in the log:
# ## date > /dev/null
#
# ": date \"+%A %d-%B, %Y\" > /dev/null\n$(date "+%A %d-%B, %Y" > /dev/null)"
# Will write in the log:
# ##: date "+%A %d-%B, %Y" > /dev/null
#

# WARNING
#
# If you wish do call this script from another one, you may have to
# use full paths for the commands. Example:
# " /bin/date"
# This way you will not rely on paths relative to your own console session.

# OTHER EXAMPLES (to be added as items of CommandsStringArray)
# " /usr/local/bin/drush -v cache-clear drush"
# ": /usr/local/bin/drush -y \"sql-drop\";\n$(/usr/local/bin/drush -y "sql-drop";)"
# " /bin/rm sanitized_daily_myproject_production_db.sql"
# " /usr/bin/wget --no-verbose -e use_proxy=no --user myuser --password maypassword http://mydomain.myproject/files-for/myproject/sanitized_daily_myproject_production_db.sql.gz"
# " /bin/gunzip sanitized_daily_myproject_production_db.sql.gz"
# ": /usr/local/bin/drush -v -d sql-cli < \"sanitized_daily_myproject_production_db.sql\";\n$(/usr/local/bin/drush sql-cli < "sanitized_daily_myproject_production_db.sql";)"
# ": /usr/local/bin/drush -v -d sqlq \"TRUNCATE TABLE cache\";\n$(/usr/local/bin/drush -v sqlq "TRUNCATE TABLE cache";)"
# ": /usr/local/bin/drush -v -d sqlq \"TRUNCATE TABLE cache_form\";\n$(/usr/local/bin/drush -v sqlq "TRUNCATE TABLE cache_form";)"
# ": /usr/local/bin/drush -v -d sqlq \"TRUNCATE TABLE ctools_object_cache\";\n$(/usr/local/bin/drush -v sqlq "TRUNCATE TABLE ctools_object_cache";)"
# " /usr/local/bin/drush -v rr"
# " /usr/local/bin/drush -v -y updb"
# " /usr/local/bin/drush -v -y fra"
# " /usr/local/bin/drush -v sapi-c myproject_index"
# " /usr/local/bin/drush -v sapi-r myproject_index"
# ": /usr/local/bin/drush -v php-eval 'print search_api_index_items(search_api_index_load('myproject_index'));'\n$(drush -v php-eval 'print search_api_index_items(search_api_index_load('myproject_index'));')"
# " /usr/local/bin/drush -v cc all"
# " /usr/local/bin/drush -v status"
# " /usr/local/bin/drush sapi-s"
# " /usr/local/bin/drush sapi-l"
# " /usr/local/bin/drush -l http://myproject.dev uli"

declare -a CommandsStringArray=(
  # Add your commands below
)
for command in "${CommandsStringArray[@]}"; do
  exec "$command"
done

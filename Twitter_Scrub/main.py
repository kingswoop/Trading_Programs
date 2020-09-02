
import subprocess
import os


### THIS IS JUST RELEVANT TO MY FILE STRUCTURE AS MY WATCHLIST IS IN THE PARENT DIRECTORY ###
# Current Path
path = os.getcwd()

# Define command and arguments
command = 'Rscript'
path2script = path + "/" + "tscrub.r"

# Build subprocess command
cmd = command, path2script

# check_output will run the command and store to result
subprocess.check_output(cmd, universal_newlines=True)


print ('r script finished running')
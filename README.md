# bash
A useful collection of bash scripts.

How to install
--------------
  1. Copy the script to a dir you like, make sure it is executable.
```
chmod +x sh_template.sh
cp sh_template.sh ~/Documents/Scripts/bash
```
      
  2. Create symbolic link of the script and link it to /usr/local/bin/
```
ln -s ~/Documents/Scripts/bash/sh_template.sh /usr/local/bin/sh_template
```


How to use
----------
sh_template.sh
  Create executable shell template.
```
sh_template new_script_name "Description about the script"
```



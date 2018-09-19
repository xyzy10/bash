# bash
A useful collection of bash scripts.

How to install
--------------
  1. Copy the script to a dir you like, make sure it is executable.
```
chmod +x *.sh
cp sh_template.sh ~/Documents/Scripts/bash
```
      
  2. Create symbolic link of the script and link it to /usr/local/bin/
```
ln -s ~/Documents/Scripts/bash/sh_template.sh /usr/local/bin/sh_template
```

```
ln -s ~/Documents/Scripts/bash/tar_each.sh /usr/local/bin/tar_each
```

How to use
----------
sh_template.sh
  Create executable shell template.
```
sh_template new_script_name "Description about the script"
```

tar_each.sh
  It will gzip each file inside the the given dir, and put into a new directory at the same level call compressed. It will skip the common compression extension like .tgz .zip .7z .rar .bz2 .gz etc (for detail see the tar_each.sh)

```
tar_each dir/
```

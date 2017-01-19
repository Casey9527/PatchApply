# PatchApply
Create a shell script to apply patches onto kernel code

When I'm carrying forward KGDB patches from WR Linux 8 to WR Linux 9, I need to apply 28 patches on kernel source.
So I created this shell script to help me automate the process. Each time it patches one patch, it will give the
execution result of patch command. If there is an error, you can abort it. Otherwise, press key to continue.

# Usage
``` shell
sh patchApply.sh path/to/folder_containing_many_patches
```

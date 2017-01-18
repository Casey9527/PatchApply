# usage: sh patchApply.sh source_path

BUILD_DIR=`pwd`

echo "Starting from build dir: $BUILD_DIR"

echo "Copying patches..."

PATCH_DIR=$BUILD_DIR/$1/kgdb_patches_proj3.0_20161018

if [ ! -d "$PATCH_DIR" ]; then
    cp -rf /ala-lpggp52/cchen/workspace/yoctoProjs/x86_patches_proj3.0 $PATCH_DIR
    echo "Copying patches successed"
fi

SOURCE_DIR=$1

cd ${SOURCE_DIR}

echo "Patching into kernel source: `pwd`"

count=0
file_prefix=""
git status 2>&1|tee >>  $BUILD_DIR/patch.log

while [ $count -le 26 ]
do
    ((count++))
    echo -e "\n..#$count..\n" 2>&1 | tee -a $BUILD_DIR/patch.log
    
    printf -v file_prefix "%0.4d" $count   
    git am $PATCH_DIR/$file_prefix* 2>&1 | tee -a $BUILD_DIR/patch.log

    echo "Continue?"
    select yn in Yes No
    do
        case $yn in
         Yes)
             echo -e "patched ${count}th patch\n"
	     break
             ;;
         No)  
	     echo -e "patched `expr ${count}-1` patches\n"
             exit 0
	     ;;
        esac
    done
done

echo -e ""
git status 2>&1|tee >> $BUILD_DIR/patch.log

echo -e "\nPatches in total: $count !!!"

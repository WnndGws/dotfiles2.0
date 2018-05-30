#!/usr/bin/zsh
# Script used to keep all my dotfiles in order


if [[ $(ssh-add -l) == 0 ]]; then
    ssh-add
fi

cd $HOME

dir=$HOME/Git/dotfiles2.0
oldDir=$HOME/Git/old_dotfiles
mkdir -p $dir
mkdir -p $oldDir

# Need to pull changed files in case changed anything on other computer
echo "Pulling from git....."
cd $dir; git pull --all

echo "Backing up old files....."
for folder in $(fd --exclude "*git*" --hidden --no-ignore --max-depth 1 --type d --full-path $dir -x echo {/}); do
    rsync -rhPL $dir/$folder $oldDir > /dev/null 2>&1
done

for file in $(fd --exclude "*LIC*" --exclude "*READ*" --hidden --no-ignore --max-depth 1 --type f --full-path $dir -x echo {/}); do
    rsync -rhPL $dir/$file $oldDir > /dev/null 2>&1
done

echo "Creating new folders....."
for folder in $(fd --exclude "*git*" --hidden --no-ignore --max-depth 1 --type d --full-path $dir -x echo {/}); do
    ln -fs $dir/$folder $HOME/$folder
done

echo "Creating new files....."
for file in $(fd --exclude "*LIC*" --exclude "*READ*" --hidden --no-ignore --max-depth 1 --type f --full-path $dir --exec echo {/}); do
    ln -fs $dir/$file $HOME/$file
done

echo "Pushing new files to Git....."
for file in $(git ls-files --others --exclude-standard); do
    git add -p $file
    git commit -vS $file
done

for file in $(git diff --name-only); do
    git add -p $file
    git commit -vS $file
done

# Get list of installed packages
echo "Getting list of packages...."
pacman -Qe | awk '{print $1}' > $dir/.files/explicit_packages.txt
awk 'FNR==NR {a[$0]++; next} !a[$0]' $dir/.files/packages_base.txt $dir/.files/explicit_packages.txt > $dir/.files/packages_unique.txt
sed -i '/xorg-.*/d' $dir/.files/packages_unique.txt
rm $dir/.files/explicit_packages.txt

git add .
git commit -S .
# To handle new and deleted files
git push

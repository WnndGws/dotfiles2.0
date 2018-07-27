#!/usr/bin/zsh
# Script used to keep all my dotfiles in order

cd $HOME

dir=$HOME/Git/dotfiles2.0
oldDir=$HOME/Git/old_dotfiles
mkdir -p $dir
mkdir -p $oldDir

# Need to pull changed files in case changed anything on other computer
echo "Pulling from git....."
cd $dir; git pull --all

echo "Creating new folders....."
for folder in $(fd --exclude "*git*" --hidden --no-ignore --max-depth 1 --type d --full-path $dir -x echo {/}); do
    ln -fs $dir/$folder $HOME
done

echo "Creating new files....."
for file in $(fd --exclude "*LIC*" --exclude "*READ*" --hidden --no-ignore --max-depth 1 --type f --full-path $dir --exec echo {/}); do
    ln -fs $dir/$file $HOME
done

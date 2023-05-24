#!/bin/bash

# Banner
echo "

            █████╗ ██╗    ██╗███████╗███████╗ ██████╗ ███╗   ███╗███████╗        ███╗   ███╗ █████╗ ██╗   ██╗██╗
            ██╔══██╗██║    ██║██╔════╝██╔════╝██╔═══██╗████╗ ████║██╔════╝        ████╗ ████║██╔══██╗██║   ██║██║
            ███████║██║ █╗ ██║█████╗  ███████╗██║   ██║██╔████╔██║█████╗          ██╔████╔██║███████║██║   ██║██║
            ██╔══██║██║███╗██║██╔══╝  ╚════██║██║   ██║██║╚██╔╝██║██╔══╝          ██║╚██╔╝██║██╔══██║██║   ██║██║
            ██║  ██║╚███╔███╔╝███████╗███████║╚██████╔╝██║ ╚═╝ ██║███████╗███████╗██║ ╚═╝ ██║██║  ██║╚██████╔╝██║
            ╚═╝  ╚═╝ ╚══╝╚══╝ ╚══════╝╚══════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═╝
                                                                                                      
"
# version 2.0.7:
# Problem: 
# Now asking the user to enter the commit message and make this is must becase a commit message there will error.

# Section: System Check
echo "=== System Check ==="
echo "Checking system status..."

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "❌ Git is not installed. Please install Git to use this script."
    exit 1
fi

echo "✅ Git is installed."

echo

# Section: Commit Message
echo "=== Commit Message ==="

# Function to validate if a commit message is provided
validate_commit_message() {
    read -rp "✏️ Enter your commit message: " message
    if [[ -z $message ]]; then
        echo "Commit message cannot be empty. Please enter a commit message."
        return 1
    else
        return 0
    fi
}

# Prompt the user for a commit message until a non-empty message is entered
while ! validate_commit_message; do
    continue
done

echo

# Section: Git Add
echo "=== Git Add ==="
git add .
add_exit_code=$?

if [ $add_exit_code -ne 0 ]; then
    git add . &> add.log
fi

echo

# Section: Check Git Add Success
echo "=== Check Git Add Success ==="
if [ $add_exit_code -eq 0 ]; then
    echo "Git add successful! ✅"
    rm -f add.log
else
    echo "Git add failed. Please check your changes and try again. ❌"
    echo "Errors encountered during git add. Please check add.log for more details."
fi

echo

# Section: Git Commit
echo "=== Git Commit ==="
git commit -m "$message"
commit_exit_code=$?

if [ $commit_exit_code -ne 0 ]; then
    git commit -m "$message" &> commit.log
fi

echo

# Section: Check Git Commit Success
echo "=== Check Git Commit Success ==="
if [ $commit_exit_code -eq 0 ]; then
    echo "Commit successful! 🎉"
    rm -f commit.log
else
    echo "Commit failed. Please check your changes and try again. ❌"
    echo "Errors encountered during commit. Please check commit.log for more details."
fi

echo

# Section: Push Commit
echo "=== Push Commit ==="
current_branch=$(git symbolic-ref --short HEAD)

git push
push_exit_code=$?

if [ $push_exit_code -ne 0 ]; then
    git push &> push.log
fi

echo

# Section: Check Push Commit Success
echo "=== Check Push Commit Success ==="
if [ $push_exit_code -eq 0 ]; then
    echo "Commit pushed successfully! 🚀"
    rm -f push.log
else
    echo "Push failed. Please check your network connection and try again. ❌"
    echo "Errors encountered during push. Please check push.log for more details."
fi

echo

# Section: Push Commit Upstream
echo "=== Push Commit Upstream ==="

git push -u origin "$current_branch"
push_upstream_exit_code=$?

if [ $push_upstream_exit_code -ne 0 ]; then
    git push -u origin "$current_branch" &> push_upstream.log
fi

echo

# Section: Check Push Commit Upstream Success
echo "=== Check Push Commit Upstream Success ==="
if [ $push_upstream_exit_code -eq 0 ]; then
    echo "Branch published and commit pushed successfully! 🚀"
    rm -f push_upstream.log
else
    echo "Push upstream failed. Please check your network connection and try again. ❌"
    echo "Errors encountered during push upstream. Please check push_upstream.log for more details."
fi

echo

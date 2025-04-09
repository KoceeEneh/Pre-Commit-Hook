#!/bin/bash

echo " Scanning for secrets with Gitleaks..."

# Scan staged changes for secrets

if ! gitleaks detect --staged --no-banner > /dev/null 2>&1; then

    echo "Gitleaks found something sketchy in your staged files."
    echo "Commit blocked. Double-check for secrets before committing."
    exit 1

else
    echo "All clear! No secrets found."
    exit 0

fi

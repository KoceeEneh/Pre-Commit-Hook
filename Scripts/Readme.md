# Juice Shop + Gitleaks Pre-Commit Hook

This project integrates [OWASP Juice Shop](https://github.com/juice-shop/juice-shop) with a custom **Gitleaks pre-commit hook** to help detect and prevent secrets from being accidentally committed into your Git repository.

##  What is Gitleaks?

[Gitleaks](https://github.com/gitleaks/gitleaks) is a fast, lightweight, and open-source secrets detection tool for Git repos. It scans your codebase for hardcoded secrets like API keys, tokens, passwords, etc., and blocks commits if any are found.

## Features

- Pre-commit hook runs **automatically before every commit**
- Scans only **staged files**, so it's fast
- Blocks commits if secrets are detected
- Works locally – no server setup needed

## Requirements

- Git
- [Gitleaks installed](https://github.com/gitleaks/gitleaks#installation)
  

## Setup Instructions

1. **Clone the repo**

```bash
git clone https://github.com/your-username/juice-shop-gitleaks.git
cd juice-shop-gitleaks
```
2. **Install Gitleaks**

``` bash
brew install gitleaks    # macOS
# OR
scoop install gitleaks   # Windows
```

3. **Create the Git hook**

Create a file at .git/hooks/pre-commit and add this:
``` bash
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
```

4. **Make it executable**

``` bash
chmod +x .git/hooks/pre-commit
```

5. **Test it**
   
Try committing a file with a fake secret

```bash
echo "AWS_SECRET=abc123" >> test.txt
git add test.txt
git commit -m "test commit"
```

output: 
<img width="700" alt="Screenshot 2025-04-09 at 21 04 40" src="https://github.com/user-attachments/assets/560abf35-4ac8-415d-901a-4a81898947de" />

## Project Structure

```bash
.
├── .git/
│   └── hooks/
│       └── pre-commit  # ← your custom script
├── juice-shop/         # Juice Shop code here
└── README.md
```

## Credits
- OWASP Juice Shop
- Gitleaks by Zed
- Created with ❤️ by KoceeEneh

## Disclaimer

This hook only checks staged files. It doesn’t scan your entire repo history or untracked files — use full Gitleaks audits periodically for deep scans.




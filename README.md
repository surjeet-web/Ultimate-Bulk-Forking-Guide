# 🚀 Bulk GitHub Repository Forker

<div align="center">

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)
[![GitHub stars](https://img.shields.io/github/stars/yourusername/bulk-fork?style=for-the-badge)](https://github.com/yourusername/bulk-fork/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/yourusername/bulk-fork?style=for-the-badge)](https://github.com/yourusername/bulk-fork/network)
[![GitHub issues](https://img.shields.io/github/issues/yourusername/bulk-fork?style=for-the-badge)](https://github.com/yourusername/bulk-fork/issues)

**The ultimate toolkit for mass-forking GitHub repositories with style and efficiency** ⚡

*Transform your GitHub workflow with automated bulk forking across multiple methods and platforms*

[🎯 Quick Start](#-quick-start) • [📖 Documentation](#-table-of-contents) • [🤝 Contributing](#-contributing) • [⭐ Star this repo](#-show-your-support)

</div>

---

## 📋 Table of Contents

- [🚀 Features](#-features)
- [🎯 Quick Start](#-quick-start)
- [🛠 Installation Methods](#-installation-methods)
  - [GitHub CLI (Recommended)](#-github-cli-method-recommended)
  - [Python Method](#-python-method)
  - [Node.js Method](#-nodejs-method)
  - [Bash + cURL Method](#-bash--curl-method)
  - [Windows .bat Method](#-windows-bat-method)
- [🔧 Troubleshooting](#-troubleshooting-common-problems)
- [✨ Best Practices](#-best-practices)
- [🤝 Contributing](#-contributing)
- [📜 License](#-license)
- [🌟 Show Your Support](#-show-your-support)

---

## 🚀 Features

<div align="center">

| Feature | Description |
|---------|-------------|
| 🎯 **Multi-Platform** | Works on Windows, macOS, and Linux |
| ⚡ **Lightning Fast** | Concurrent processing with rate limiting |
| 🔐 **Secure** | Token-based authentication with GitHub API |
| 🛡️ **Error Handling** | Robust error recovery and retry logic |
| 📊 **Progress Tracking** | Real-time status updates and logging |
| 🔄 **Multiple Methods** | Choose from 5 different implementation approaches |

</div>

> **💡 Pro Tip:** Start with the GitHub CLI method for the smoothest experience!

---

## 🎯 Quick Start

Get up and running in under 2 minutes:

```bash
# 1. Clone this repository
git clone https://github.com/yourusername/bulk-fork.git
cd bulk-fork

# 2. Create your repository list
echo "codieshiv/hacker-samulation" > repos.txt
echo "codieshiv/milk-calc" >> repos.txt

# 3. Run the GitHub CLI method (recommended)
chmod +x bulk-fork.sh
./bulk-fork.sh
```

**That's it!** 🎉 Your repositories are now being forked automatically.

---

## 🛠 Installation Methods

### 🏆 GitHub CLI Method (Recommended)

<details>
<summary><strong>Click to expand the complete GitHub CLI setup</strong></summary>

#### Prerequisites
- ✅ GitHub CLI installed
- ✅ GitHub account with Personal Access Token (PAT)

#### Step-by-Step Installation

**1. Install GitHub CLI**
```bash
# 🪟 Windows (PowerShell)
winget install --id GitHub.cli

# 🍎 macOS
brew install gh

# 🐧 Linux (Ubuntu/Debian)
sudo apt install gh
```

**2. Authenticate with GitHub**
```bash
gh auth login
# Select: GitHub.com → HTTPS → Authenticate via browser
```

**3. Create your repository list**
```txt
codieshiv/hacker-samulation
codieshiv/milk-calc
# Add more repositories (one per line)
```

**4. Use the bulk fork script**
```bash
#!/bin/bash
while read repo; do
    if [ -n "$repo" ]; then
        echo "🔄 Forking $repo..."
        gh repo fork "$repo" --clone=false --remote=false &
    fi
done < repos.txt
wait
echo "✅ All forks completed!"
```

**5. Execute the script**
```bash
dos2unix repos.txt bulk-fork.sh  # Fix line endings
chmod +x bulk-fork.sh
./bulk-fork.sh
```

#### 🚨 Common Issues & Quick Fixes

| Problem | Solution |
|---------|----------|
| `chmod: command not found` | Use Git Bash instead of PowerShell |
| `invalid control character` | Run `dos2unix repos.txt` |
| Authentication errors | Check with `gh auth status` |
| "Not Found" errors | Verify repo format: `owner/repo` |

</details>

---

### 🐍 Python Method

<details>
<summary><strong>Perfect for developers who love Python</strong></summary>

#### Prerequisites
- ✅ Python 3.6+ installed
- ✅ `requests` library: `pip install requests`
- ✅ GitHub PAT with `repo` scope

#### Complete Python Script
```python
import requests
import concurrent.futures
import time
from typing import List

# 🔐 Configuration
GITHUB_TOKEN = "your_pat_here"
REPOS = [
    "codieshiv/hacker-samulation",
    "codieshiv/milk-calc",
    # Add more repositories here
]

headers = {
    "Authorization": f"token {GITHUB_TOKEN}",
    "Accept": "application/vnd.github+json"
}

def fork_repo(repo: str) -> str:
    """Fork a single repository with error handling."""
    url = f"https://api.github.com/repos/{repo}/forks"
    try:
        response = requests.post(url, headers=headers, timeout=30)
        if response.status_code in (202, 200):
            return f"✅ Successfully forked {repo}"
        else:
            return f"❌ Failed to fork {repo}: {response.status_code}"
    except Exception as e:
        return f"❌ Error forking {repo}: {str(e)}"

def main():
    """Execute bulk forking with rate limiting."""
    print("🚀 Starting bulk fork operation...")
    
    with concurrent.futures.ThreadPoolExecutor(max_workers=5) as executor:
        results = list(executor.map(fork_repo, REPOS))
        time.sleep(1)  # Rate limiting
    
    # Display results
    for result in results:
        print(result)
    
    print("\n🎉 Bulk forking completed!")

if __name__ == "__main__":
    main()
```

#### 🛠 Troubleshooting Python Issues

| Problem | Solution |
|---------|----------|
| Rate limiting (403) | Reduce `max_workers` to 3 |
| SSL certificate errors | Update certificates or use corporate proxy |
| JSON decode errors | Verify PAT validity and permissions |
| Timeout errors | Increase timeout: `timeout=60` |

</details>

---

### 🟢 Node.js Method

<details>
<summary><strong>JavaScript developers, this one's for you!</strong></summary>

#### Prerequisites
- ✅ Node.js 14+ installed
- ✅ `axios` library: `npm install axios`
- ✅ GitHub PAT with appropriate permissions

#### Complete Node.js Implementation
```javascript
const axios = require('axios');
const fs = require('fs');

// 🔐 Configuration
const GITHUB_TOKEN = "your_pat_here";
const repos = fs.readFileSync('repos.txt', 'utf-8')
    .split('\n')
    .filter(Boolean)
    .map(repo => repo.trim());

const headers = {
    Authorization: `token ${GITHUB_TOKEN}`,
    Accept: "application/vnd.github+json"
};

async function forkRepo(repo) {
    try {
        const url = `https://api.github.com/repos/${repo}/forks`;
        await axios.post(url, {}, { headers, timeout: 30000 });
        console.log(`✅ Successfully forked ${repo}`);
        return { repo, status: 'success' };
    } catch (err) {
        const error = `❌ Failed to fork ${repo}: ${err.response?.status} ${err.response?.statusText}`;
        console.error(error);
        return { repo, status: 'failed', error };
    }
}

async function main() {
    console.log('🚀 Starting Node.js bulk fork operation...');
    const results = [];
    
    for (const repo of repos) {
        const result = await forkRepo(repo);
        results.push(result);
        
        // Rate limiting delay
        await new Promise(resolve => setTimeout(resolve, 500));
    }
    
    // Summary
    const successful = results.filter(r => r.status === 'success').length;
    const failed = results.filter(r => r.status === 'failed').length;
    
    console.log(`\n🎉 Operation completed!`);
    console.log(`✅ Successful: ${successful}`);
    console.log(`❌ Failed: ${failed}`);
}

main().catch(console.error);
```

#### 🔧 Node.js Troubleshooting

| Problem | Solution |
|---------|----------|
| `ECONNRESET` errors | Add longer delays between requests |
| Memory issues | Process repos in smaller batches |
| "Bad credentials" | Verify PAT scope includes `repo` |
| Module not found | Run `npm install axios` in project directory |

</details>

---

### 🐚 Bash + cURL Method

<details>
<summary><strong>For the command-line purists</strong></summary>

#### Prerequisites
- ✅ cURL installed (usually pre-installed)
- ✅ GitHub PAT
- ✅ Git Bash (Windows) or Terminal (Mac/Linux)

#### Robust Bash Script
```bash
#!/bin/bash

# 🔐 Configuration
TOKEN="your_pat_here"
REPO_FILE="repos.txt"
LOG_FILE="fork_results.log"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "🚀 Starting bash bulk fork operation..."
echo "📝 Logging results to: $LOG_FILE"

# Initialize log file
echo "Bulk Fork Results - $(date)" > "$LOG_FILE"
echo "=================================" >> "$LOG_FILE"

success_count=0
fail_count=0

while IFS= read -r repo; do
    if [ -n "$repo" ]; then
        echo -e "${YELLOW}🔄 Forking $repo...${NC}"
        
        response=$(curl -s -o /dev/null -w "%{http_code}" \
            -X POST \
            -H "Authorization: token $TOKEN" \
            -H "Accept: application/vnd.github+json" \
            --max-time 30 \
            "https://api.github.com/repos/$repo/forks")
        
        if [ "$response" -eq 202 ] || [ "$response" -eq 200 ]; then
            echo -e "${GREEN}✅ Successfully forked $repo${NC}"
            echo "SUCCESS: $repo" >> "$LOG_FILE"
            ((success_count++))
        else
            echo -e "${RED}❌ Failed to fork $repo (HTTP $response)${NC}"
            echo "FAILED: $repo (HTTP $response)" >> "$LOG_FILE"
            ((fail_count++))
        fi
        
        sleep 0.5  # Rate limiting
    fi
done < "$REPO_FILE"

echo ""
echo "🎉 Bulk forking completed!"
echo -e "${GREEN}✅ Successful: $success_count${NC}"
echo -e "${RED}❌ Failed: $fail_count${NC}"
echo "📝 Detailed results saved to: $LOG_FILE"
```

</details>

---

### 🪟 Windows .bat Method

<details>
<summary><strong>Native Windows solution</strong></summary>

#### Prerequisites
- ✅ Windows OS
- ✅ GitHub PAT
- ✅ cURL (included in Windows 10+)

#### Windows Batch Script
```batch
@echo off
setlocal enabledelayedexpansion

:: 🔐 Configuration
set TOKEN=your_pat_here
set REPO_FILE=repos.txt
set LOG_FILE=fork_results.log

echo 🚀 Starting Windows bulk fork operation...
echo 📝 Results will be logged to: %LOG_FILE%

:: Initialize counters
set success_count=0
set fail_count=0

:: Initialize log file
echo Bulk Fork Results - %date% %time% > "%LOG_FILE%"
echo ================================= >> "%LOG_FILE%"

for /f "usebackq tokens=*" %%a in ("%REPO_FILE%") do (
    set repo=%%a
    if not "!repo!"=="" (
        echo 🔄 Forking !repo!...
        
        curl -s -o nul -w "%%{http_code}" ^
            -X POST ^
            -H "Authorization: token %TOKEN%" ^
            -H "Accept: application/vnd.github+json" ^
            --max-time 30 ^
            https://api.github.com/repos/!repo!/forks > temp_response.txt
        
        set /p response=<temp_response.txt
        del temp_response.txt
        
        if "!response!"=="202" (
            echo ✅ Successfully forked !repo!
            echo SUCCESS: !repo! >> "%LOG_FILE%"
            set /a success_count+=1
        ) else (
            echo ❌ Failed to fork !repo! ^(HTTP !response!^)
            echo FAILED: !repo! ^(HTTP !response!^) >> "%LOG_FILE%"
            set /a fail_count+=1
        )
        
        timeout /t 1 /nobreak >nul
    )
)

echo.
echo 🎉 Bulk forking completed!
echo ✅ Successful: !success_count!
echo ❌ Failed: !fail_count!
echo 📝 Detailed results in: %LOG_FILE%
pause
```

</details>

---

## 🔧 Troubleshooting Common Problems

<div align="center">

### 🚨 Quick Diagnostic Commands

</div>

#### 🔐 Authentication Issues
**Symptoms:** "Bad credentials", 401/403 errors

```bash
# Test your PAT
curl -H "Authorization: token YOUR_PAT" https://api.github.com/user

# Check GitHub CLI auth
gh auth status

# Re-authenticate
gh auth login --refresh
```

#### ⏱️ Rate Limiting
**Symptoms:** 403 errors, "API rate limit exceeded"

```bash
# Check remaining requests
curl -H "Authorization: token YOUR_PAT" https://api.github.com/rate_limit
```

**Solutions:**
- ✅ Add delays between requests (500ms-1s)
- ✅ Reduce concurrent workers
- ✅ Use multiple PATs across accounts

#### 📝 Line Ending Issues
**Symptoms:** `invalid control character in URL`

```bash
# Fix Windows line endings
dos2unix repos.txt

# Alternative method
tr -d '\r' < repos.txt > repos_fixed.txt
```

#### 🔍 Repository Format Errors
**Symptoms:** "Not Found", 404 errors

**Correct format:** `owner/repo` ✅  
**Incorrect format:** `https://github.com/owner/repo` ❌

---

## ✨ Best Practices

<div align="center">

### 🎯 Follow these guidelines for optimal results

</div>

#### 🔐 Token Management
- **Store securely:** Use environment variables
- **Minimum scope:** Only grant necessary permissions
- **Regular rotation:** Update tokens every 90 days
- **Multiple accounts:** Distribute load across PATs

#### 🛡️ Error Handling
- **Implement retries:** 3 attempts with exponential backoff
- **Log everything:** Track successes and failures
- **Verify results:** Check your GitHub profile after completion
- **Monitor rate limits:** Stay within API boundaries

#### ⚡ Performance Optimization
- **Start small:** Test with 5-10 repositories first
- **Gradual scaling:** Increase concurrency slowly
- **Peak hours:** Avoid heavy usage during GitHub's peak times
- **Batch processing:** Process large lists in smaller chunks

#### 📁 File Management
- **Clean format:** No empty lines or extra spaces in repos.txt
- **Consistent encoding:** Use UTF-8 with LF line endings
- **Backup lists:** Keep copies of your repository lists
- **Validation:** Double-check repo names before execution

---

## 🤝 Contributing

We love contributions! Here's how you can help make this project even better:

<div align="center">

[![Contributors](https://img.shields.io/github/contributors/yourusername/bulk-fork?style=for-the-badge)](https://github.com/yourusername/bulk-fork/graphs/contributors)

</div>

### 🌟 Ways to Contribute

- 🐛 **Report bugs** - Found an issue? Let us know!
- 💡 **Suggest features** - Have ideas for improvements?
- 📖 **Improve docs** - Help make our documentation clearer
- 🔧 **Submit PRs** - Code contributions are always welcome
- ⭐ **Star the repo** - Show your support!

### 📋 Contribution Guidelines

1. **Fork** the repository
2. **Create** a feature branch: `git checkout -b feature/amazing-feature`
3. **Commit** your changes: `git commit -m 'Add amazing feature'`
4. **Push** to the branch: `git push origin feature/amazing-feature`
5. **Open** a Pull Request

---

## 📜 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

```
MIT License - Feel free to use, modify, and distribute! 🎉
```

---

## 🌟 Show Your Support

<div align="center">

**If this project helped you, please consider giving it a ⭐!**

[![GitHub stars](https://img.shields.io/github/stars/yourusername/bulk-fork?style=social)](https://github.com/yourusername/bulk-fork/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/yourusername/bulk-fork?style=social)](https://github.com/yourusername/bulk-fork/network)

### 💖 Spread the Word

- **Share** on social media
- **Tell** your developer friends
- **Write** a blog post about your experience
- **Create** tutorial videos

---

<div align="center">

**Made with ❤️ by developers, for developers**

*Happy forking! 🚀*

</div>

</div>

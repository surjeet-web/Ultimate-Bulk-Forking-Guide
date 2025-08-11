# **#GitHubLifeCrisis: When You Lose Your 3yo Account & Need to Fork Everything Like Yesterday 💀😭**

Soooo guess who lost access to their 3-year-old GitHub account? THIS GIRL/BOY/THEY 💅✨ Like, bye-bye to all my cred, my stars, my precious repos that I totally updated regularly (haha jk I have commitment issues).

But plot twist! I made a new account and then realized I had to fork ALL my old repos to new one? As if?! 🙄 Going repo by repo? Honey, I don't have that kind of time - I have TikToks to watch and 47 tabs of memes to get through.

So I did what any self-respecting dev would do - I found a way to cheat the system 😎👌

## **The "I'm Too Lazy for This" Method:**

### **Step 1: Open ALL THE REPOS AT ONCE**

- Go to your old account
- Click on your repo list
- Hit CTRL + right-click on ALL repos (yes, all of them)
- Open in new tabs like the chaotic legend you are

### **Step 2: Get a Browser Extension Called Session Buddy**

Download this magic tool: [**https://shorturl.at/k9Qxp**](https://shorturl.at/k9Qxp)

### **Step 3: Copy All Those URLs Like a Boss**

- Open Session Buddy
- Select all your GitHub repos (multi-select queen/king behavior)
- Find the three dots in the bottom right
- Copy those URLs like you're stealing code (which you kinda are lol)

## **The Actual Techy Stuff (Stay With Me)**

### **1. Install GitHub CLI (It's Not as Scary as It Sounds)**

- **Windows peasants**: Download from [**https://cli.github.com**](https://cli.github.com/)
- **Mac/Linux cool kids**
- 

brew install gh  # For my Mac besties
sudo apt install gh  # Ubuntu/Debian squad

**2. Login to GitHub (Yes, You Have to Do This)**

gh auth login

### **3. Create Some Files in a Folder (Organized? Who Are You?)**

- **`repos.txt`** → paste all those repo URLs you copied earlier
- **`bulk-fork.sh`** → this is your magic script (I'll give you the code, don't worry)

### **4. Open Git Bash in That Folder**

You’re in **Git Bash**, but:

1. You’re not inside the folder with `bulk-fork.sh`.
2. The folder path has spaces and parentheses, which messes with Git Bash if not quoted.

---

### **Here’s how to fix it:**

### 1️⃣ Change directory properly in Git Bash

Instead of typing `CD` like in Windows, use lowercase `cd` in Git Bash and wrap the path in quotes:

```bash
bash
CopyEdit
cd "/X/Users/X/Desktop/New X/New folder (2)"

```

---

### 2️⃣ Make the script executable

```bash
bash
CopyEdit
chmod +x bulk-fork.sh

```

---

### 3️⃣ Run the script

```bash
bash
CopyEdit
./bulk-fork.sh

```

---

💡 Tip: In Git Bash, Windows drives like `C:\` are written as `/c/`.

So:

```
makefile
CopyEdit
C:\Users\shivt\Desktop

```

becomes:

```
bash
CopyEdit
/c/Users/shivt/Desktop

```

Yes, another step, but we're so close I can taste the efficiency!

### **5. Convert Text to Unix Format (Fancy Tech Words)**

dos2unix repos.txt

### **Convert to Unix line endings**

In Git Bash, run this on your `repos.txt`:

```bash

dos2unix repos.txt

```

If `dos2unix` isn’t installed, you can also do:

```bash

tr -d '\r' < repos.txt > repos_clean.txt
mv repos_clean.txt repos.txt

```

---

### **Extra tips**

1. Also make sure the repo list **does not include** `https://github.com/` — only `owner/repo`.
    
    ✅ Correct:
    
    ```
    bash
    CopyEdit
    codieshiv/hacker-samulation
    codieshiv/milk-calc
    
    ```
    
    ❌ Wrong:
    
    ```
    arduino
    CopyEdit
    https://github.com/codieshiv/hacker-samulation
    
    ```
    

**6. Make Script Executable (Ooh, Command Line Magic)**

chmod +x [bulk-fork.sh](http://bulk-fork.sh/)

**7. RUN THE SCRIPT AND WATCH THE MAGIC HAPPEN**

./bulk-fork.sh

And boom! All your repos are now forked to your new account. You're welcome. 🎉✨

Check out my GitHub for the full documentation and actual code (pls give me a star, I need validation for my existence):

[Link to my GitHub repo]

Now you can tell your mom you're still a successful developer who has their life together! 💻✌️ #DevLife #GenZCoder #GitHubHacks #TooLazyToManual #TechLifeCrisis

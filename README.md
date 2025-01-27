<div align="center">
    <img src="https://github.com/kounkou/Hedgehog/actions/workflows/build.yml/badge.svg"  alt="Hedgehog workflow">
	<a href="https://github.com/kounkou/hedgehog/graphs/contributors">
		<img src="https://img.shields.io/github/contributors/kounkou/hedgehog.svg?style=flat">
	</a>
</div>

----

<div align="center">
    <a href="https://buymeacoffee.com/kounkou">
        <img width="250" src="images/buy-me-a-coffee.png" alt="Buy Me A Coffee">
    </a>
</div>

<img width="1212" alt="Screenshot 2024-10-27 at 11 20 15 AM" src="images/welcome.png">

# Topics

<img width="1212" alt="Screenshot 2024-10-22 at 4 08 13 PM" src="images/categories.png">

# Editor

<img width="1042" alt="Screenshot 2024-10-17 at 8 59 40 AM" src="images/code-editor.png">

# Statistics

<img width="1212" alt="Screenshot 2024-10-28 at 12 57 31 PM" src="images/stats-1.png">
<img width="1212" alt="Screenshot 2024-10-28 at 12 57 31 PM" src="images/stats-2.png">
<img width="1212" alt="Screenshot 2024-10-28 at 12 57 31 PM" src="images/stats-3.png">

# Platforms

- MacOS   (Full compatibility)
- Linux   (Testing in progress)
- Windows (Not tested)

For the best experience, I currently recommend using Hedgehog on macOS for its optimal look and feel. That said, you can still run the application on Linux. I'm actively refining the styles for both platforms to ensure a polished experience across all operating systems.


# Hedgehog

In an AI-driven world, algorithms and data structures remain critical for optimizing, debugging, and understanding systems at a deeper level. While AI tools can automate many aspects of coding, they cannot replace the fundamental knowledge required to create, understand, and refine complex software solutions effectively.


# How it works

### Architecture 

<img width="1001" alt="Screenshot 2024-10-18 at 9 35 34 AM" src="images/architecture.png">


### Hedgehog features

Hedgehog is a user-friendly tool designed to help users tackle challenges and track their progress. It offers a clean interface and efficient features to streamline solving challenges.
Key features of Hedgehog include:

- A timer to keep users focused and engaged.
- The ability to pause and resume the timer, automatically restarting when the user begins editing again, ensuring flexibility during interrupted sessions.
- Language options, currently supporting C++ and Golang, with potential for easy expansion to more languages.
- Light and dark themes to reduce eye strain and enhance comfort.
- A solution display with a toggle to switch between the user's submitted code and the expected solution.
- The ability to skip a question and proceed to the next one.
- An option to retry the same question, encouraging continued learning and improvement.

# Installation instructions

Hedgehog relies on Qt to provide you with the amazing user interface
Hedgehog-server is accessible at https://github.com/kounkou/Hedgehog-server

**MacOS**
```bash
brew install qt@5
brew link --force qt@5 --overwrite
```

**Linux**
```bash
sudo apt-get update
sudo apt install -y qtbase5-dev qt5-qmake qtwebengine5-dev
```

You can check out Qt install on other platforms here : 

https://doc.qt.io/qt-6/get-and-install-qt.html

# How to build, install and execute Hedgehog

You can launch below commands which will generate the binary file and install the binary in /Applications/ folder

```bash
bash install.sh
```

To launch Hedgehog from the Terminal : 

**MacOS**
```bash
cd /Applications/Hedgehog/
./Hedgehog
```

**Linux**
```bash
cd /home/<YOUR USERNAME>/Hedgehog/
./Hedgehog
```

# Contribution guidelines

Your contributions are welcome! Please see the [contributing guidelines](https://github.com/kounkou/Hedgehog/blob/main/CONTRIBUTING.md)

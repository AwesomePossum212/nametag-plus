# Contribution Guide

Thank you for your interest in contributing to Nametag+! If you're confused on how to help out, this guide should hopefully clarify some things for you. If you already know how to use GitHub, you can skip part 1.

**1 - Intro to GitHub**

GitHub is an online codebase software designed for collaborating on development. There are a few key vocab places in this repository that you should be familiar with:
- Code: Where the production codebase is. This shows you the file directory, a preview of the Readme, and allows you to view the code.
- Issues: Here is where you can create a new bug report or specific feature request (with use cases) for Nametag+.
- Pull Requests (PRs): This is where you can go if you'd like to contribute to Nametag+. Once you've forked (cloned) this repository and edited it in a way you think is useful, you can create a PR to indicate that you want to merge your edits into this main repository. Collborators will review your changes and approve or deny your request.
- Discussion: If you need help, want to show off how you're using Nametag+ or want to talk about ideas for the future of Nametag+, you can go here to discuss this with your fellow contributors.

**2 - License notice**

All of the content uploaded to this repository is available for anyone, anywhere to use under the Unlicense license. This means that your contribution(s) will be put into the public domain (or local equivalent) worldwide. Only contribute if you are comfortable releasing your content under this license. Once your changes are committed, you CANNOT restrict usage of it. Now that the boring legal stuff is out of the way (I am not a lawyer and that was not legal advice)...

**3 - Getting started**

So, you think you can improve Nametag+? Here's how to get involved:
- To get started, first, fork the repository to make a linked copy (button at the top right corner of the screen).
- Next, either check issues to see what needs to be fixed/changed and/or edit the code in a way that you feel improves it. 
- Be sure to add documentation where your code may be confusing and follow the style outlined in the code.
- Once you feel that you have sufficiently improved your fork, double-check it for bugs
- Then create a pull request. After you do this, collaborators will review your changes, then approve and merge them or deny and leave comments.

**4 - Style and documentation**

You may notice that there is already some documentation included with Nametag+. Please follow this style, by doing the following:
- Add whitespace as approprite between sections.
- Start each section with a major comment (-->>) describing what it does.
  - Follow the layout set up in existing scripts by ordering the main chunks as "Services and modules" > "Initial set up tasks" > main body > "Wrapping up loose ends"
  - Add documentation to functions as already shown in the format "-->>(Function) [Tags such as [Yields] or [Returns SOMETHING]] nameOfFunction(parameter: type, parameter: type)" and add another minor comment underneath concerning what the function does.
- Add a minor comment (--) to the end of any line that may be unclear.
- Use Roblox Studio's absolute indentation feature to make consistent indents.

**5 - Repository etiquette**

In order to keep the repository organized, please adhere to the following rules:
- (Maintainers only) Don't commit directly to the master branch. Create a new branch and PR with your requested changes for peer approval.
- (Maintainers only) Include a .rbxl file with examples in every release to make it easy for beginners to understand.
- Use the appropriate category in discussions and stay on-topic with your replies.
- Put all code related to the nametag system in the src folder, while keeping all of the repository stuff (i.e. Readme.md) in .github.
- Use issues only for specific bug reports and feature requests. General ideas should go into discussions.
- Keep your content PG and in line with the Code of Conduct.

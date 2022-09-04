# dotfiles
Back up of my dot files for Linux/ Mac.
<br>
<br>
Create a Brewfile From Your Existing Environment <br>
<code># create Brewfile </code><br>
<code>brew bundle dump</code>

<br>
To restore your environment from another machine, copy the Brewfile created from the previous command to your new machine (or clone from publicly accessible repository) and run the following command:
<br>

<code>
# install packages from Brewfile in current directory </code>
<br>
<code>brew bundle install
</code>
<br>
<br>

Copy executables from usr/bin/ folder to /usr/local/bin

<br> 
Some helpful links <br>
https://zihao.me/post/managing-dotfiles-with-gnu-stow/ <br>
https://engineeringfordatascience.com/posts/automate_mac_setup_with_brewfile/ <br>
https://medium.com/@protiumx/bash-gnu-stow-take-a-walk-while-your-new-macbook-is-being-set-up-351a6f2f9225

![](img/2022-09-04-16-39-42.png)

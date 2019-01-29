From https://www.reddit.com/r/FirefoxCSS/comments/7mwfoi/my_notquite_singlebar_setup_finally_happy_with/

---

#Screenshots!

* [Linux Mint screenshot](https://i.imgur.com/NKvSAYZ.jpg) (Same as OP.)
* [Windows 10 screenshot](https://i.imgur.com/WmwpdAu.png)
* ['Customize' area screenshot](https://i.imgur.com/KSk9rIm.png)
* ['Sound playing' tab animation](https://streamable.com/0l7f9) (Streamable, but silenced)

&nbsp;

---

#Preparation!

I'm not a huge fan of doing everything with CSS. It can get quite messy. So to prepare Firefox for this theme, follow these steps:

&nbsp;

* Use the 'customize' interface to:
 * Enable title bar
 * Move bookmark items into toolbar
 * Move other toolbar items around as you see fit
 * Optional: Use 'compact' density and 'dark' theme
* If you want the tabs, install [TreeStyleTab](https://addons.mozilla.org/en-US/firefox/addon/tree-style-tab/)

&nbsp;

---

#Using the theme!

**For those who know what you're doing:**

* [TreeStyleTab custom CSS](https://raw.githubusercontent.com/TanzNukeTerror/Custom-Firefox/master/TreeStyleTabs.css)
* [bindings.xml](https://raw.githubusercontent.com/TanzNukeTerror/Custom-Firefox/master/bindings.xml)

 ^([ **NOTE:** I don't remember who I got this from, but it changes the URL bar so it displays only the domain name when not focused. However, it seems to have an issue where when I start typing something, down-arrow over a suggestion, then up-arrow back into the box, it does this: `moz-action:searchengine,{"engineName":"DuckDuckGo","input":"examplesearch","searchQuery":"examplesearch"}` If anyone knows a fix for that, please let me know. ])
* [userChrome.css](https://raw.githubusercontent.com/TanzNukeTerror/Custom-Firefox/master/userChrome.css)
* [userContent.css](https://raw.githubusercontent.com/TanzNukeTerror/Custom-Firefox/master/userContent.css)

&nbsp;

**For those who don't:** Follow the steps below and nothing should break.

&nbsp;

## bindings.xml, userChrome.css, and userContent.css:

* Open a new tab, go to `about:profiles`

* Under 'Profile: default', there will be a box that says 'Root Directory'

* On the far right of that, there should be an 'Open Folder' button. Click it.

* Once the folder is open, create a new folder called `chrome`

* Open the `chrome` folder you just created

* Create `bindings.xml` in that folder, with [this code](https://raw.githubusercontent.com/TanzNukeTerror/Custom-Firefox/master/bindings.xml) inside

* Create `userChrome.css` in the same folder, with [this code](https://raw.githubusercontent.com/TanzNukeTerror/Custom-Firefox/master/userChrome.css) inside

* Create `userContent.css` in the same folder, with [this code](https://raw.githubusercontent.com/TanzNukeTerror/Custom-Firefox/master/userContent.css) inside

* Restart Firefox

&nbsp;

## Tree Style Tab

* Go to the Tree Style Tab settings.  
( Tools -> Add-ons -> Click 'Options' on the Tree Style Tab entry )

* Scroll down, leave the theme set to 'plain' (should be the default)

* A little below that, set 'Indent tabs until' to 0 (Optional, since it's nice to have a visual on tab children. I don't know how to dynamically reduce the indent space.)

* Scroll all the way down to 'Advanced' and paste [this code](https://raw.githubusercontent.com/TanzNukeTerror/Custom-Firefox/master/TreeStyleTabs.css) into the 'Extra rules for sidebar contents' box. (You're safe to get rid of whatever's there by default.)

&nbsp;

---


# Professor review

A mobile application for reviewing university professors.  
Developed using Flutter and Firebase.  
The objective of this app is to provide the much needed transparency
that our society demands and valuable feedback to the professors.  

## How to install

First of all, this app only works on Android for now.  
You can find the .apk files for arm64, armeabi and x86_64 architectures in
the out/release folder.  
If for some reason you cannot install the .apk, setup Flutter on your computer. 
You can find links to tutorials in the wiki.
After that, download or clone the project, connect your Android device
to your computer and, from your command line, run:  
* `cd<app_dir>`, where app_dir is application directory.
* `flutter install`

## How to use the app

First, you need to create an account (or login if you already have one).  

<img src="images/screenshots/auth.jpeg"  width="250" height="490">
<img src="images/screenshots/login.jpeg"  width="250" height="490">
<img src="images/screenshots/register.jpeg"  width="250" height="490">  

On the home screen, you will find a search bar, a list of the best rated 
universities and two icons on the right corner of the top bar. 

<img src="images/screenshots/home.jpeg"  width="250" height="490">  

Press the icon on the right to logout.  
<img src="images/screenshots/confirmlogout.jpeg"  width="250" height="490">  
Press the other icon to view your profile.  
<img src="images/screenshots/user_profile_screen.jpeg"  width="250" height="490">  
Here, you will find the average rating that you give to professors, and a list 
of your reviews.  
Press a review to view it.  
<img src="images/screenshots/review.jpeg"  width="250" height="490">  

A review contains the pros and the cons of the professor and a few ratings.  
A review screen also contains two boxes at the top, one with the user who submitted
the review and one with the professor that the user reviewed. Pressing either 
one will take you to a profile screen.  

At the top of a professor's profile screen, you will find the professor's university
and their faculty. You can press either one and it will take to a profile screen.    
<img src="images/screenshots/professor_profile_screen.jpeg"  width="250" height="490">  

Below that, you will see the professor's rating and a list of their reviews.
You will also see a Add Review button. Pressing it will take you to the 
review submittion screen.  

<img src="images/screenshots/submit_review.jpeg"  width="250" height="490">  

To search for a specific professor or university, go back to the home screen
and press the search bar. Another screen will appear, where you can perform
the search. Please note that you have the enter the full name of the university,
if you are searching for a university, or the full first name/ last name, if
you are searching a professor. Also, please note, that the searches are NOT
case sensitive yet.  
<img src="images/screenshots/search_screen.jpeg"  width="250" height="490">



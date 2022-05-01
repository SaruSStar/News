# news_application

A new Flutter project.

## Getting Started

This is a kind of news app using https://newsapi.org

Screenshots of the project are provided in the Screenshots folder

- user can register for an account each account will be saved on local storage using sqflite.
- if the user exists, it will be noticed.
- while logging in, the user doesn't exist, and credential errors will be noticed.
- in the home page top news (latest news) slider view.
- news list view and filter chips are available on the home page (category filter no longer available in newsapi.org so source filter is there).
- pagination added to the home page news list.
- each card will navigate to a single news page, which is a scrollable and draggable sheet with glassmorphic container.
- when searching with a text from the home page. it will navigate to the filter page with filtered news.
- when tapping on the filter chip, the bottom filter sheet will open with the filter details of sortBy and language (category filter no longer available in newsapi.org). it will filter news behind the sheet. when tapping on the SAVE button, the sheet disappiers.

#kindly go to the site to watch the demo video.
https://drive.google.com/file/d/1RxLOGfyvvQJqKxf8OSW6Azb6Q6tb2vSV/view?usp=sharing

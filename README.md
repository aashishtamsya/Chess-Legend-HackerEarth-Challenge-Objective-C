# HackerEarth Challenge - Chess App

[![Platform](https://img.shields.io/badge/platform-ios-lightgrey.svg)]()
[![Programming Language](https://img.shields.io/badge/language-swift-orange.svg)]()
[![Scrutinizer Build](https://img.shields.io/scrutinizer/build/g/filp/whoops.svg?maxAge=2592000)]()

 


## Content

-	[Problem Statement](#problem-statement)
-	[Requirements](#requirements)
-	[Demo](#demo)
-	[Minimum Requirements Of Project](#minimum-requirements-of-project)
-	[Plus Point](#plus-point)
-	[Extra Work](#extra-work)
-	[Guide](#guide)
-	[Expectation](#expectation)
-	[Explanation on how to make them play against each other](#explanation-on-how-to-mak-them-play-against-each-other)
-	[Explanation on Elo rating system](#explanation-on-elo-rating-system)
-	[Installation](#installation)
-	[Contributing](#contributing)
-	[Credits](#credits)
-	[License](#license)


### Problem Statement

A pseudo iOS application which would let users list top 20 rated chess players of all-time and play them against each other using a random function.

### Requirements
* iOS 9.0+
* Xcode 7.0

### Demo

![DEMO](https://github.com/aashishtamsya/ImagesAnimation/blob/master/Resources/DEMO/DEMO.gif)

### Minimum Requirements Of Project

*	Players details. Use the url mentioned below which contains the JSON consisting of details.
*	Visually interactive design to list Players.

*	Write a function to select two players of your choice and play them against each other.

*	Submit Source code, Screenshots & detailed deployment instructions.

### Plus Point

*	Make beautiful information intensive graphs.

*	Represent statistics of a match in those graphs.

*	Implement paging to display the players list properly.

*	Feel free to use your favourite iOS Development SDK and tools in development and design.

### Extra Work

*	Display the probability of win of a particular player against a stronger opponent in a graph.

*	Custom design, font and icons to make app more user-friendly.

*	You may add portfolio activity comprising awesome work you have done in iOS.

*	Use your imagination and add features which would make things easier for end users.

*	Beautify; Comment; Documented code; handle Input Exceptions, Unicode and Null values.

### Guide

*	Mokriya Battle of Legends Data Url: https://goo.gl/oRJrE8

*	iOS JSON:

http://devdactic.com/rest-api-parse-json-swift/


### Expectation

*	You are expected to fetch top-rated player details from the provided url, list them based on their rating.

*	Allow users to select any two of them and play them against each other.

*	Display results on a pie chart or any graph, calculate their new rating using Elo rating system (with 'n' = 400 and k-factor = 32) and update their new rating locally.

*	Display their updated rating on the UI.

### Explanation on how to make them play against each other

*	Use a random function from range 1 to 3. If it generates 1, player 1 wins and gets 1 and player 2 gets 0. If it generates 2, player 2 wins and gets 1 and player 1 gets 0. If it generates 3, match is drawn and both get 0.5.

### Explanation on Elo rating system

*	Suppose two players with the current ratings r(1) and r(2) compete in a match. Calculate their updated rating r'(1) and r'(2) after said match.

*	Take 'n' = 400 and k-factor = 32.

*	The first step is to compute the transformed rating for each player or team:

`R(1) = 10r(1)/400`

`R(2) = 10r(2)/400`

*	This is just to simplify the further computations. In the second step we calculate the expected score for each player:

`E(1) = R(1) / (R(1) + R(2))`

`E(2) = R(2) / (R(1) + R(2))``

*	Now we wait for the match to finish and set the actual score in the third step:

`S(1) = 1 if player 1 wins / 0.5 if draw / 0 if player 2 wins`

`S(2) = 0 if player 1 wins / 0.5 if draw / 1 if player 2 wins`

*	Now we can put it all together and in a fourth step find out the updated Elo-rating for each player:

`r'(1) = r(1) + K * (S(1) – E(1))`

`r'(2) = r(2) + K * (S(2) – E(2))``

*	As a result, plot this r’(1) and r’(2) in a graph relatively.


### Installation

1. Download the zip or clone the repo to your desired directory.

```sh
$ git clone https://github.com/aashishtamsya/HackerEarth-Challenge.git
```


### Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request. 😉 😊

### Credits

Aashish Tamsya [@ChiefAashish](https://www.twitter.com/chiefaashish),
aashish.tamsya@gmail.com

### License

The content of [HackerEarth Challenge](https://github.com/aashishtamsya/HackerEarth-Challenge.git) itself is licensed under the [Creative Commons Attribution 3.0 license](https://creativecommons.org/licenses/by/3.0/us/deed.en_US), and the underlying source code used to format and display that content is licensed under the [MIT license](https://opensource.org/licenses/mit-license.php).

See the [LICENSE](LICENSE.md) file for more info.
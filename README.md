# SpaceX

## I have 2 dev accounts, which are somehow both linked to the same Github account. Just want to make sure there is no misunderstanding! 

## Architecture

I decided to use an MVVM approach: every view is accompanied by a view model. The view model handles core logic, whereas the view only displays data and generates events (managed by vm or router). You'll notice I also created a testable router to handle the navigation. 
My approach is protocol-oriented, as I want to avoid injecting direct implementations as dependencies (thus affecting testability).

## What you'll find 

You'll find designs implemented in SwiftUI, communication between ViewModels and Router implemented with Combine and very basic mocks which serve the purpose of testing.  

## What you won't find 

You won't find pagination / querying implemented. You won't find the mapping of 'Rockets'. I should be associating a Rocket to each 'Launch'. This wasn't implemented due to time constraints. 
Finally, you won't find computing of strings completed. I had to prioritise due to time constraints. 

## How much time was spent? 

I spent a total of two days working on this project. I had time to plan out communication between different components, protocols and UI. Unfortunately, I couldn't spend more time completing the project as I had to prioritise commitments at my current role. 

## What would I do better? 

I would implement pagination and querying using URLComponents and URLQueryItems. I'd write more detailed tests and test all the core components (at least). 

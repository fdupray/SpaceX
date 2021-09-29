# SpaceX

## Architecture

I decided to use an MVVM approach. In my case, you'll notice I also created a testable router to handle the navigation. 
My approach is protocol-oriented, as I want to avoid injecting direct implementations as dependencies (thus affecting testability).

## What you'll find 

You'll find designs implemented in SwiftUI, communication between ViewModels and Router is implemented with Combine. You'll find very basic mocks which serve the purpose of testing.  

## What you won't find 

You won't find pagination implemented. You won't find the mapping of 'Rockets'. I should be associating a Rocket to each 'Launch'. This wasn't implemented due to time constraints. 

## How much time was spent? 

I spent a total of two days working on this project. I had time to plan out communication between different components, protocols used and UI. 

## What would I do better? 

I would implement pagination 1st rather than fetching all the launches. I'd write more detailed tests and test all the core components (at least). 

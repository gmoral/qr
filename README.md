# Overview
It is an iOS application.

# Architectural principles
Two major sources of design principles are applied in this project:
1. I follow the principles of [Domain-Driven Design (Eric Evans)](https://www.amazon.com/Domain-Driven-Design-Tackling-Complexity-Software/dp/0321125215/ref=sr_1_1?keywords=domain+driven+design&qid=1668685151&sprefix=domain+d%2Caps%2C121&sr=8-1), which aims to to build software that is valuably involved in the activities of stakeholders. This is achieved through mutual understanding of those activities between the domain experts and the developers. This understanding is communicated through "ubiquitous" language - abstracted and disambiguated, evolving, and mutually agreed terminology that must be used "everywhere".
2. I follow the principles of the [Clean architecture (Bob Martin)](https://www.amazon.com/Clean-Architecture-Craftsmans-Software-Structure/dp/0134494164/ref=sr_1_1?crid=371MA00V3KH4J&keywords=clean+architecture&qid=1668680765&sprefix=clean+architecture%2Caps%2C88&sr=8-1), which divide components into a spectrum that spans "detail" - volatile concrete implementations, and "policy" - stable abstractions focussed on the domain solution. Martin argues that decisions related to detail components should be deferred for as long as possible, but he more broadly makes the case for change and readiness for change regardless of where the change comes from. He considers UI, DB, and frameworks in general to be details. So I embrace these ideas in the knowledge that I've already placed my bets on iOS. The principles of clean architecture, which you'll see laid out in our code below, will allow me to make such significant changes in a straightforward way.

## Clean Architecture
The color coding in the following diagrams adheres to the colors used in this public description of clean architecture. 

![Class](./README_files/clean_architecture.svg?raw=true "Clean architecture")

Each tier represents general areas of responsibility of components and the strict direction of their dependencies going from concrete volatile blue components down to the most abstract and stable yellow components. The outer layers know about any inner layers but not vice versa.

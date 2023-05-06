# Architectural principles
Two major sources of design principles are applied in this project:
1. I follow the principles of [Domain-Driven Design (Eric Evans)](https://github.com/gmoral/Books/blob/master/Domain%20Driven%20Design%20Tackling%20Complexity%20in%20the%20Heart%20of%20Software%20-%20Eric%20Evans.pdf) which aims to to build software that is valuably involved in the activities of stakeholders. This is achieved through mutual understanding of those activities between the domain experts and the developers. This understanding is communicated through "ubiquitous" language - abstracted and disambiguated, evolving, and mutually agreed terminology that must be used "everywhere".
2. I follow the principles of the [Clean architecture (Uncle Bob)](https://github.com/gmoral/Books/blob/master/Clean%20Architecture%20A%20Craftsman's%20Guide%20to%20-%20Robert%20C.%20Martin.epub), which divide components into a spectrum that spans "detail" - volatile concrete implementations, and "policy" - stable abstractions focussed on the domain solution. Martin argues that decisions related to detail components should be deferred for as long as possible, but he more broadly makes the case for change and readiness for change regardless of where the change comes from. He considers UI, DB, and frameworks in general to be details. So I embrace these ideas in the knowledge that I've already placed my bets on iOS. The principles of clean architecture, which you'll see laid out in our code below, will allow me to make such significant changes in a straightforward way.

## Clean Architecture
The color coding in the following diagrams adheres to the colors used in this public description of clean architecture. 

![Class](./README_files/CA.svg?raw=true "CA")

![clean_architecture](https://user-images.githubusercontent.com/805764/236639140-3e0e23fb-68bd-43a7-b3b7-6f92c32b3a32.svg)

Each tier represents general areas of responsibility of components and the strict direction of their dependencies going from concrete volatile blue components down to the most abstract and stable yellow components. The outer layers know about any inner layers but not vice versa.

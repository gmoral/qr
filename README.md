# Overview
It is an iOS application.

# Architectural principles
Two major sources of design principles are applied in this project:
1. I follow the principles of [Domain-Driven Design (Eric Evans)](https://github.com/gmoral/Books/blob/master/Domain%20Driven%20Design%20Tackling%20Complexity%20in%20the%20Heart%20of%20Software%20-%20Eric%20Evans.pdf) which aims to to build software that is valuably involved in the activities of stakeholders. This is achieved through mutual understanding of those activities between the domain experts and the developers. This understanding is communicated through "ubiquitous" language - abstracted and disambiguated, evolving, and mutually agreed terminology that must be used "everywhere".
2. I follow the principles of the [Clean architecture (Uncle Bob)](https://github.com/gmoral/Books/blob/master/Clean%20Architecture%20A%20Craftsman's%20Guide%20to%20-%20Robert%20C.%20Martin.epub), which divide components into a spectrum that spans "detail" - volatile concrete implementations, and "policy" - stable abstractions focussed on the domain solution. Martin argues that decisions related to detail components should be deferred for as long as possible, but he more broadly makes the case for change and readiness for change regardless of where the change comes from. He considers UI, DB, and frameworks in general to be details. So I embrace these ideas in the knowledge that I've already placed my bets on iOS. The principles of clean architecture, which you'll see laid out in our code below, will allow me to make such significant changes in a straightforward way.

## Clean Architecture
The color coding in the following diagrams adheres to the colors used in this public description of clean architecture. 

![Class](./README_files/clean_architecture.svg?raw=true "Clean architecture")

Each tier represents general areas of responsibility of components and the strict direction of their dependencies going from concrete volatile blue components down to the most abstract and stable yellow components. The outer layers know about any inner layers but not vice versa.

## App Screen Flow

![Class](./README_files/app_screen_flow.svg?raw=true "App Screen Flow")

## Root Composition

![Class](./README_files/root_composition.svg?raw=true "Root Composition")

## Scann QR Module

![Class](./README_files/scann_qr_module.svg?raw=true "Scann QR Module")

## Reference

[The Clean Code Blog (by Robert C. Martin (Uncle Bob))](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)

[Clean Architecture: A Craftsman's Guide to Software Structure and Design (by Robert C. Martin (Uncle Bob)](https://github.com/gmoral/Books/blob/master/Clean%20Architecture%20A%20Craftsman's%20Guide%20to%20-%20Robert%20C.%20Martin.epub)

[Domain-Driven Design (Eric Evans)](https://github.com/gmoral/Books/blob/master/Domain%20Driven%20Design%20Tackling%20Complexity%20in%20the%20Heart%20of%20Software%20-%20Eric%20Evans.pdf)

[Dependency Injection Principles, Practices, and Patterns (by Mark Seemann, Steven van Deursen)](https://github.com/gmoral/Books/blob/master/Dependency%20Injection%20-%20Principles%20Practices%20and%20Patterns%20-%20Steven%20van%20Deursen.epub)

[Head First Design Patterns: A Brain-Friendly Guide First Edition (by Eric Freeman, Bert Bates, Kathy Sierra, Elisabeth Robson)](https://github.com/gmoral/Books/blob/master/%5BO%60Reilly.%20Head%20First%5D%20-%20Head%20First%20Design%20Patterns%20-%20%5BFreeman%5D.pdf)


[Object-Oriented Software Engineering: A Use Case Driven Approach (by Ivar Jacobson)](https://www.amazon.com/Object-Oriented-Software-Engineering-Approach/dp/0201544350/ref=sr_1_1?crid=1HIMEP55YP51Z&keywords=ivar+Jacobson&qid=1682786667&sprefix=ivar+jacobson%2Caps%2C219&sr=8-1&ufe=app_do%3Aamzn1.fos.006c50ae-5d4c-4777-9bc0-4513d670b6bc)

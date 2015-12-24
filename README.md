# WS Coordination Protocols - Rails
This repository contains the web services protocols WS-Coordination and WS-Transaction implemented in my course competition assignment, which theme is *"web services and atomic transactions in distributed systems"*.

* **Rails version:** 4.2.5
* **Ruby version:** 2.2.1

## Systems
Four systems were implemented to simulate WS-Coordination and WS-Transaction protocols:
* **Bank:** every holder can have an account and many cards related to it. It has a web service used by the store to buy products through a card.

<p align="center">
  <img src="img/bank.png"/>
</p>

* **Provider:** provides products to the store through a web service.

<p align="center">
  <img src="img/provider.png"/>
</p>

* **Store:** sell products from multiple providers using their web services. Users can buy these products through a registered bank card.

<p align="center">
  <img src="img/provider.png"/>
</p>

* **Coordinator:** coordinator entity defined by WS-Coordinator and WS-Transaction. It implements both protocols, including *completion* and *two-phase commit* for WS-Transaction.

## Scripts

There are three scripts avaiable in the root of this project:

* **setup.sh:** run bundle install and create sqlite3 databases for all systems.
* **start.sh:** start all systems - store (port 3000), provider (port 3001), bank (port 3002) and coordinator (port 3003).
* **clear.sh:** delete all databases. After running this, is necessary to create all databases again.

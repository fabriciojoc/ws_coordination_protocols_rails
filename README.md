# WS Coordination Protocols - Rails
This repository contains the web services protocols WS-Coordination and WS-Transaction implemented in my course competition assignment, which theme is *"web services and atomic transactions in distributed systems"*.

* **Rails version:** 4.2.5
* **Ruby version:** 2.2.1

For more information, please read my [monograph](monograph.pdf).

## Systems
Four systems were implemented to simulate WS-Coordination and WS-Transaction protocols:
* **[Bank](https://github.com/fabriciojoc/ws_coordination_protocols_rails/tree/master/bank):** every holder can have an account and many cards related to it. It has a web service used by the store to buy products through a card.

<p align="center">
  <img src="img/bank.png"/>
</p>

* **[Provider](https://github.com/fabriciojoc/ws_coordination_protocols_rails/tree/master/provider):** provides products to the store through a web service.

<p align="center">
  <img src="img/provider.png"/>
</p>

* **[Store](https://github.com/fabriciojoc/ws_coordination_protocols_rails/tree/master/store-system):** sell products from multiple providers using their web services. Users can buy these products through a registered bank card.

<p align="center">
  <img src="img/provider.png"/>
</p>

* **[Coordinator](https://github.com/fabriciojoc/ws_coordination_protocols_rails/tree/master/coordinator):** coordinator entity defined by WS-Coordinator and WS-Transaction. It implements both protocols, including *completion* and *two-phase commit* for WS-Transaction.

## Scripts

There are three scripts avaiable in the root of this project:

* **[setup.sh](https://github.com/fabriciojoc/ws_coordination_protocols_rails/blob/master/setup.sh):** run bundle install and create sqlite3 databases for all systems.
* **[start.sh](https://github.com/fabriciojoc/ws_coordination_protocols_rails/blob/master/start.sh):** start all systems - store (port 3000), provider (port 3001), bank (port 3002) and coordinator (port 3003).
* **[clear.sh](https://github.com/fabriciojoc/ws_coordination_protocols_rails/blob/master/clear.sh):** delete all databases. After running this, is necessary to create all databases again.

## Gems

Some important gems used in this project:

* **[WashOut](https://github.com/inossidabile/wash_out):** creates a SOAP service provider.

* **[Savon](https://github.com/savonrb/savon):** SOAP client.

* **[Materialize](http://materializecss.com/):** front-end framework used by the store and coordinator.

## Future Work

Implement a SOAP client and server gem that supports WS-Coordination and WS-Transaction. Consequently it's necessary to implement a recovery algorithm that reads the transaction log and puts the system in a consistent state.

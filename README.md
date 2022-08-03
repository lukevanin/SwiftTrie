# Trie

Provides a pure Swift implementation of a general purpose Trie data structure.  
This package does not use any external dependencies.

A trie is useful where you need to access large quantities of data using a 
string. A trie is similar to a dictionary where values are associated with 
keys. One advantage that a trie provides is that is allows you to efficiently 
fetch multiple values whose keys begin with a given prefix. 

As an example use case, you have a collection of all of the cities on earth and 
you would the user to find all of the cities matching a prefix. 

For instance, assume the following entries:

* Alabama, US
* Albuquerque, US
* Anaheim, US
* Arizona, US
* Sydney, AU

If the given prefix is "A", all cities but Sydney should appear. Contrariwise, 
if the given prefix is "s", the only result should be "Sydney, AU".
If the given prefix is "Al", "Alabama, US" and "Albuquerque, US" are the only 
results.
If the prefix given is "Alb" then the only result is "Albuquerque, US"

## Installation

[TODO]

## Usage

[TODO]

## License

[TODO]

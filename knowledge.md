Knowledgebase IDL400
=========

Hardware
--------
There are 3 boxes with identical hardware:

- Inverto IDL400s (Inverto seems to be the originator of the hard- and software)
- GSS DSI400
- Telestar Digitbt R1


Features
---------
Currently there seems to be feature parity between the boxes.


Software
--------

Mainly 2 programs run on the box:

/root/s2i.bin:
Seems to be the backend for the minidlna server to drive the receivers.

Inside the /root/s2i.bin executable on the box are mentioned other boxes as well:
	DIGIBIT-%02X%02X%02X
	CINERGY-%02X%02X%02X
	GSSBOX-%02X%02X%02X
	Multibox-%02X%02X%02X
	Skystar-%02X%02X%02X
	MULTIBOX-%02X%02X%02X
	myMultibox-%02X%02X%02X

Which is the naming scheme for the boxes when in the local network with the last 3 bytes from the ethernet address as string.


/usr/sbin/minidlna:
Looks like this is serving the web/satip/dlna requests.


Firmware
--------

The boxes might get the current firmware from: http://s2i.inverto.tv/idl4k.bin.ota (ota == over the air ?) but currently there is a old firmware only (1.13)




Power consumption
-----------------


IDL400s and identical hardware (measured on a GSS DSI400 and a DIGIBIT R1 with V1.16.0.120 with 230V):

- 9.3 W (Gigabit ethernet)
- 6.2 W (100MBit ethernet)
- about 2 Watts per receiver when in use.

It seems that the ethernet chip is capable of supporting green ethernet standards, but the manufacture has not enabled that yet.


MegaSat 0600187 (Triax 400 & Zinwell 1800 contain same firmware, so probably have somewhat equal power use):

- 16.8 W when in use/idle (Gigabit ethernet)

Elgato Eytv 4Sat netstream:

- 16.2 W when in use (Gigabit ethernet)
- 6.7W when idle (Gigabit ethernet)











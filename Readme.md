SaltStack state for configure [netconsole](https://www.kernel.org/doc/Documentation/networking/netconsole.txtSaltStack ) in your infrastructure.
_Netconsole_ allows us to remotely monitor server crashes without order remote IP-KVM at the hosting.
It is very primitive module, therefore you need to set SOURCE port, SOURCE IP,  MAC address and so on.
As destination MAC address I use mac address of the default gateway. Even sender and receiver servers  are on the same network, pointing MAC address default gateway also successfully configures netconsole module.

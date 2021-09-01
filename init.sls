
{% if grains.oscodename != 'wheezy' %}

{%- from 'map.yaml' import netconsole %}
{%- from '_macros/netconsole.jinja' import netconsole_info %}

  {# some virtual servers have interface behind NAT => interface has only LAN ip #}
  {% if netconsole_info.public_ip != "empty"  and netconsole_info.public_int != "empty" %}

add_netconsole_module:
  kmod.present:
    - name: netconsole
    - persist: True

netconsole_config:
  file.managed:
    - name: "/etc/modprobe.d/netconsole.conf"
    - source: salt://netconsole/files/netconsole.conf.jinja
    - template: jinja

{# kmod.present load module without options, it doesn't suit #}
unload_netconsole_module:
  kmod.absent:
    - name: netconsole
    - onchanges:
      - file: netconsole_config

load_netconsole_module_with_options:
  cmd.run:
    - name: 'modprobe netconsole netconsole={{ netconsole.sender.port }}@{{ netconsole_info.public_ip }}/{{ netconsole_info.public_int }},{{ netconsole.receiver.port }}@{{ netconsole.receiver.ip }}/{{ netconsole_info.mac_gw }}'
    - onchanges:
      - file: netconsole_config

  {% endif %}
{% endif %}

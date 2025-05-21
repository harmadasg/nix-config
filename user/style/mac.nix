{ config, ... }:

{
    # TODO don't need mac specific settings if I use stylix.autoEnable=false
    # have to research which targets are enabled for me and make those settings explicit
    stylix.targets.gnome.enable = false;
}
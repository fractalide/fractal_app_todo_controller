{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.services.app_todo_controller;
  fractalide = import <fractalide> {};
  support = fractalide.support;
  edges = fractalide.edges;
  nodes = fractalide.nodes;
  fractal = import ./default.nix { inherit pkgs support edges nodes;
    fractalide = null;
  };
  serviceSubgraph = support.subgraph rec {
    src = ./.;
    name = "app_todo_controller_service";
    subnet = ''
    '${edges.net_http_edges.net_http_address}:(address="${cfg.bindAddress}:${toString cfg.port}")' -> listen controller(${fractal.nodes.controller})
    '${edges.prim_text}:(text="${cfg.request_get}:${toString cfg.request_get_port}")' -> request_get controller()
    '${edges.prim_text}:(text="${cfg.request_post}:${toString cfg.request_post_port}")' -> request_post controller()
    '${edges.prim_text}:(text="${cfg.request_delete}:${toString cfg.request_delete_port}")' -> request_delete controller()
    '${edges.prim_text}:(text="${cfg.request_patch}:${toString cfg.request_patch_port}")' -> request_patch controller()
    '${edges.prim_text}:(text="${cfg.response_get}:${toString cfg.response_get_port}")' -> response_get controller()
    '${edges.prim_text}:(text="${cfg.response_post}:${toString cfg.response_post_port}")' -> response_post controller()
    '${edges.prim_text}:(text="${cfg.response_delete}:${toString cfg.response_delete_port}")' -> response_delete controller()
    '${edges.prim_text}:(text="${cfg.response_patch}:${toString cfg.response_patch_port}")' -> response_patch controller()
    '';
  };
  fvm = import (<fractalide> + "/support/fvm/") {inherit pkgs support edges nodes;};
in
{
  options.services.app_todo_controller = {
    enable = mkEnableOption "Fractalide Workbench Example";
    package = mkOption {
      default = serviceSubnet;
      defaultText = "fractalComponents.app_todo_controller";
      type = types.package;
      description = ''
        Workbench example.
      '';
    };
    user = mkOption {
      type = types.str;
      default = "app_todo_controller";
      description = "User account under which app_todo_controller runs.";
    };
    bindAddress = mkOption {
      type = types.string;
      default = "127.0.0.1";
      description = ''
        Defines the IP address by which app_todo_controller will be accessible.
      '';
    };
    port = mkOption {
      type = types.int;
      default = 8080;
      description = ''
        Defined the port number to listen.
      '';
    };
    request_get = mkOption {
      type = types.string;
      default = "tcp://127.0.0.1";
      description = "HTTP REQUEST GET interface pin connection string";
    };
    request_get_port = mkOption {
      type = types.int;
      default = 5551;
      description = "HTTP REQUEST GET interface pin connection port";
    };
    request_post = mkOption {
      type = types.string;
      default = "tcp://127.0.0.1";
      description = "HTTP REQUEST POTS interface pin connection string";
    };
    request_post_port = mkOption {
      type = types.int;
      default = 5552;
      description = "HTTP REQUEST POST interface pin connection port";
    };
    request_delete = mkOption {
      type = types.string;
      default = "tcp://127.0.0.1";
      description = "HTTP REQUEST DELETE interface pin connection string";
    };
    request_delete_port = mkOption {
      type = types.int;
      default = 5553;
      description = "HTTP REQUEST DELETE interface pin connection port";
    };
    request_patch = mkOption {
      type = types.string;
      default = "tcp://127.0.0.1";
      description = "HTTP REQUEST PATCH interface pin connection string";
    };
    request_patch_port = mkOption {
      type = types.int;
      default = 5554;
      description = "HTTP REQUEST PATCH interface pin connection port";
    };
    response_get = mkOption {
      type = types.string;
      default = "tcp://127.0.0.1";
      description = "HTTP RESPONSE GET interface pin connection string";
    };
    response_get_port = mkOption {
      type = types.int;
      default = 5555;
      description = "HTTP RESPONSE GET interface pin connection port";
    };
    response_post = mkOption {
      type = types.string;
      default = "tcp://127.0.0.1";
      description = "HTTP RESPONSE POST interface pin connection string";
    };
    response_post_port = mkOption {
      type = types.int;
      default = 5556;
      description = "HTTP RESPONSE POST interface pin connection port";
    };
    response_delete = mkOption {
      type = types.string;
      default = "tcp://127.0.0.1";
      description = "HTTP RESPONSE DELETE interface pin connection string";
    };
    response_delete_port = mkOption {
      type = types.int;
      default = 5557;
      description = "HTTP RESPONSE DELETE interface pin connection port";
    };
    response_patch = mkOption {
      type = types.string;
      default = "tcp://127.0.0.1";
      description = "HTTP RESPONSE PATCH interface pin connection string";
    };
    response_patch_port = mkOption {
      type = types.int;
      default = 5558;
      description = "HTTP RESPONSE PATCH interface pin connection port";
    };
    openFirewall = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Whether to open ports in the firewall for the server.
      '';
    };
  };
  config = mkIf cfg.enable {
    networking.firewall = mkIf cfg.openFirewall {
      allowedTCPPorts = [
        cfg.port
        cfg.request_get_port
        cfg.request_post_port
        cfg.request_delete_port
        cfg.request_patch_port
        cfg.response_get_port
        cfg.response_post_port
        cfg.response_delete_port
        cfg.response_patch_port
      ];
    };
    users.extraUsers.app_todo_controller = {
      name = cfg.user;
      #uid = config.ids.uids.app_todo_controller;
      description = "Workbench database user";
    };
    systemd.services.app_todo_controller = {
      description = "Workbench example";
      path = [ cfg.package ];
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        PermissionsStartOnly = true;
        Restart = "always";
        ExecStart = "${fvm}/bin/fvm ${cfg.package}";
        User = cfg.user;
      };
    };
    environment.systemPackages = [ fvm cfg.package ];
  };
}

{ subgraph, nodes, edges }:

subgraph {
  src = ./.;
  flowscript = with nodes; with edges; ''
  listen => listen http(${net_http_nodes.http})

  request_get => connect request_get(${nanomsg_nodes.push})
  request_post => connect request_post(${nanomsg_nodes.push})
  request_delete => connect request_delete(${nanomsg_nodes.push})
  request_patch => connect request_patch(${nanomsg_nodes.push})

  response_get => connect response_get(${nanomsg_nodes.pull})
  response_post => connect response_post(${nanomsg_nodes.pull})
  response_delete => connect response_delete(${nanomsg_nodes.pull})
  response_patch => connect response_patch(${nanomsg_nodes.pull})

  http() GET[/todos/.+] -> ip request_get()
  response_get() ip -> response http()
  http() POST[/todos/?] -> ip request_post()
  response_post() ip -> response http()
  http() DELETE[/todos/.+] -> ip request_delete()
  response_delete() ip -> response http()
  http() PATCH[/todos/.+] -> ip request_patch()
  http() PUT[/todos/.+] -> ip request_patch()
  response_patch() ip -> response http()
  '';
}

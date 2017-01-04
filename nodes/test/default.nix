{ subgraph, nodes, edges }:

subgraph {
  src = ./.;
  edges = with edges; [ net_http_edges.net_http_address prim_text ];
  flowscript = with nodes; with edges; ''
  '${net_http_edges.net_http_address}:(address="127.0.0.1:8001")' -> listen controller(${controller})
  '${prim_text}:(text="tcp://127.0.0.1:5551")' -> request_get controller()
  '${prim_text}:(text="tcp://127.0.0.1:5552")' -> request_post controller()
  '${prim_text}:(text="tcp://127.0.0.1:5553")' -> request_delete controller()
  '${prim_text}:(text="tcp://127.0.0.1:5554")' -> request_patch controller()
  '${prim_text}:(text="tcp://127.0.0.1:5555")' -> response_get controller()
  '${prim_text}:(text="tcp://127.0.0.1:5556")' -> response_post controller()
  '${prim_text}:(text="tcp://127.0.0.1:5557")' -> response_delete controller()
  '${prim_text}:(text="tcp://127.0.0.1:5558")' -> response_patch controller()
  '';
}

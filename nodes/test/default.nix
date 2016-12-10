{ subgraph, nodes, edges }:

subgraph {
  src = ./.;
  flowscript = with nodes; with edges; ''
  '${net_http_edges.address}:(address="127.0.0.1:8001")' -> listen controller(${controller})
  '${generic_text}:(text="tcp://127.0.0.1:5551")' -> request_get controller()
  '${generic_text}:(text="tcp://127.0.0.1:5552")' -> request_post controller()
  '${generic_text}:(text="tcp://127.0.0.1:5553")' -> request_delete controller()
  '${generic_text}:(text="tcp://127.0.0.1:5554")' -> request_patch controller()
  '${generic_text}:(text="tcp://127.0.0.1:5555")' -> response_get controller()
  '${generic_text}:(text="tcp://127.0.0.1:5556")' -> response_post controller()
  '${generic_text}:(text="tcp://127.0.0.1:5557")' -> response_delete controller()
  '${generic_text}:(text="tcp://127.0.0.1:5558")' -> response_patch controller()
  '';
}

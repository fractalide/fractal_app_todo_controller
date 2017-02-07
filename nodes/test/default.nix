{ subgraph, imsgs, nodes, edges }:

subgraph rec {
  src = ./.;
  imsg = imsgs {
    edges = with edges; [NetHttpEdges.NetHttpAddress PrimText];
  };
  flowscript = with nodes; ''
  '${imsg}.NetHttpAddress:(address="127.0.0.1:8001")' -> listen controller(${controller})
  '${imsg}.PrimText:(text="tcp://127.0.0.1:5551")' -> request_get controller()
  '${imsg}.PrimText:(text="tcp://127.0.0.1:5552")' -> request_post controller()
  '${imsg}.PrimText:(text="tcp://127.0.0.1:5553")' -> request_delete controller()
  '${imsg}.PrimText:(text="tcp://127.0.0.1:5554")' -> request_patch controller()
  '${imsg}.PrimText:(text="tcp://127.0.0.1:5555")' -> response_get controller()
  '${imsg}.PrimText:(text="tcp://127.0.0.1:5556")' -> response_post controller()
  '${imsg}.PrimText:(text="tcp://127.0.0.1:5557")' -> response_delete controller()
  '${imsg}.PrimText:(text="tcp://127.0.0.1:5558")' -> response_patch controller()
  '';
}

{ subgraph, imsg, nodes, edges }:
let
  NetHttpAddress = imsg { class = edges.NetHttpEdges.NetHttpAddress; text = ''(address="127.0.0.1:8001")''; };
  PrimText1 = imsg { class = edges.PrimText; text = ''(text="tcp://127.0.0.1:5551")''; };
  PrimText2 = imsg { class = edges.PrimText; text = ''(text="tcp://127.0.0.1:5552")''; };
  PrimText3 = imsg { class = edges.PrimText; text = ''(text="tcp://127.0.0.1:5553")''; };
  PrimText4 = imsg { class = edges.PrimText; text = ''(text="tcp://127.0.0.1:5554")''; };
  PrimText5 = imsg { class = edges.PrimText; text = ''(text="tcp://127.0.0.1:5555")''; };
  PrimText6 = imsg { class = edges.PrimText; text = ''(text="tcp://127.0.0.1:5556")''; };
  PrimText7 = imsg { class = edges.PrimText; text = ''(text="tcp://127.0.0.1:5557")''; };
  PrimText8 = imsg { class = edges.PrimText; text = ''(text="tcp://127.0.0.1:5558")''; };
in
subgraph {
  src = ./.;
  flowscript = with nodes.rs; ''
  '${NetHttpAddress}' -> listen controller(${controller})
  '${PrimText1}' -> request_get controller()
  '${PrimText2}' -> request_post controller()
  '${PrimText3}' -> request_delete controller()
  '${PrimText4}' -> request_patch controller()
  '${PrimText5}' -> response_get controller()
  '${PrimText6}' -> response_post controller()
  '${PrimText7}' -> response_delete controller()
  '${PrimText8}' -> response_patch controller()
  '';
}

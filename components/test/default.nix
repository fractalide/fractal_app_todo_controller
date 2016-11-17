{ stdenv
  , buildFractalideSubnet
  , net_http_contracts
  , controller
  , generic_text
  , ...}:

buildFractalideSubnet rec {
  src = ./.;
  subnet = ''
  '${net_http_contracts.address}:(address="127.0.0.1:8001")' -> listen controller(${controller})
  '${generic_text}:(text="tcp://127.0.0.1:5551")' -> request_get controller()
  '${generic_text}:(text="tcp://127.0.0.1:5552")' -> request_post controller()
  '${generic_text}:(text="tcp://127.0.0.1:5553")' -> request_delete controller()
  '${generic_text}:(text="tcp://127.0.0.1:5554")' -> request_patch controller()
  '${generic_text}:(text="tcp://127.0.0.1:5555")' -> response_get controller()
  '${generic_text}:(text="tcp://127.0.0.1:5556")' -> response_post controller()
  '${generic_text}:(text="tcp://127.0.0.1:5557")' -> response_delete controller()
  '${generic_text}:(text="tcp://127.0.0.1:5558")' -> response_patch controller()
  '';

   meta = with stdenv.lib; {
    description = "Subnet: Counter app";
    homepage = https://github.com/fractalide/fractalide/tree/master/components/development/test;
    license = with licenses; [ mpl20 ];
    maintainers = with upkeepers; [ dmichiels sjmackenzie];
  };
}

{ stdenv, buildFractalideSubnet, upkeepers
  , workbench_nand
  , maths_boolean_print
  , workbench_boolean
  ,...}:

  buildFractalideSubnet rec {
   src = ./.;
   subnet = ''
   '${workbench_boolean}:(boolean=true)' -> a nand(${workbench_nand}) output -> input io_print(${maths_boolean_print})
   '${workbench_boolean}:(boolean=true)' -> b nand()
     '';

   meta = with stdenv.lib; {
    description = "Subnet: testing file for sjm";
    homepage = https://github.com/fractalide/fractalide/tree/master/components/test/sjm;
    license = with licenses; [ mpl20 ];
    maintainers = with upkeepers; [ dmichiels sjmackenzie];
  };
}